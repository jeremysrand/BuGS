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


void loadSpiderSound(word addr)
{
    Handle handle = LoadResource(rRawSound, SPIDER_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}


void loadDeathSound(word addr)
{
    Handle handle = LoadResource(rRawSound, DEATH_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}


void loadSegmentsSound(word addr)
{
    Handle handle = LoadResource(rRawSound, SEGMENTS_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}


void loadBonusSound(word addr)
{
    Handle handle = LoadResource(rRawSound, BONUS_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}


void loadKillSound(word addr)
{
    Handle handle = LoadResource(rRawSound, KILL_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}


void loadFireSound(word addr)
{
    Handle handle = LoadResource(rRawSound, FIRE_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}


void loadExtraLifeSound(word addr)
{
    Handle handle = LoadResource(rRawSound, EXTRA_LIFE_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}


void loadFleaSound(word addr)
{
    Handle handle = LoadResource(rRawSound, FLEA_SOUND);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
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

    game();
    
    ShutDownTools(refIsHandle, toolStartupRef);
    TOOLFAIL("Unable to shutdown tools");
    
    TLShutDown();
    TOOLFAIL("Unable to shutdown tool locator");
    
    MMShutDown(userid);
    TOOLFAIL("Unable to shutdown memory manager");
}
