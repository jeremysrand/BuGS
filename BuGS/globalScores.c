/*
 *  globalScores.c
 *  BuGS
 *
 * Created by Jeremy Rand on 2021-05-23.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include <Hash.h>
#include <locator.h>
#include <misctool.h>
#include <orca.h>
#include <tcpip.h>

#include "globalScores.h"


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
    tHighScores highScores;
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
    
    NUM_GAME_NETWORK_STATES
} tGameNetworkState;

typedef void (*tGameNetworkStateHandler)(void);

typedef struct tGameNetworkGlobals {
    Boolean networkStartedConnected;
    tHighScoreInitParams initParams;
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

// Forward declarations

static void handleConnectFailed(void);
static void handleUnconnected(void);
static void handleConnected(void);
static void handleResolvingName(void);
static void handleLookupFailed(void);
static void handleSocketError(void);
static void handleProtocolFailed(void);
static void handleFailure(void);
static void handleTcpUnconnected(void);
static void handleWaitingForTcp(void);
static void handleWaitingForHello(void);
static void handleRequestScores(void);
static void handleWaitingForScores(void);
static void handleSetHighScore(void);
static void handleWaitingForScoreAck(void);
static void handleClosingTcp(void);

// Globals

#if __ORCAC__
segment "highscores";
#endif

static tGameNetworkStateHandler handlers[NUM_GAME_NETWORK_STATES] = {
    handleConnectFailed,
    handleUnconnected,
    
    handleConnected,
    handleResolvingName,
    
    handleLookupFailed,
    handleSocketError,
    handleProtocolFailed,
    handleFailure,
    
    handleTcpUnconnected,
    
    handleWaitingForTcp,
    
    handleWaitingForHello,
    handleRequestScores,
    handleWaitingForScores,
    handleSetHighScore,
    handleWaitingForScoreAck,
    
    handleClosingTcp
};

// I am running out of space in the main segment so I am moving these globals into
// a dynamically allocated struct.  It is only allocated if network capabilities are
// detected.
static tGameNetworkGlobals * networkGlobals = NULL;

// The following globals are accessed by name from assembly so are not in the
// tGameNetworkGlobals structure.
// TODO - Make real interfaces for these things.
Boolean hasGlobalHighScores = FALSE;
tScoresResponse highScoreResponse;
Word globalScoreAge = 0;  // TODO - Replace this with a call to a MiscTool function?
tSetHighScoreRequestWithHash setHighScoreRequest;


// Implementation

void initNetwork(tHighScoreInitParams * params)
{
    networkGlobals = NULL;
    
    if ((params->scoreServer == NULL) ||
        (params->scorePort == 0) ||
        (params->waitForVbl == NULL))
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
    
    memcpy(&(networkGlobals->initParams), params, sizeof(networkGlobals->initParams));
    
    networkGlobals->networkStartedConnected = TCPIPGetConnectStatus();
    if (networkGlobals->networkStartedConnected) {
        networkGlobals->gameNetworkState = GAME_NETWORK_CONNECTED;
    } else {
        networkGlobals->gameNetworkState = GAME_NETWORK_UNCONNECTED;
    }
    
    networkGlobals->secrets[0] = params->secret1;
    networkGlobals->secrets[1] = params->secret2;
    
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
            networkGlobals->initParams.waitForVbl();
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
    strcpy(&(highScoreResponse.highScores.score[row].scoreText[2]), string);
}

static void displayNetworkError(char * line1, char * line2)
{
    Word row;
    Word column;
    
    networkGlobals->gameNetworkState = GAME_NETWORK_FAILURE;
    
    for (row = 0; row < sizeof(highScoreResponse.highScores) / sizeof(highScoreResponse.highScores.score[0]); row++) {
        for (column = 0;
             column < sizeof(highScoreResponse.highScores.score[0].scoreText) / sizeof(highScoreResponse.highScores.score[0].scoreText[0]);
             column++) {
            highScoreResponse.highScores.score[row].scoreText[column] = ' ';
        }
        for (column = 0;
             column < sizeof(highScoreResponse.highScores.score[0].who) / sizeof(highScoreResponse.highScores.score[0].who[0]);
             column++) {
            highScoreResponse.highScores.score[row].who[column] = ' ';
        }
    }
    
    displayString(1, "NETWORK");
    displayString(2, "PROBLEM");
    
    displayString(4, line1);
    displayString(5, line2);
    
    highScoreResponse.highScores.score[7].scoreText[0] = 'C';
    highScoreResponse.highScores.score[7].scoreText[1] = 'O';
    highScoreResponse.highScores.score[7].scoreText[2] = 'D';
    highScoreResponse.highScores.score[7].scoreText[3] = 'E';
    highScoreResponse.highScores.score[7].scoreText[4] = ':';
    highScoreResponse.highScores.score[7].scoreText[5] = ' ';
    highScoreResponse.highScores.score[7].scoreText[6] = hexDigitToAscii(networkGlobals->errorCode >> 12);
    highScoreResponse.highScores.score[7].scoreText[7] = hexDigitToAscii(networkGlobals->errorCode >> 8);
    highScoreResponse.highScores.score[7].scoreText[8] = hexDigitToAscii(networkGlobals->errorCode >> 4);
    highScoreResponse.highScores.score[7].scoreText[9] = hexDigitToAscii(networkGlobals->errorCode);
    
    globalScoreAge = 0;
    hasGlobalHighScores = TRUE;
}

static void handleConnectFailed(void)
{
    displayNetworkError("CONNECT", "FAILED");
}

static void handleUnconnected(void)
{
    if (networkGlobals->initParams.displayConnectionString != NULL)
        networkGlobals->initParams.displayConnectionString(TRUE);
    TCPIPConnect(NULL);
    if ((!toolerror()) &&
        (TCPIPGetConnectStatus())) {
        networkGlobals->gameNetworkState = GAME_NETWORK_CONNECTED;
    } else {
        networkGlobals->gameNetworkState = GAME_NETWORK_CONNECT_FAILED;
    }
    if (networkGlobals->initParams.displayConnectionString != NULL)
        networkGlobals->initParams.displayConnectionString(FALSE);
}

static void handleConnected(void)
{
    TCPIPDNRNameToIP((char *)networkGlobals->initParams.scoreServer, &(networkGlobals->domainNameResolution));
    if (toolerror()) {
        networkGlobals->gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
        networkGlobals->errorCode = toolerror();
    } else
        networkGlobals->gameNetworkState = GAME_NETWORK_RESOLVING_NAME;
}

static void handleResolvingName(void)
{
    if (networkGlobals->domainNameResolution.DNRstatus == DNR_Pending)
        return;
    
    if (networkGlobals->domainNameResolution.DNRstatus != DNR_OK) {
        networkGlobals->gameNetworkState = GAME_NETWORK_LOOKUP_FAILED;
        networkGlobals->errorCode = networkGlobals->domainNameResolution.DNRstatus;
        return;
    }
    
    networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
}

static void handleLookupFailed(void)
{
    displayNetworkError("LOOKUP", "FAILED");
}

static void handleSocketError(void)
{
    displayNetworkError("SOCKET", "ERROR");
    networkGlobals->timeout = NETWORK_RETRY_TIMEOUT;
}

static void handleProtocolFailed(void)
{
    abortConnection();
    displayNetworkError("PROTOCOL", "FAILED");
    networkGlobals->timeout = NETWORK_RETRY_TIMEOUT;
}

static void handleFailure(void)
{
    // All of the different failure modes except protocol failure above end up here ultimately.  And the state
    // machine stays here once it arrives here.
    if (networkGlobals->timeout > 0) {
        networkGlobals->timeout--;
        if (networkGlobals->timeout == 0)
            networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
    }
}

static void handleTcpUnconnected(void)
{
    if ((hasGlobalHighScores) &&
        (globalScoreAge > 0) &&
        (!networkGlobals->hasHighScoreToSend))
        return;
    
    networkGlobals->ipid = TCPIPLogin(networkGlobals->initParams.userId, networkGlobals->domainNameResolution.DNRIPaddress, networkGlobals->initParams.scorePort, 0, 64);
    if (toolerror()) {
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        networkGlobals->errorCode = toolerror();
        return;
    }
    
    networkGlobals->errorCode = TCPIPOpenTCP(networkGlobals->ipid);
    if (networkGlobals->errorCode != tcperrOK) {
        TCPIPLogout(networkGlobals->ipid);
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_TCP;
    networkGlobals->timeout = TCP_CONNECT_TIMEOUT;
}

static void handleWaitingForTcp(void)
{
    networkGlobals->errorCode = TCPIPStatusTCP(networkGlobals->ipid, &(networkGlobals->tcpStatus));
    if (networkGlobals->errorCode != tcperrOK) {
        abortConnection();
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    if ((networkGlobals->tcpStatus.srState == TCPSSYNSENT) ||
        (networkGlobals->tcpStatus.srState == TCPSSYNRCVD)) {
            if (networkGlobals->timeout > 0) {
                networkGlobals->timeout--;
            } else {
                networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
                networkGlobals->errorCode = TCP_CONNECT_TIMEOUT_ERROR;
            }
        return;
    }
    
    if (networkGlobals->tcpStatus.srState != TCPSESTABLISHED) {
        abortConnection();
        networkGlobals->errorCode = networkGlobals->tcpStatus.srState | 0x8000;
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    
    networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_HELLO;
    networkGlobals->timeout = READ_NETWORK_TIMEOUT;
    networkGlobals->bytesRead = 0;
}

static void handleWaitingForHello(void)
{
    networkGlobals->errorCode = TCPIPReadTCP(networkGlobals->ipid, 0,
                                             ((uint32_t)(&(networkGlobals->helloResponse))) + networkGlobals->bytesRead,
                                             sizeof(networkGlobals->helloResponse) - networkGlobals->bytesRead,
                                             &(networkGlobals->readResponseBuf));
    if (networkGlobals->errorCode != tcperrOK) {
        abortConnection();
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    
    networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
    if (networkGlobals->bytesRead < sizeof(networkGlobals->helloResponse)) {
        if (networkGlobals->timeout > 0) {
            networkGlobals->timeout--;
        } else {
            networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
            networkGlobals->errorCode = HELLO_TIMEOUT_ERROR;
        }
        return;
    }
    
    if (networkGlobals->bytesRead > sizeof(networkGlobals->helloResponse)) {
        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
        networkGlobals->errorCode = HELLO_TOO_BIG_ERROR;
        return;
    }
    
    if (networkGlobals->helloResponse.responseType != RESPONSE_TYPE_HELLO) {
        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
        networkGlobals->errorCode = HELLO_UNEXPECTED_RESPONSE_ERROR;
        return;
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
}

static void handleRequestScores(void)
{
    networkGlobals->highScoreRequest.highScoreRequest.requestType = REQUEST_TYPE_GET_HIGH_SCORES;
    
    md5Init(&(networkGlobals->hashWorkBlock));
    md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->secrets), sizeof(networkGlobals->secrets));
    md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->highScoreRequest.highScoreRequest), sizeof(networkGlobals->highScoreRequest.highScoreRequest));
    md5Finish(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->highScoreRequest.md5Digest[0]));
    
    networkGlobals->errorCode = TCPIPWriteTCP(networkGlobals->ipid, (Pointer)&(networkGlobals->highScoreRequest), sizeof(networkGlobals->highScoreRequest), FALSE, FALSE);
    if (networkGlobals->errorCode != tcperrOK) {
        abortConnection();
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    
    networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_SCORES;
    networkGlobals->timeout = READ_NETWORK_TIMEOUT;
    networkGlobals->bytesRead = 0;
}

static void handleWaitingForScores(void)
{
    networkGlobals->errorCode = TCPIPReadTCP(networkGlobals->ipid, 0,
                                             ((uint32_t)(&highScoreResponse)) + networkGlobals->bytesRead,
                                             sizeof(highScoreResponse) - networkGlobals->bytesRead,
                                             &(networkGlobals->readResponseBuf));
    if (networkGlobals->errorCode != tcperrOK) {
        abortConnection();
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    
    networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
    if (networkGlobals->bytesRead < sizeof(highScoreResponse)) {
        if (networkGlobals->timeout > 0) {
            networkGlobals->timeout--;
        } else {
            networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
            networkGlobals->errorCode = HIGH_SCORE_TIMEOUT_ERROR;
        }
        return;
    }
    
    if (networkGlobals->bytesRead > sizeof(highScoreResponse)) {
        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
        networkGlobals->errorCode = HIGH_SCORE_TOO_BIG_ERROR;
        return;
    }
    
    if (highScoreResponse.responseType != RESPONSE_TYPE_SCORES) {
        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
        networkGlobals->errorCode = HIGH_SCORE_UNEXPECTED_RESPONSE_ERROR;
        return;
    }
    
    globalScoreAge = GLOBAL_SCORE_REFRESH_TIME;
    hasGlobalHighScores = TRUE;
    
    TCPIPCloseTCP(networkGlobals->ipid);
    networkGlobals->gameNetworkState = GAME_NETWORK_CLOSING_TCP;
    networkGlobals->timeout = SHUTDOWN_NETWORK_TIMEOUT;
}

static void handleSetHighScore(void)
{
    setHighScoreRequest.setHighScoreRequest.requestType = REQUEST_TYPE_SET_SCORE;
    setHighScoreRequest.setHighScoreRequest.who[3] = '\0';
    
    md5Init(&(networkGlobals->hashWorkBlock));
    md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(networkGlobals->secrets), sizeof(networkGlobals->secrets));
    md5Append(&(networkGlobals->hashWorkBlock), (Pointer)&(setHighScoreRequest.setHighScoreRequest), sizeof(setHighScoreRequest.setHighScoreRequest));
    md5Finish(&(networkGlobals->hashWorkBlock), (Pointer)&(setHighScoreRequest.md5Digest[0]));
    
    networkGlobals->errorCode = TCPIPWriteTCP(networkGlobals->ipid, (Pointer)&setHighScoreRequest, sizeof(setHighScoreRequest), FALSE, FALSE);
    if (networkGlobals->errorCode != tcperrOK) {
        abortConnection();
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    
    networkGlobals->gameNetworkState = GAME_NETWORK_WAITING_FOR_SCORE_ACK;
    networkGlobals->timeout = READ_NETWORK_TIMEOUT;
    networkGlobals->bytesRead = 0;
}

static void handleWaitingForScoreAck(void)
{
    networkGlobals->errorCode = TCPIPReadTCP(networkGlobals->ipid, 0,
                                             ((uint32_t)(&(networkGlobals->setHighScoreResponse))) + networkGlobals->bytesRead,
                                             sizeof(networkGlobals->setHighScoreResponse) - networkGlobals->bytesRead,
                                             &(networkGlobals->readResponseBuf));
    if (networkGlobals->errorCode != tcperrOK) {
        abortConnection();
        networkGlobals->gameNetworkState = GAME_NETWORK_SOCKET_ERROR;
        return;
    }
    
    networkGlobals->bytesRead += networkGlobals->readResponseBuf.rrBuffCount;
    if (networkGlobals->bytesRead < sizeof(networkGlobals->setHighScoreResponse)) {
        if (networkGlobals->timeout > 0) {
            networkGlobals->timeout--;
        } else {
            networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
            networkGlobals->errorCode = SET_SCORE_TIMEOUT_ERROR;
        }
        return;
    }
    
    if (networkGlobals->bytesRead > sizeof(networkGlobals->setHighScoreResponse)) {
        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
        networkGlobals->errorCode = SET_SCORE_TOO_BIG_ERROR;
        return;
    }
    
    if (networkGlobals->setHighScoreResponse.responseType != RESPONSE_TYPE_STATUS) {
        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
        networkGlobals->errorCode = SET_SCORE_UNEXPECTED_RESPONSE_ERROR;
        return;
    }
    
    if (!networkGlobals->setHighScoreResponse.success) {
        networkGlobals->gameNetworkState = GAME_NETWORK_PROTOCOL_FAILED;
        networkGlobals->errorCode = SET_SCORE_FAILED_ERROR;
        return;
    }
    
    networkGlobals->hasHighScoreToSend = FALSE;
    globalScoreAge = 0;
    networkGlobals->gameNetworkState = GAME_NETWORK_REQUEST_SCORES;
}

static void handleClosingTcp(void)
{
    networkGlobals->errorCode = TCPIPStatusTCP(networkGlobals->ipid, &(networkGlobals->tcpStatus));
    if ((networkGlobals->tcpStatus.srState != TCPSCLOSED) &&
        (networkGlobals->tcpStatus.srState != TCPSTIMEWAIT)) {
        if (networkGlobals->timeout > 0) {
            networkGlobals->timeout--;
        } else {
            abortConnection();
            networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
        }
        return;
    }
    
    TCPIPLogout(networkGlobals->ipid);
    networkGlobals->gameNetworkState = GAME_NETWORK_TCP_UNCONNECTED;
}

void pollNetwork(void)
{
    if (networkGlobals == NULL)
        return;
    
    TCPIPPoll();
    
    handlers[networkGlobals->gameNetworkState]();
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
        networkGlobals->initParams.waitForVbl();
        pollNetwork();
        cycleCount++;
        
        if ((cycleCount & 0x7) == 0) {
            switch (cycleCount & 0x18) {
                case 0x00:
                    if (networkGlobals->initParams.uploadSpin != NULL)
                        networkGlobals->initParams.uploadSpin(0);
                    break;
                    
                case 0x08:
                    if (networkGlobals->initParams.uploadSpin != NULL)
                        networkGlobals->initParams.uploadSpin(1);
                    break;
                    
                case 0x10:
                    if (networkGlobals->initParams.uploadSpin != NULL)
                        networkGlobals->initParams.uploadSpin(2);
                    break;
                    
                case 0x18:
                    if (networkGlobals->initParams.uploadSpin != NULL)
                        networkGlobals->initParams.uploadSpin(3);
                    break;
            }
        }
    } while (networkGlobals->gameNetworkState > GAME_NETWORK_TCP_UNCONNECTED);
    
    if (networkGlobals->gameNetworkState != GAME_NETWORK_TCP_UNCONNECTED)
        return FALSE;
    
    if (networkGlobals->initParams.scorePosition != NULL)
        networkGlobals->initParams.scorePosition(networkGlobals->setHighScoreResponse.position,
                                                networkGlobals->setHighScoreResponse.numberOfScores);
    
    return TRUE;
}
