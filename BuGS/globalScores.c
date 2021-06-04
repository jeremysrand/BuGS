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

#include <stdlib.h>

#include "game.h"
#include "globalScores.h"
#include "tileData.h"


// Defines

#define REQUEST_TYPE_GET_HIGH_SCORES 0
#define REQUEST_TYPE_SET_SCORE 1

#define RESPONSE_TYPE_HELLO 0
#define RESPONSE_TYPE_SCORES 1
#define RESPONSE_TYPE_STATUS 2

#define GLOBAL_SCORE_REFRESH_TIME (15 * 60 * 60)
#define SET_SCORE_TIMEOUT (20 * 60)
#define SHUTDOWN_NETWORK_TIMEOUT (60 / 2)


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
    Word is60Hz;
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
    GAME_NETWORK_FAILURE,
    
    /* This is the state we are in during a game on a machine with a working network
        (other possible states are fail states). */
    GAME_NETWORK_TCP_UNCONNECTED,
    
    /* All of these states below here have an ipid open and the TCP connection is
        open and in some state. */
    GAME_NETWORK_WAITING_FOR_TCP,
    
    /* All of these states below this point have the TCP connection established
        and the score protocol is exchanging information. */
    GAME_NETWORK_WAITING_FOR_HELLO,
    GAME_NETWORK_REQUEST_SCORES,
    GAME_NETWORK_WAITING_FOR_SCORES,
    GAME_NETWORK_SET_HIGH_SCORE,
    GAME_NETWORK_WAITING_FOR_SCORE_ACK,
    
    GAME_NETWORK_CLOSING_TCP,
} tGameNetworkState;

typedef struct tGameNetworkGlobals {
    Boolean networkStartedConnected;
    tGameNetworkState gameNetworkState;
    dnrBuffer domainNameResolution;
    srBuff tcpStatus;
    Word ipid;
    rrBuff readResponseBuf;
    tHelloResponse helloResponse;
    uint32_t bytesRead;
    md5WorkBlock hashWorkBlock;
    uint32_t secrets[3];
    tHighScoreRequestWithHash highScoreRequest;
    Boolean hasHighScoreToSend;
    tStatusResponse setHighScoreResponse;
} tGameNetworkGlobals;


// Globals

// I am running out of space in the main segment so I am moving these globals into
// a dynamically allocated struct.  It is only allocated if network capabilities are
// detected.
static tGameNetworkGlobals * networkGlobals = NULL;

// The following globals are accessed by name from assembly so are not in the
// tGameNetworkGlobals structure.
Boolean hasGlobalHighScores = FALSE;
tScoresResponse highScoreResponse;
Word globalScoreAge = 0;
tSetHighScoreRequestWithHash setHighScoreRequest;


// Implementation


segment "highscores";

void initNetwork(void)
{
    networkGlobals = NULL;
    
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
    
    networkGlobals = malloc(sizeof(tGameNetworkGlobals));
    if (networkGlobals == NULL) {
        hashShutDown();
        TCPIPShutDown();
        UnloadOneTool(128);
        UnloadOneTool(54);
        return;
        
    }
    
    networkGlobals->networkStartedConnected = TCPIPGetConnectStatus();
    if (networkGlobals->networkStartedConnected) {
        networkGlobals->gameNetworkState = GAME_NETWORK_CONNECTED;
    } else {
        networkGlobals->gameNetworkState = GAME_NETWORK_UNCONNECTED;
    }
    
    networkGlobals->secrets[0] = NETWORK_SERVERSECRET1;
    networkGlobals->secrets[1] = NETWORK_SERVERSECRET2;
    
    networkGlobals->hasHighScoreToSend = FALSE;
    
    setHighScoreRequest.setHighScoreRequest.is60Hz = !ReadBParam(hrtz50or60);
}


