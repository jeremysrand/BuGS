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

#include <stdio.h>
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
#define SHUTDOWN_NETWORK_TIMEOUT (2 * 60)
#define TCP_CONNECT_TIMEOUT (8 * 60)
#define READ_NETWORK_TIMEOUT (5 * 60)
#define NETWORK_RETRY_TIMEOUT (3 * 60 * 60)


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
    uint16_t position;
    uint16_t numberOfScores;
} tStatusResponse;


typedef enum tProtocolErrors {
    TCP_CONNECT_TIMEOUT_ERROR = 1,
    HELLO_TIMEOUT_ERROR,
    HELLO_TOO_BIG_ERROR,
    HELLO_UNEXPECTED_RESPONSE_ERROR,
    HIGH_SCORE_TIMEOUT_ERROR,
    HIGH_SCORE_TOO_BIG_ERROR,
    HIGH_SCORE_UNEXPECTED_RESPONSE_ERROR,
    SET_SCORE_TIMEOUT_ERROR,
    SET_SCORE_TOO_BIG_ERROR,
    SET_SCORE_UNEXPECTED_RESPONSE_ERROR,
    SET_SCORE_FAILED_ERROR,
} tProtocolErrors;


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
    uint16_t errorCode;
    uint16_t timeout;
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
char globalScoreInfo[GAME_NUM_TILES_WIDE + 1];


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


static void abortConnection(void)
{
    TCPIPAbortTCP(networkGlobals->ipid);
    TCPIPLogout(networkGlobals->ipid);
}


void disconnectNetwork(void)
{
    if (networkGlobals == NULL)
        return;
    
    if (networkGlobals->gameNetworkState > GAME_NETWORK_TCP_UNCONNECTED) {
        if (networkGlobals->gameNetworkState < GAME_NETWORK_CLOSING_TCP) {
            TCPIPCloseTCP(networkGlobals->ipid);
            networkGlobals->gameNetworkState = GAME_NETWORK_CLOSING_TCP;
            networkGlobals->timeout = SHUTDOWN_NETWORK_TIMEOUT;
        }
        
        while (networkGlobals->gameNetworkState > GAME_NETWORK_TCP_UNCONNECTED) {
            waitForVbl();
            pollNetwork();
        }
    }
}


