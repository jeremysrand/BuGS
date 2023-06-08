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
#include "globalScores.h"
#include "settings.h"
#include "tileData.h"


/* Defines and macros */

#define TOOLFAIL(string) \
    if (toolerror()) SysFailMgr(toolerror(), (Pointer)"\p" string "\n\r    Error Code -> $");


/* Globals */

unsigned int myUserId;
unsigned int randomSeed;

// This symbol is used also from assembly directly so be careful with it...
char globalScoreInfo[GAME_NUM_TILES_WIDE + 1];


/* Implementation */


word randomMushroomOffset(void)
{
    /* We do not put mushrooms in the bottom tile so we subtract the width here to find
        a tile number above that last line */
    return (rand() % (NUM_GAME_TILES - GAME_NUM_TILES_WIDE)) * SIZEOF_TILE_INFO;
}


void uploadSpin(int val)
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


void scorePosition(unsigned int position, unsigned int numberOfScores)
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
}


void showConnectionString(BOOLEAN display)
{
    if (display)
        displayConnectionString();
}


int main(void)
{
    static tHighScoreInitParams highScoreInitParams;
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
    
    initNetwork(&highScoreInitParams);
    
    if (!loadSettings())
        saveSettings();

    game();
    
    shutdownNetwork();
    
    ShutDownTools(refIsHandle, toolStartupRef);
    TOOLFAIL("Unable to shutdown tools");
    
    TLShutDown();
    TOOLFAIL("Unable to shutdown tool locator");
    
    MMShutDown(myUserId);
    TOOLFAIL("Unable to shutdown memory manager");
}