void shutdownNetwork(void)
{
    if (networkGlobals == NULL)
        return;
 
    if (networkGlobals->gameNetworkState > GAME_NETWORK_TCP_UNCONNECTED) {
        int timeout = SHUTDOWN_NETWORK_TIMEOUT;
        TCPIPCloseTCP(networkGlobals->ipid);
        while (timeout > 0) {
            waitForVbl();
            
            TCPIPPoll();
        
            if (TCPIPStatusTCP(networkGlobals->ipid, &(networkGlobals->tcpStatus)) != tcperrOK) {
                timeout = 0;
                break;
            }
            if (networkGlobals->tcpStatus.srState == TCPSCLOSED)
                break;
            
            timeout--;
        }
        
        if (timeout == 0) {
            TCPIPAbortTCP(networkGlobals->ipid);
        }
        
        TCPIPLogout(networkGlobals->ipid);
    }
    
    if ((!networkGlobals->networkStartedConnected) &&
        (networkGlobals->gameNetworkState > GAME_NETWORK_UNCONNECTED)) {
        TCPIPDisconnect(TRUE, NULL);
    }
    
    free(networkGlobals);
    
    hashShutDown();
    TCPIPShutDown();
    UnloadOneTool(128);     // Unload the Hash toolset
    UnloadOneTool(54);      // Unload Marinetti
}


static void displayString(Word row, char * string)
{
    strcpy(&(highScoreResponse.highScores[row].scoreText[2]), string);
}

static void displayNetworkError(char * line1, char * line2)
{
    Word row;
    Word column;
    
    networkGlobals->gameNetworkState = GAME_NETWORK_FAILURE;
    
    for (row = 0; row < sizeof(highScoreResponse.highScores) / sizeof(highScoreResponse.highScores[0]); row++) {
        for (column = 0;
             column < sizeof(highScoreResponse.highScores[0].scoreText) / sizeof(highScoreResponse.highScores[0].scoreText[0]);
             column++) {
            highScoreResponse.highScores[row].scoreText[column] = ' ';
        }
        for (column = 0;
             column < sizeof(highScoreResponse.highScores[0].who) / sizeof(highScoreResponse.highScores[0].who[0]);
             column++) {
            highScoreResponse.highScores[row].who[column] = ' ';
        }
    }
    
    displayString(1, "NETWORK");
    displayString(2, "PROBLEM");
    
    displayString(4, line1);
    displayString(5, line2);
    
    globalScoreAge = 0;
    hasGlobalHighScores = TRUE;
}


