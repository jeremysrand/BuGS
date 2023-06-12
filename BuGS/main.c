/*
 * main.c
 * BuGS
 *
 * Created by Jeremy Rand on 2020-06-10.
 * Copyright (c) 2020 Jeremy Rand. All rights reserved.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <orca.h>
#include <Memory.h>
#include <Locator.h>
#include <MiscTool.h>

#include "main.h"
#include "game.h"
#include "netScores.h"
#include "settings.h"
#include "tileData.h"


/* Defines and macros */

#define GLOBAL_SCORE_REFRESH_TIME (15 * 60 * 60)

#define TOOLFAIL(string) \
    if (toolerror()) SysFailMgr(toolerror(), (Pointer)"\p" string "\n\r    Error Code -> $");


/* Globals */

unsigned int myUserId;
unsigned int randomSeed;

// This symbol is used also from assembly directly so be careful with it...
char globalScoreInfo[GAME_NUM_TILES_WIDE + 1];

tNSGSHighScores globalHighScores;
Boolean hasGlobalHighScores = FALSE;
Word globalScoreAge = 0;
unsigned int scoreIndex = 0;


/* Implementation */


word randomMushroomOffset(void)
{
    /* We do not put mushrooms in the bottom tile so we subtract the width here to find
        a tile number above that last line */
    return (rand() % (NUM_GAME_TILES - GAME_NUM_TILES_WIDE)) * SIZEOF_TILE_INFO;
}


static void uploadSpin(int val)
{
    switch (val)
    {
        case 0:
            uploadSpin1();
            break;
            
        case 1:
            uploadSpin2();
            break;
            
        case 2:
            uploadSpin3();
            break;
            
        case 3:
            uploadSpin2();
            break;
    }
}


static void scorePosition(unsigned int position, unsigned int numberOfScores)
{
    int i;
    
    sprintf(globalScoreInfo, "  %u OF %u SCORES", position, numberOfScores);
    for (i = (int)strlen(globalScoreInfo); i < sizeof(globalScoreInfo); i++) {
        globalScoreInfo[i] = ' ';
    }
    globalScoreInfo[GAME_NUM_TILES_WIDE] = '\0';
    displayScorePosition();
    
    for (i = 6 * 60; i > 0; i--) {
        waitForVbl();
    }
    
    globalScoreAge = 0;
}


static void showConnectionString(BOOLEAN display)
{
    if (display)
        displayConnectionString();
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
    strcpy(&(globalHighScores.score[row].scoreText[2]), string);
}

static void displayNetworkError(char * line1, char * line2, unsigned int errorCode)
{
    Word row;
    Word column;
    
    for (row = 0; row < sizeof(globalHighScores.score) / sizeof(globalHighScores.score[0]); row++) {
        for (column = 0;
             column < sizeof(globalHighScores.score[0].scoreText) / sizeof(globalHighScores.score[0].scoreText[0]);
             column++) {
            globalHighScores.score[row].scoreText[column] = ' ';
        }
        for (column = 0;
             column < sizeof(globalHighScores.score[0].who) / sizeof(globalHighScores.score[0].who[0]);
             column++) {
            globalHighScores.score[row].who[column] = ' ';
        }
    }
    
    displayString(1, "NETWORK");
    displayString(2, "PROBLEM");
    
    displayString(4, line1);
    displayString(5, line2);
    
    globalHighScores.score[7].scoreText[0] = 'C';
    globalHighScores.score[7].scoreText[1] = 'O';
    globalHighScores.score[7].scoreText[2] = 'D';
    globalHighScores.score[7].scoreText[3] = 'E';
    globalHighScores.score[7].scoreText[4] = ':';
    globalHighScores.score[7].scoreText[5] = ' ';
    globalHighScores.score[7].scoreText[6] = hexDigitToAscii(errorCode >> 12);
    globalHighScores.score[7].scoreText[7] = hexDigitToAscii(errorCode >> 8);
    globalHighScores.score[7].scoreText[8] = hexDigitToAscii(errorCode >> 4);
    globalHighScores.score[7].scoreText[9] = hexDigitToAscii(errorCode);
    
    hasGlobalHighScores = TRUE;
    globalScoreAge = 0;
}

static void displayError(tNSGSErrorType errorType, unsigned int errorCode)
{
    switch (errorType) {
        case NSGS_CONNECT_ERROR:
            displayNetworkError("CONNECT", "FAILED", errorCode);
            break;

        case NSGS_LOOKUP_ERROR:
            displayNetworkError("LOOKUP", "FAILED", errorCode);
            break;
            
        case NSGS_SOCKET_ERROR:
            displayNetworkError("SOCKET", "ERROR", errorCode);
            break;
            
        case NSGS_PROTOCOL_ERROR:
            displayNetworkError("PROTOCOL", "FAILED", errorCode);
            break;
    }
}


static void setHighScores(const tNSGSHighScores * highScores)
{
    memcpy(&globalHighScores, highScores, sizeof(globalHighScores));
    hasGlobalHighScores = TRUE;
    globalScoreAge = GLOBAL_SCORE_REFRESH_TIME;
}


static BOOLEAN shouldRefreshHighScores(void)
{
    return globalScoreAge == 0;
}


BOOLEAN sendHighScore(void)
{
    const tNSGSHighScore * highScore = getHighScore(scoreIndex / sizeof(tNSGSHighScore));
    return NSGS_SendHighScore(highScore->who, highScore->score);
}


int main(void)
{
    static tNSGSHighScoreInitParams highScoreInitParams;
    int event;
    Ref toolStartupRef;
    
    myUserId = MMStartUp();
    TOOLFAIL("Unable to start memory manager");
    
    TLStartUp();
    TOOLFAIL("Unable to start tool locator");
    
    toolStartupRef = StartUpTools(myUserId, refIsResource, TOOL_STARTUP);
    TOOLFAIL("Unable to start tools");
    
    CompactMem();
    /* Allocate $1000 extra before the SHR screen so I can write sprites above the start of the
       screen without overwriting memory I do not own. */
    NewHandle(0x9000, myUserId, attrLocked | attrFixed | attrAddr | attrBank, (Pointer)0x011000);
    TOOLFAIL("Unable to allocate SHR screen");
    
    randomSeed = (int)time(NULL);
    if (randomSeed == 0)
        randomSeed = 1;
    srand(randomSeed);
    randInit();
    
    InitMouse(0);
    SetMouse(transparent);
    
    highScoreInitParams.userId = myUserId;
    highScoreInitParams.scoreServer = (const char *)"\p" NETWORK_SERVER;
    highScoreInitParams.scorePort = NETWORK_SERVERPORT;
    highScoreInitParams.secret1 = NETWORK_SERVERSECRET1;
    highScoreInitParams.secret2 = NETWORK_SERVERSECRET2;
    
    highScoreInitParams.displayConnectionString = showConnectionString;
    highScoreInitParams.waitForVbl = waitForVbl;
    highScoreInitParams.uploadSpin = uploadSpin;
    highScoreInitParams.scorePosition = scorePosition;
    highScoreInitParams.displayError = displayError;
    highScoreInitParams.setHighScores = setHighScores;
    
    NSGS_InitNetwork(&highScoreInitParams);
    
    if (!loadSettings())
        saveSettings();

    game();
    
    NSGS_ShutdownNetwork();
    
    ShutDownTools(refIsHandle, toolStartupRef);
    TOOLFAIL("Unable to shutdown tools");
    
    TLShutDown();
    TOOLFAIL("Unable to shutdown tool locator");
    
    MMShutDown(myUserId);
    TOOLFAIL("Unable to shutdown memory manager");
}
