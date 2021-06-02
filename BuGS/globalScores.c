/*
 *  globalScores.c
 *  BuGS
 *
 * Created by Jeremy Rand on 2021-05-23.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#include <Hash.h>
#include <locator.h>
#include <misctool.h>
#include <stdint.h>
#include <tcpip.h>
#include <types.h>

#include "globalScores.h"
#include "tileData.h"

segment "highscores";

// Defines

#define REQUEST_TYPE_GET_HIGH_SCORES 0
#define REQUEST_TYPE_SET_SCORE 1

#define RESPONSE_TYPE_HELLO 0
#define RESPONSE_TYPE_SCORES 1
#define RESPONSE_TYPE_STATUS 2

#define GLOBAL_SCORE_REFRESH_TIME (15 * 60 * 60)


// Types

typedef struct tSessionSecrets {
    uint32_t secret;
    uint32_t nonce;
} tSessionSecrets;


typedef struct tHighScoreRequest {
    uint16_t requestType;
} tHighScoreRequest;


typedef struct tHighScoreRequestWithHash {
    tHighScoreRequest highScoreRequest;
    uint8_t md5Digest[16];
} tHighScoreRequestWithHash;


typedef struct tSetHighScoreRequest {
    uint16_t requestType;
    char who[4];
    uint32_t score;
    Boolean is60Hz;
} tSetHighScoreRequest;


typedef struct tSetHighScoreRequestWithHash {
    tSetHighScoreRequest setHighScoreRequest;
    uint8_t md5Digest[16];
} tSetHighScoreRequestWithHash;


typedef struct tHelloResponse {
    uint16_t responseType;
    uint32_t nonce;
} tHelloResponse;


typedef struct tScoresResponse {
    uint16_t responseType;
    tHighScore highScores[10];
} tScoresResponse;


typedef struct tStatusResponse {
    uint16_t responseType;
    Boolean success;
} tStatusResponse;


typedef enum tGameNetworkState {
    GAME_NETWORK_CONNECT_FAILED = 0,
    GAME_NETWORK_UNCONNECTED,
    
    /* All states below this should have Marinetti disconnected */
    GAME_NETWORK_CONNECTED,
    GAME_NETWORK_RESOLVING_NAME,
    
    /* These are all of the error states.  Marinetti is still connected but the
       TCP connection is closed and ipid released. */
    GAME_NETWORK_LOOKUP_FAILED,
    GAME_NETWORK_SOCKET_ERROR,
    GAME_NETWORK_PROTOCOL_FAILED,
    
    /* All of these states below here have an ipid open and the TCP connection is
        open and in some state. */
    GAME_NETWORK_WAITING_FOR_TCP,
    
    /* All of these states below this point have the TCP connection established
        and the score protocol is exchanging information. */
    GAME_NETWORK_WAITING_FOR_HELLO,
    GAME_NETWORK_REQUEST_SCORES,
    GAME_NETWORK_WAITING_FOR_SCORES,
    
    /* This is the "quiescent" state.  The hello has been retrieved and scores
        have been downloaded at least once.  This is the only state where a
        new high score can be uploaded safely. */
    GAME_NETWORK_SCORES_RETRIEVED,
} tGameNetworkState;


// Globals

Boolean networkToolsStarted = FALSE;
Boolean networkStartedConnected = FALSE;
Boolean hasGlobalHighScores = FALSE;
tGameNetworkState gameNetworkState = GAME_NETWORK_UNCONNECTED;

dnrBuffer domainNameResolution;
srBuff tcpStatus;

Word ipid;
rrBuff readResponseBuf;
tHelloResponse helloResponse;
uint32_t bytesRead = 0;

md5WorkBlock hashWorkBlock;
uint32_t secrets[3] = { NETWORK_SERVERSECRET1, NETWORK_SERVERSECRET2, 0 };
tHighScoreRequestWithHash highScoreRequest;
tScoresResponse highScoreResponse = {
    RESPONSE_TYPE_SCORES,
    {
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0},
        { { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '0'}, { 'A', 'A', 'A' }, 0}
    }
};

Word globalScoreAge = 0;


// Extern from assembly code

extern void waitForVbl(void);


// Implementation

#if 0
Word blah(void)
{
    // This is how to read the 50 or 60 Hz indicator:
    //      0 is 60 Hz
    //      1 is 50 Hz
    return ReadBParam(hrtz50or60);
}
#endif


void initNetwork(void)
{
    networkToolsStarted = FALSE;
    
    if ((NETWORK_SERVER == NULL) ||
        (NETWORK_SERVERPORT == 0))
        return;
    
    LoadOneTool(54, 0x200);     // Load Marinetti
    if (toolerror())
        return;
    
    LoadOneTool(128, 0x103);    // Load the Hash toolset
    if (toolerror()) {
        UnloadOneTool(54);
        return;
    }
    
    TCPIPStartUp();
    if (toolerror()) {
        UnloadOneTool(128);
        UnloadOneTool(54);
        return;
    }
    
    hashStartUp();
    if (toolerror()) {
        TCPIPShutDown();
        UnloadOneTool(128);
        UnloadOneTool(54);
        return;
    }
    
    networkToolsStarted = TRUE;
    
    networkStartedConnected = TCPIPGetConnectStatus();
    if (networkStartedConnected) {
        gameNetworkState = GAME_NETWORK_CONNECTED;
    } else {
        gameNetworkState = GAME_NETWORK_UNCONNECTED;
    }
}