static char hexDigitToAscii(Word digit)
{
    digit &= 0xf;
    if (digit < 10)
        return '0' + digit;
    
    if (digit > 15)
        return 'X';
    
    return 'A' + digit - 10;
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
    
    highScoreResponse.highScores[7].scoreText[0] = 'C';
    highScoreResponse.highScores[7].scoreText[1] = 'O';
    highScoreResponse.highScores[7].scoreText[2] = 'D';
    highScoreResponse.highScores[7].scoreText[3] = 'E';
    highScoreResponse.highScores[7].scoreText[4] = ':';
    highScoreResponse.highScores[7].scoreText[5] = ' ';
    highScoreResponse.highScores[7].scoreText[6] = hexDigitToAscii(networkGlobals->errorCode >> 12);
    highScoreResponse.highScores[7].scoreText[7] = hexDigitToAscii(networkGlobals->errorCode >> 8);
    highScoreResponse.highScores[7].scoreText[8] = hexDigitToAscii(networkGlobals->errorCode >> 4);
    highScoreResponse.highScores[7].scoreText[9] = hexDigitToAscii(networkGlobals->errorCode);
    
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
            networkGlobals->timeout = NETWORK_RETRY_TIMEOUT;
            break;
            
        case GAME_NETWORK_LOOKUP_FAILED:
            displayNetworkError("LOOKUP", "FAILED");
            break;
            
        case GAME_NETWORK_CONNECT_FAILED:
            displayNetworkError("CONNECT", "FAILED");
            networkGlobals->timeout = NETWORK_RETRY_TIMEOUT;
            break;
            
        case GAME_NETWORK_PROTOCOL_FAILED:
            abortConnection();
            displayNetworkError("PROTOCOL", "FAILED");
            networkGlobals->timeout = NETWORK_RETRY_TIMEOUT;
            break;
            
        case GAME_NETWORK_FAILURE:
            // All of the different failure modes except protocol failure above end up here ultimately.  And the state
            // machine stays here once it arrives here.
            if (networkGlobals->timeout > 0) {
                networkGlobals->timeout--;
                if (networkGlobals->timeout == 0)
                    networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
            }
            break;
            
        case GAME_NETWORK_UNCONNECTED:
            displayConnectionString();
            TCPIPConnect(NULL);
            if ((!toolerror()) &&
                (TCPIPGetConnectStatus())) {
                networkGlobals->gameNetworkState = GAME_NETWORK_CONNECTED;
            } else {
                networkGlobals->gameNetworkState = GAME_NETWORK_CONNECT_FAILED;
            }
            break;
            
        case GAME_NETWORK_CONNECTED:
            TCPIPDNRNameToIP("\p" NETWORK_SERVER, &(networkGlobals->domainNameResolution));
            if (toolerror()) {
                networkGlobals->gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
                networkGlobals->errorCode = toolerror();
            } else
                networkGlobals->gameNetworkState = GAME_NETWORK_RESOLVING_NAME;
            break;
        
        case GAME_NETWORK_RESOLVING_NAME:
            if (networkGlobals->domainNameResolution.DNRstatus == DNR_Pending)
                break;
            
            if (networkGlobals->domainNameResolution.DNRstatus != DNR_OK) {
                networkGlobals->gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
                networkGlobals->errorCode = networkGlobals->domainNameResolution.DNRstatus;
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
                networkGlobals->errorCode = toolerror();
                break;
            }
            
            networkGlobals->errorCode = TCPIPOpenTCP(networkGlobals->ipid);
            if (networkGlobals->errorCode != tcperrOK) {
                TCPIPLogout(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_TCP;
            networkGlobals->timeout = TCP_CONNECT_TIMEOUT;
            break;
            
        case GAME_NETWORK_WAITING_FOR_TCP:
            networkGlobals->errorCode = TCPIPStatusTCP(networkGlobals->ipid, &(networkGlobals->tcpStatus));
            if (networkGlobals->errorCode != tcperrOK) {
                abortConnection();
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            if ((networkGlobals->tcpStatus.srState == TCPSSYNSENT) ||
                (networkGlobals->tcpStatus.srState == TCPSSYNRCVD)) {
                    if (networkGlobals->timeout > 0) {
                        networkGlobals->timeout--;
                    } else {
                        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                        networkGlobals->errorCode = TCP_CONNECT_TIMEOUT_ERROR;
                    }
                break;
            }
            
            if (networkGlobals->tcpStatus.srState != TCPSESTABLISHED) {
                abortConnection();
                networkGlobals->errorCode = networkGlobals->tcpStatus.srState | 0x8000;
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_HELLO;
            networkGlobals->timeout = READ_NETWORK_TIMEOUT;
            networkGlobals->bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_HELLO:
            networkGlobals->errorCode = TCPIPReadTCP(networkGlobals->ipid, 0,
                                                     ((uint32_t)(&(networkGlobals->helloResponse))) + networkGlobals->bytesRead,
                                                     sizeof(networkGlobals->helloResponse) - networkGlobals->bytesRead,
                                                     &(networkGlobals->readResponseBuf));
            if (networkGlobals->errorCode != tcperrOK) {
                abortConnection();
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
            if (networkGlobals->bytesRead < sizeof(networkGlobals->helloResponse)) {
                if (networkGlobals->timeout > 0) {
                    networkGlobals->timeout--;
                } else {
                    networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                    networkGlobals->errorCode = HELLO_TIMEOUT_ERROR;
                }
                break;
            }
            
            if (networkGlobals->bytesRead > sizeof(networkGlobals->helloResponse)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = HELLO_TOO_BIG_ERROR;
                break;
            }
            
            if (networkGlobals->helloResponse.responseType != RESPONSE_TYPE_HELLO) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = HELLO_UNEXPECTED_RESPONSE_ERROR;
                break;
            }
            
            networkGlobals->secrets[2] = networkGlobals->helloResponse.nonce;
            if (networkGlobals->hasHighScoreToSend) {
                networkGlobals->gameNetworkState = GAME_NETWORK_SET_HIGH_SCORE;
            } else if ((!hasGlobalHighScores) ||
                       (globalScoreAge == 0)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_REQUEST_SCORES;
            } else {
                TCPIPCloseTCP(networkGlobals->ipid);
                networkGlobals->gameNetworkState = GAME_NETWORK_CLOSING_TCP;
                networkGlobals->timeout = SHUTDOWN_NETWORK_TIMEOUT;
            }
            break;
            
        case GAME_NETWORK_REQUEST_SCORES:
            networkGlobals->highScoreRequest.highScoreRequest.requestType = REQUEST_TYPE_GET_HIGH_SCORES;
            
            md5Init(&(networkGlobals->hashWorkBlock));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->secrets), sizeof(networkGlobals->secrets));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->highScoreRequest.highScoreRequest), sizeof(networkGlobals->highScoreRequest.highScoreRequest));
            md5Finish(&(networkGlobals->hashWorkBlock), &(networkGlobals->highScoreRequest.md5Digest[0]));
            
            networkGlobals->errorCode = TCPIPWriteTCP(networkGlobals->ipid, (Pointer)&(networkGlobals->highScoreRequest), sizeof(networkGlobals->highScoreRequest), FALSE, FALSE);
            if (networkGlobals->errorCode != tcperrOK) {
                abortConnection();
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_SCORES;
            networkGlobals->timeout = READ_NETWORK_TIMEOUT;
            networkGlobals->bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_SCORES:
            networkGlobals->errorCode = TCPIPReadTCP(networkGlobals->ipid, 0,
                                                     ((uint32_t)(&highScoreResponse)) + networkGlobals->bytesRead,
                                                     sizeof(highScoreResponse) - networkGlobals->bytesRead,
                                                     &(networkGlobals->readResponseBuf));
            if (networkGlobals->errorCode != tcperrOK) {
                abortConnection();
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
            if (networkGlobals->bytesRead < sizeof(highScoreResponse)) {
                if (networkGlobals->timeout > 0) {
                    networkGlobals->timeout--;
                } else {
                    networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                    networkGlobals->errorCode = HIGH_SCORE_TIMEOUT_ERROR;
                }
                break;
            }
            
            if (networkGlobals->bytesRead > sizeof(highScoreResponse)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = HIGH_SCORE_TOO_BIG_ERROR;
                break;
            }
            
            if (highScoreResponse.responseType != RESPONSE_TYPE_SCORES) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = HIGH_SCORE_UNEXPECTED_RESPONSE_ERROR;
                break;
            }
            
            globalScoreAge = GLOBAL_SCORE_REFRESH_TIME;
            hasGlobalHighScores = TRUE;
            
            TCPIPCloseTCP(networkGlobals->ipid);
            networkGlobals->gameNetworkState = GAME_NETWORK_CLOSING_TCP;
            networkGlobals->timeout = SHUTDOWN_NETWORK_TIMEOUT;
            break;
            
        case GAME_NETWORK_SET_HIGH_SCORE:
            setHighScoreRequest.setHighScoreRequest.requestType = REQUEST_TYPE_SET_SCORE;
            setHighScoreRequest.setHighScoreRequest.who[3] = '\0';
            
            md5Init(&(networkGlobals->hashWorkBlock));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->secrets), sizeof(networkGlobals->secrets));
            md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(setHighScoreRequest.setHighScoreRequest), sizeof(setHighScoreRequest.setHighScoreRequest));
            md5Finish(&(networkGlobals->hashWorkBlock), &(setHighScoreRequest.md5Digest[0]));
            
            networkGlobals->errorCode = TCPIPWriteTCP(networkGlobals->ipid, (Pointer)&setHighScoreRequest, sizeof(setHighScoreRequest), FALSE, FALSE);
            if (networkGlobals->errorCode != tcperrOK) {
                abortConnection();
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_SCORE_ACK;
            networkGlobals->timeout = READ_NETWORK_TIMEOUT;
            networkGlobals->bytesRead = 0;
            break;
            
        case GAME_NETWORK_WAITING_FOR_SCORE_ACK:
            networkGlobals->errorCode = TCPIPReadTCP(networkGlobals->ipid, 0,
                                                     ((uint32_t)(&(networkGlobals->setHighScoreResponse))) + networkGlobals->bytesRead,
                                                     sizeof(networkGlobals->setHighScoreResponse) - networkGlobals->bytesRead,
                                                     &(networkGlobals->readResponseBuf));
            if (networkGlobals->errorCode != tcperrOK) {
                abortConnection();
                networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
                break;
            }
            
            networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
            if (networkGlobals->bytesRead < sizeof(networkGlobals->setHighScoreResponse)) {
                if (networkGlobals->timeout > 0) {
                    networkGlobals->timeout--;
                } else {
                    networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                    networkGlobals->errorCode = SET_SCORE_TIMEOUT_ERROR;
                }
                break;
            }
            
            if (networkGlobals->bytesRead > sizeof(networkGlobals->setHighScoreResponse)) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = SET_SCORE_TOO_BIG_ERROR;
                break;
            }
            
            if (networkGlobals->setHighScoreResponse.responseType != RESPONSE_TYPE_STATUS) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = SET_SCORE_UNEXPECTED_RESPONSE_ERROR;
                break;
            }
            
            if (!networkGlobals->setHighScoreResponse.success) {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = SET_SCORE_FAILED_ERROR;
                break;
            }
            
            networkGlobals->hasHighScoreToSend = FALSE;
            globalScoreAge = 0;
            networkGlobals->gameNetworkState = GAME_NETWORK_REQUEST_SCORES;
            break;
            
        case GAME_NETWORK_CLOSING_TCP:
            networkGlobals->errorCode = TCPIPStatusTCP(networkGlobals->ipid, &(networkGlobals->tcpStatus));
            if ((networkGlobals->tcpStatus.srState != TCPSCLOSED) &&
                (networkGlobals->tcpStatus.srState != TCPSTIMEWAIT)) {
                if (networkGlobals->timeout > 0) {
                    networkGlobals->timeout--;
                } else {
                    abortConnection();
                    networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
                }
                break;
            }
            
            TCPIPLogout(networkGlobals->ipid);
            networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
            break;
    }
}


