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


// Defines

#define REQUEST_TYPE_GET_HIGH_SCORES 0
#define REQUEST_TYPE_SET_SCORE 1

#define RESPONSE_TYPE_HELLO 0
#define RESPONSE_TYPE_SCORES 1
#define RESPONSE_TYPE_STATUS 2


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
    GAME_NETWORK_CONNECTED,
} tGameNetworkState;


// Globals

Boolean networkToolsStarted = FALSE;
Boolean networkStartedConnected = FALSE;
tGameNetworkState gameNetworkState = GAME_NETWORK_UNCONNECTED;


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
    if (!networkToolsStarted)
        return;
    
    switch (gameNetworkState) {
        case GAME_NETWORK_CONNECT_FAILED:
            // If Marinetti cannot connect to the network, then nothing more to do...
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
            // TODO - Write more code to make network requests.
            break;
    }
}