void shutdownNetwork(void)
{
    if (!networkToolsStarted)
        return;
 
    if (gameNetworkState > GAME_NETWORK_WAITING_FOR_TCP) {
        int i = 30;
        TCPIPCloseTCP(ipid);
        while (i > 0) {
            waitForVbl();
            
            TCPIPPoll();
        
            if (TCPIPStatusTCP(ipid, &tcpStatus) != tcperrOK) {
                i = 0;
                break;
            }
            if (tcpStatus.srState == TCPSCLOSED)
                break;
            
            i--;
        }
        
        if (i == 0) {
            TCPIPAbortTCP(ipid);
        }
        
        TCPIPLogout(ipid);
    }
    
    if ((!networkStartedConnected) &&
        (gameNetworkState > GAME_NETWORK_UNCONNECTED)) {
        TCPIPDisconnect(TRUE, NULL);
    }
    
    hashShutDown();
    TCPIPShutDown();
    UnloadOneTool(128);     // Unload the Hash toolset
    UnloadOneTool(54);      // Unload Marinetti
}


void pollNetwork(void)
{
    Word errorCode;
    
    if (!networkToolsStarted)
        return;
    
    TCPIPPoll();
    
    switch (gameNetworkState) {
        case GAME_NETWORK_SOCKET_ERROR:
        case GAME_NETWORK_LOOKUP_FAILED:
        case GAME_NETWORK_CONNECT_FAILED:
        case GAME_NETWORK_PROTOCOL_FAILED:
            // If we end up in these error states, there is nothing more to do...
            break;
            
        case GAME_NETWORK_UNCONNECTED:
            TCPIPConnect(NULL);     // TODO - Perhaps no feedback here is not a good user experience and I should provide some kind of display function.
            if ((!toolerror()) &&
                (TCPIPGetConnectStatus())) {
                gameNetworkState = GAME_NETWORK_CONNECTED;
            } else {
                gameNetworkState = GAME_NETWORK_CONNECT_FAILED;
            }
            break;
            
        case GAME_NETWORK_CONNECTED:
            TCPIPDNRNameToIP("\p" NETWORK_SERVER, &domainNameResolution);
            if (toolerror())
                gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
            else
                gameNetworkState = GAME_NETWORK_RESOLVING_NAME;
            break;
        
        case GAME_NETWORK_RESOLVING_NAME:
            if (domainNameResolution.DNRstatus == DNR_Pending)
                break;
            
            if (domainNameResolution.DNRstatus != DNR_OK) {
                // TODO - I end up in here on the emulator.  Find out why.
                gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
                break;
            }
            
            ipid = TCPIPLogin(myUserId, domainNameResolution.DNRIPaddress, NETWORK_SERVERPORT, 0, 64);
            if (toolerror()) {
                gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            if (TCPIPOpenTCP(ipid) != tcperrOK) {
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            gameNetworkState = GAME_NETWORK_WAITING_FOR_TCP;
            break;
            
        case GAME_NETWORK_WAITING_FOR_TCP:
            if (TCPIPStatusTCP(ipid, &tcpStatus) != tcperrOK) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
            }
            if ((tcpStatus.srState == TCPSSYNSENT) ||
                (tcpStatus.srState == TCPSSYNRCVD))
                break;
            
            if (tcpStatus.srState != TCPSESTABLISHED) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
            }
            gameNetworkState = GAME_NETWORK_WAITING_FOR_HELLO;
            bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_HELLO:
            if (TCPIPReadTCP(ipid, 0, ((uint32_t)(&helloResponse)) + bytesRead, sizeof(helloResponse) - bytesRead, &readResponseBuf) != tcperrOK) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
            }
            
            bytesRead += readResponseBuf.rrBuffCount;
            if (bytesRead < sizeof(helloResponse))
                break;
            
            if (bytesRead > sizeof(helloResponse)) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
            }
            
            if (helloResponse.responseType != RESPONSE_TYPE_HELLO) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
            }
            
            gameNetworkState = GAME_NETWORK_REQUEST_SCORES;
            secrets[2] = helloResponse.nonce;
            
            break;
            
        case GAME_NETWORK_REQUEST_SCORES:
            highScoreRequest.highScoreRequest.requestType = REQUEST_TYPE_GET_HIGH_SCORES;
            
            md5Init(&hashWorkBlock);
            md5Append(&hashWorkBlock, (Pointer)&secrets, sizeof(secrets));
            md5Append(&hashWorkBlock, (Pointer)&(highScoreRequest.highScoreRequest), sizeof(highScoreRequest.highScoreRequest));
            md5Finish(&hashWorkBlock, &(highScoreRequest.md5Digest[0]));
            
            if (TCPIPWriteTCP(ipid, (Pointer)&highScoreRequest, sizeof(highScoreRequest), FALSE, FALSE) != tcperrOK) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
            }
            
            gameNetworkState = GAME_NETWORK_WAITING_FOR_SCORES;
            bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_SCORES:
            if (TCPIPReadTCP(ipid, 0, ((uint32_t)(&highScoreResponse)) + bytesRead, sizeof(highScoreResponse) - bytesRead, &readResponseBuf) != tcperrOK) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
            }
            
            bytesRead += readResponseBuf.rrBuffCount;
            if (bytesRead < sizeof(highScoreResponse))
                break;
            
            if (bytesRead > sizeof(highScoreResponse)) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
            }
            
            if (highScoreResponse.responseType != RESPONSE_TYPE_SCORES) {
                TCPIPAbortTCP(ipid);
                TCPIPLogout(ipid);
                gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
            }
            
            globalScoreAge = GLOBAL_SCORE_REFRESH_TIME;
            gameNetworkState = GAME_NETWORK_SCORES_RETRIEVED;
            hasGlobalHighScores = TRUE;
            break;
            
        case GLOBAL_SCORE_REFRESH_TIME:
            if (globalScoreAge == 0)
                gameNetworkState = GAME_NETWORK_REQUEST_SCORES;
            break;
    }
}