BOOLEAN canSendHighScore(void)
{
    if (networkGlobals == NULL)
        return FALSE;
    
    if (networkGlobals->gameNetworkState < GAME_NETWORK_TCP_UNCONNECTED) {
        if ((networkGlobals->gameNetworkState == GAME_NETWORK_FAILURE) &&
            (networkGlobals->timeout > 0))
            return TRUE;
        
        return FALSE;
    }
    
    return TRUE;
}

BOOLEAN sendHighScore(void)
{
    uint16_t cycleCount = 0;
    
    networkGlobals->hasHighScoreToSend = TRUE;
    
    if (networkGlobals->gameNetworkState < GAME_NETWORK_TCP_UNCONNECTED)
        networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
    
    do {
        waitForVbl();
        pollNetwork();
        cycleCount++;
        
        if ((cycleCount & 0x7) == 0) {
            switch (cycleCount & 0x18) {
                case 0x00:
                    uploadSpin1();
                    break;
                    
                case 0x08:
                    uploadSpin2();
                    break;
                    
                case 0x10:
                    uploadSpin3();
                    break;
                    
                case 0x18:
                    uploadSpin2();
                    break;
            }
        }
    } while (networkGlobals->gameNetworkState > GAME_NETWORK_TCP_UNCONNECTED);
    
    if (networkGlobals->gameNetworkState != GAME_NETWORK_TCP_UNCONNECTED)
        return FALSE;
    
    sprintf(globalScoreInfo, "  %u OF %u SCORES", networkGlobals->setHighScoreResponse.position, networkGlobals->setHighScoreResponse.numberOfScores);
    for (cycleCount = strlen(globalScoreInfo); cycleCount < sizeof(globalScoreInfo); cycleCount++) {
        globalScoreInfo[cycleCount] = ' ';
    }
    globalScoreInfo[GAME_NUM_TILES_WIDE] = '\0';
    displayScorePosition();
    
    for (cycleCount = 4 * 60; cycleCount > 0; cycleCount--) {
        waitForVbl();
    }
    
    return TRUE;
}