void pollNetwork(void)
{
    if (networkGlobals == NULL)
        return;
    
    TCPIPPoll();
    
    switch (networkGlobals->gameNetworkState) {
        case GAME_NETWORK_SOCKET_ERROR:
            displayNetworkError("SOCKET", "ERROR");
            break;
            
        case GAME_NETWORK_LOOKUP_FAILED:
            displayNetworkError("LOOKUP", "FAILED");
            break;
            
        case GAME_NETWORK_CONNECT_FAILED:
            displayNetworkError("CONNECT", "FAILED");
            break;
            
        case GAME_NETWORK_PROTOCOL_FAILED:
            TCPIPCloseTCP(networkGlobals->ipid);
            displayNetworkError("PROTOCOL", "FAILED");
            globalScoreAge = GLOBAL_SCORE_REFRESH_TIME;
            networkGlobals->gameNetworkState = GAME_NETWORK_CLOSING_TCP;
            break;
            
        case GAME_NETWORK_FAILURE:
            // All of the different failure modes except protocol failure above end up here ultimately.  And the state
            // machine stays here once it arrives here.
            break;
            
        case GAME_NETWORK_UNCONNECTED:
            TCPIPConnect(NULL);     // TODO - Perhaps some feedback here would be a better user experience so maybe I should provide some kind of display function.
            if ((!toolerror()) &&
                (TCPIPGetConnectStatus())) {
                networkGlobals->gameNetworkState = GAME_NETWORK_CONNECTED;
            } else {
                networkGlobals->gameNetworkState = GAME_NETWORK_CONNECT_FAILED;
            }
            break;
            
        case GAME_NETWORK_CONNECTED:
            TCPIPDNRNameToIP("\p" NETWORK_SERVER, &(networkGlobals->domainNameResolution));
            if (toolerror())
                networkGlobals->gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
            else
                networkGlobals->gameNetworkState = GAME_NETWORK_RESOLVING_NAME;
            break;
        
        case GAME_NETWORK_RESOLVING_NAME:
            if (networkGlobals->domainNameResolution.DNRstatus == DNR_Pending)
                break;
            
            if (networkGlobals->domainNameResolution.DNRstatus != DNR_OK) {
                networkGlobals->gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
                break;
            }
            
            networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
            break;
        
        case GAME_NETWORK_TCP_UNCONNECTED:
            if ((hasGlobalHighScores) &&
                (globalScoreAge > 0) &&
                (!networkGlobals->hasHighScoreToSend))
                break;
            
            networkGlobals->ipid = TCPIPLogin(myUserId, networkGlobals->domainNameResolution.DNRIPaddress, NETWORK_SERVERPORT, 0, 64);
            if (toolerror()) {
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            if (TCPIPOpenTCP(networkGlobals->ipid) != tcperrOK) {
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_TCP;
            break;
            
        case GAME_NETWORK_WAITING_FOR_TCP:
            if (TCPIPStatusTCP(networkGlobals->ipid, &(networkGlobals->tcpStatus)) != tcperrOK) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            if ((networkGlobals->tcpStatus.srState == TCPSSYNSENT) ||
                (networkGlobals->tcpStatus.srState == TCPSSYNRCVD))
                break;
            
            if (networkGlobals->tcpStatus.srState != TCPSESTABLISHED) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_HELLO;
            networkGlobals->bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_HELLO:
            if (TCPIPReadTCP(networkGlobals->ipid, 0,
                    ((uint32_t)(&(networkGlobals->helloResponse))) + networkGlobals->bytesRead,
                    sizeof(networkGlobals->helloResponse) - networkGlobals->bytesRead,
                    &(networkGlobals->readResponseBuf)) != tcperrOK) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
            if (networkGlobals->bytesRead < sizeof(networkGlobals->helloResponse))
                break;
            
            if (networkGlobals->bytesRead > sizeof(networkGlobals->helloResponse)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                break;
            }
            
            if (networkGlobals->helloResponse.responseType != RESPONSE_TYPE_HELLO) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                break;
            }
            
            networkGlobals->secrets[2] = networkGlobals->helloResponse.nonce;
            if (networkGlobals->hasHighScoreToSend) {
                networkGlobals->gameNetworkState = GAME_NETWORK_SET_HIGH_SCORE;
            } else if ((!hasGlobalHighScores) ||
                       (globalScoreAge == 0)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_REQUEST_SCORES;
            } else {
                networkGlobals->gameNetworkState = GAME_NETWORK_CLOSING_TCP;
            }
            break;
            
        case GAME_NETWORK_REQUEST_SCORES:
            networkGlobals->highScoreRequest.highScoreRequest.requestType = REQUEST_TYPE_GET_HIGH_SCORES;
            
            md5Init(&(networkGlobals->hashWorkBlock));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->secrets), sizeof(networkGlobals->secrets));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->highScoreRequest.highScoreRequest), sizeof(networkGlobals->highScoreRequest.highScoreRequest));
            md5Finish(&(networkGlobals->hashWorkBlock), &(networkGlobals->highScoreRequest.md5Digest[0]));
            
            if (TCPIPWriteTCP(networkGlobals->ipid, (Pointer)&(networkGlobals->highScoreRequest), sizeof(networkGlobals->highScoreRequest), FALSE, FALSE) != tcperrOK) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_SCORES;
            networkGlobals->bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_SCORES:
            if (TCPIPReadTCP(networkGlobals->ipid, 0,
                    ((uint32_t)(&highScoreResponse)) + networkGlobals->bytesRead,
                    sizeof(highScoreResponse) - networkGlobals->bytesRead,
                    &(networkGlobals->readResponseBuf)) != tcperrOK) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
            if (networkGlobals->bytesRead < sizeof(highScoreResponse))
                break;
            
            if (networkGlobals->bytesRead > sizeof(highScoreResponse)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                break;
            }
            
            if (highScoreResponse.responseType != RESPONSE_TYPE_SCORES) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                break;
            }
            
            globalScoreAge = GLOBAL_SCORE_REFRESH_TIME;
            hasGlobalHighScores = TRUE;
            
            TCPIPCloseTCP(networkGlobals->ipid);
            networkGlobals->gameNetworkState = GAME_NETWORK_CLOSING_TCP;
            break;
            
        case GAME_NETWORK_SET_HIGH_SCORE:
            setHighScoreRequest.setHighScoreRequest.requestType = REQUEST_TYPE_SET_SCORE;
            setHighScoreRequest.setHighScoreRequest.who[3] = '\0';
            
            md5Init(&(networkGlobals->hashWorkBlock));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->secrets), sizeof(networkGlobals->secrets));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(setHighScoreRequest.setHighScoreRequest), sizeof(setHighScoreRequest.setHighScoreRequest));
            md5Finish(&(networkGlobals->hashWorkBlock), &(setHighScoreRequest.md5Digest[0]));
            
            if (TCPIPWriteTCP(networkGlobals->ipid, (Pointer)&setHighScoreRequest, sizeof(setHighScoreRequest), FALSE, FALSE) != tcperrOK) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_SCORE_ACK;
            networkGlobals->bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_SCORE_ACK:
            if (TCPIPReadTCP(networkGlobals->ipid, 0,
                    ((uint32_t)(&(networkGlobals->setHighScoreResponse))) + networkGlobals->bytesRead,
                    sizeof(networkGlobals->setHighScoreResponse) - networkGlobals->bytesRead,
                    &(networkGlobals->readResponseBuf)) != tcperrOK) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
            if (networkGlobals->bytesRead < sizeof(networkGlobals->setHighScoreResponse))
                break;
            
            if (networkGlobals->bytesRead > sizeof(networkGlobals->setHighScoreResponse)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                break;
            }
            
            if (networkGlobals->setHighScoreResponse.responseType != RESPONSE_TYPE_STATUS) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                break;
            }
            
            if (!networkGlobals->setHighScoreResponse.success) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                break;
            }
            
            networkGlobals->hasHighScoreToSend = FALSE;
            globalScoreAge = 0;
            networkGlobals->gameNetworkState = GAME_NETWORK_REQUEST_SCORES;
            break;
            
        case GAME_NETWORK_CLOSING_TCP:
            if (TCPIPStatusTCP(networkGlobals->ipid, &(networkGlobals->tcpStatus)) != tcperrOK) {
                TCPIPAbortTCP(networkGlobals->ipid);
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            if ((networkGlobals->tcpStatus.srState != TCPSCLOSED) &&
                (networkGlobals->tcpStatus.srState != TCPSTIMEWAIT))
                break;
            
            TCPIPLogout(networkGlobals->ipid);
            networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
            break;
    }
}


void sendHighScore(void)
{
    int timeout = SET_SCORE_TIMEOUT;
    
    if (networkGlobals == NULL)
        return;
    
    if (networkGlobals->gameNetworkState < GAME_NETWORK_TCP_UNCONNECTED)
        return;
    
    networkGlobals->hasHighScoreToSend = TRUE;
    
    do {
        waitForVbl();
        pollNetwork();
        timeout--;
        if (timeout == 0)
            return;
    } while (networkGlobals->gameNetworkState > GAME_NETWORK_TCP_UNCONNECTED);
}
