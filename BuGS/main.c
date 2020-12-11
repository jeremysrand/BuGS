/*
 * main.c
 * BuGS
 *
 * Created by Jeremy Rand on 2020-06-10.
 * Copyright (c) 2020 Jeremy Rand. All rights reserved.
 *
 */


#include <stdlib.h>

#include <Memory.h>
#include <Locator.h>
#include <MiscTool.h>
#include <Resources.h>
#include <Sound.h>

#include <string.h>

#include "main.h"
#include "game.h"
#include "tileData.h"


/* Defines and macros */

#define TOOLFAIL(string) \
    if (toolerror()) SysFailMgr(toolerror(), "\p" string "\n\r    Error Code -> $");


/* Globals */

unsigned int userid;
unsigned int randomSeed;


/* Implementation */


word randomMushroomOffset(void)
{
    /* We do not put mushrooms in the bottom tile so we subtract the width here to find
        a tile number above that last line */
    return (rand() % (NUM_GAME_TILES - GAME_NUM_TILES_WIDE)) * SIZEOF_TILE_INFO;
}


void setupSound(word soundNum, SoundParamBlock * soundParams, word genNum, word numGenerators, boolean looped)
{
    static word nextDocBuffer = 0;
    
    Handle handle = LoadResource(rRawSound, soundNum);
    HLock(handle);
    
    word handleSize = GetHandleSize(handle);
    
    soundParams->freqOffset = 214;
    soundParams->docBuffer = nextDocBuffer;
    soundParams->volSetting = 255;
    soundParams->waveStart = *handle;
    soundParams->waveSize = (handleSize / 256) + 1;
    
    if (handleSize > 16384)
    {
        soundParams->bufferSize = 7;
        nextDocBuffer += 32768;
    }
    else if (handleSize > 8192)
    {
        soundParams->bufferSize = 6;
        nextDocBuffer += 16384;
    }
    else if (handleSize > 4096)
    {
        soundParams->bufferSize = 5;
        nextDocBuffer += 8192;
    }
    else if (handleSize > 2048)
    {
        soundParams->bufferSize = 4;
        nextDocBuffer += 4096;
    }
    else if (handleSize > 1024)
    {
        soundParams->bufferSize = 3;
        nextDocBuffer += 2048;
    }
    else if (handleSize > 512)
    {
        soundParams->bufferSize = 2;
        nextDocBuffer += 1024;
    }
    else if (handleSize > 256)
    {
        soundParams->bufferSize = 1;
        nextDocBuffer += 512;
    }
    else
    {
        soundParams->bufferSize = 0;
        nextDocBuffer += 256;
    }
    
    if (looped)
        soundParams->nextWavePtr = soundParams;
    else
        soundParams->nextWavePtr = NULL;

    for (word i = 0; i < numGenerators; i++)
        FFSetUpSound(((genNum + i) << 8) | 1, (Pointer)soundParams);
}


void loadSounds(void)
{
    static SoundParamBlock soundParams[8];
    
    setupSound(SPIDER_SOUND, soundParams, SPIDER_SOUND_GENERATOR, 1, TRUE);
    setupSound(DEATH_SOUND, soundParams, DEATH_SOUND_GENERATOR, 1, FALSE);
    setupSound(SEGMENTS_SOUND, soundParams, SEGMENTS_SOUND_GENERATOR, 1, TRUE);
    setupSound(BONUS_SOUND, soundParams, BONUS1_SOUND_GENERATOR, 3, FALSE);
    setupSound(KILL_SOUND, soundParams, KILL_SOUND_GENERATOR, 1, FALSE);
    setupSound(FIRE_SOUND, soundParams, FIRE1_SOUND_GENERATOR, 5, FALSE);
}


int main(void)
{
    int event;
    Ref toolStartupRef;
    
    userid = MMStartUp();
    TOOLFAIL("Unable to start memory manager");
    
    TLStartUp();
    TOOLFAIL("Unable to start tool locator");
    
    toolStartupRef = StartUpTools(userid, refIsResource, TOOL_STARTUP);
    TOOLFAIL("Unable to start tools");
    
    CompactMem();
    /* Allocate $1000 extra before the SHR screen so I can write sprites above the start of the
       screen without overwriting memory I do not own. */
    NewHandle(0x9000, userid, attrLocked | attrFixed | attrAddr | attrBank, (Pointer)0x011000);
    TOOLFAIL("Unable to allocate SHR screen");
    
    randomSeed = (int)time(NULL);
    if (randomSeed == 0)
        randomSeed = 1;
    srand(randomSeed);
    randInit();
    
    InitMouse(0);
    SetMouse(transparent);
    
    loadSounds();

    game();
    
    ShutDownTools(refIsHandle, toolStartupRef);
    TOOLFAIL("Unable to shutdown tools");
    
    TLShutDown();
    TOOLFAIL("Unable to shutdown tool locator");
    
    MMShutDown(userid);
    TOOLFAIL("Unable to shutdown memory manager");
}
