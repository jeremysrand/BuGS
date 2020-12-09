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


void setupSound(word soundNum, SoundParamBlock * soundParams, boolean looped)
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
    soundParams->bufferSize = 0;
    nextDocBuffer += (soundParams->waveSize * 256);
    if (looped)
        soundParams->nextWavePtr = soundParams;
    else
        soundParams->nextWavePtr = NULL;

    FFSetUpSound((soundNum << 8) | 1, (Pointer)soundParams);
}


void loadSounds(void)
{
    static SoundParamBlock spiderSound;
    static SoundParamBlock deathSound;
    static SoundParamBlock segmentsSound;
    static SoundParamBlock bonusSound;
    static SoundParamBlock killSound;
    static SoundParamBlock fireSound;
    
    setupSound(SPIDER_SOUND, &spiderSound, TRUE);
    setupSound(DEATH_SOUND, &deathSound, FALSE);
    setupSound(SEGMENTS_SOUND, &segmentsSound, TRUE);
    setupSound(BONUS_SOUND, &bonusSound, FALSE);
    setupSound(KILL_SOUND, &killSound, FALSE);
    setupSound(FIRE_SOUND, &fireSound, FALSE);
    // FFStartPlaying(1 << SEGMENTS_SOUND);
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
