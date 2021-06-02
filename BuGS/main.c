/*
 * main.c
 * BuGS
 *
 * Created by Jeremy Rand on 2020-06-10.
 * Copyright (c) 2020 Jeremy Rand. All rights reserved.
 *
 */


#include <stdlib.h>
#include <string.h>

#include <gsos.h>
#include <Memory.h>
#include <Locator.h>
#include <MiscTool.h>
#include <Resources.h>
#include <Sound.h>

#include "main.h"
#include "game.h"
#include "globalScores.h"
#include "tileData.h"


/* Defines and macros */

#define TOOLFAIL(string) \
    if (toolerror()) SysFailMgr(toolerror(), "\p" string "\n\r    Error Code -> $");

#define SETTINGS_FILENAME "@:BuGS.settings"


/* Typedefs */

typedef struct tSettingsData
{
    char magic[4];
    int version;
    Boolean swapStereo;
    tHighScore highScores[NUM_HIGH_SCORES];
} tSettingsData;


/* Globals */

unsigned int myUserId;
unsigned int randomSeed;
tSettingsData settings = {
    { 'B', 'u', 'G', 'S' },
    0,
    FALSE,
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
RefNumRecGS closeRec;
OpenRecGS openRec;
IORecGS readRec;
CreateRecGS createRec;
IORecGS writeRec;
NameRecGS destroyRec;
Handle filenameHandle = NULL;


/* Implementation */


extern void swapStereoChannels(void);


word randomMushroomOffset(void)
{
    /* We do not put mushrooms in the bottom tile so we subtract the width here to find
        a tile number above that last line */
    return (rand() % (NUM_GAME_TILES - GAME_NUM_TILES_WIDE)) * SIZEOF_TILE_INFO;
}

void loadSound(Word addr, Word soundNum)
{
    Handle handle = LoadResource(rRawSound, soundNum);
    HLock(handle);
    WriteRamBlock(*handle, addr, GetHandleSize(handle));
    HUnlock(handle);
}

void loadSpiderSound(Word addr)
{
    loadSound(addr, SPIDER_SOUND);
}


void loadDeathSound(word addr)
{
    loadSound(addr, DEATH_SOUND);
}


void loadSegmentsSound(word addr)
{
    loadSound(addr, SEGMENTS_SOUND);
}


void loadBonusSound(word addr)
{
    loadSound(addr, BONUS_SOUND);
}


void loadKillSound(word addr)
{
    loadSound(addr, KILL_SOUND);
}


void loadFireSound(word addr)
{
    loadSound(addr, FIRE_SOUND);
}


void loadExtraLifeSound(word addr)
{
    loadSound(addr, EXTRA_LIFE_SOUND);
}


void loadFleaSound(word addr)
{
    loadSound(addr, FLEA_SOUND);
}


void loadScorpionSound(word addr)
{
    loadSound(addr, SCORPION_SOUND);
}


void preloadSound(void)
{
    LoadResource(rRawSound, SPIDER_SOUND);
    LoadResource(rRawSound, DEATH_SOUND);
    LoadResource(rRawSound, SEGMENTS_SOUND);
    LoadResource(rRawSound, BONUS_SOUND);
    LoadResource(rRawSound, KILL_SOUND);
    LoadResource(rRawSound, FIRE_SOUND);
    LoadResource(rRawSound, EXTRA_LIFE_SOUND);
    LoadResource(rRawSound, FLEA_SOUND);
    LoadResource(rRawSound, SCORPION_SOUND);
}


void allocateFilenameHandle(void)
{
    if (filenameHandle == NULL)
    {
        GSString255Ptr filenamePtr;
        
        filenameHandle = NewHandle(sizeof(GSString255), myUserId, 0x8000, NULL);
        HLock(filenameHandle);
        filenamePtr = (GSString255Ptr)(*filenameHandle);
        filenamePtr->length = strlen(SETTINGS_FILENAME);
        strcpy(filenamePtr->text, SETTINGS_FILENAME);
        HUnlock(filenameHandle);
    }
}


void deleteSettings(void)
{
    allocateFilenameHandle();
    HLock(filenameHandle);
    
    destroyRec.pCount = 1;
    destroyRec.pathname = (GSString255Ptr)(*filenameHandle);
    DestroyGS(&destroyRec);
    
    HUnlock(filenameHandle);
}


void saveSettings(void)
{
    BOOLEAN success = false;
    
    deleteSettings();
    
    allocateFilenameHandle();
    HLock(filenameHandle);
    
    createRec.pCount = 5;
    createRec.pathname = (GSString255Ptr)(*filenameHandle);
    createRec.access = destroyEnable | renameEnable | readWriteEnable;
    createRec.fileType = 0x06;
    createRec.auxType = 0x2000;
    createRec.storageType = seedling;
    CreateGS(&createRec);
    if (toolerror() != 0)
    {
        HUnlock(filenameHandle);
        return;
    }
    
    openRec.pCount = 3;
    openRec.pathname = (GSString255Ptr)(*filenameHandle);
    openRec.requestAccess = writeEnable;
    OpenGS(&openRec);
    if (toolerror() == 0)
    {
        writeRec.pCount = 4;
        writeRec.refNum = openRec.refNum;
        writeRec.dataBuffer = (Pointer) &settings;
        writeRec.requestCount = sizeof(settings);
        WriteGS(&writeRec);
        success = (toolerror() == 0);
        
        closeRec.pCount = 1;
        closeRec.refNum = openRec.refNum;
        CloseGS(&closeRec);
    }
    
    HUnlock(filenameHandle);
    
    if (!success)
        deleteSettings();
}


BOOLEAN loadSettings(void)
{
    BOOLEAN success = FALSE;
    
    allocateFilenameHandle();
    HLock(filenameHandle);
    
    openRec.pCount = 12;
    openRec.requestAccess = readEnable;
    openRec.resourceNumber = 0;
    openRec.pathname = (GSString255Ptr)(*filenameHandle);
    OpenGS(&openRec);
    if (toolerror() == 0)
    {
        if (openRec.eof == sizeof(settings))
        {
            readRec.pCount = 4;
            readRec.refNum = openRec.refNum;
            readRec.dataBuffer = (Pointer)&settings;
            readRec.requestCount = sizeof(tSettingsData);
            ReadGS(&readRec);
            success = (toolerror() == 0);
        }
        
        closeRec.pCount = 1;
        closeRec.refNum = openRec.refNum;
        CloseGS(&closeRec);
    }
    HUnlock(filenameHandle);
    
    if (success)
    {
        if ((settings.magic[0] != 'B') ||
            (settings.magic[1] != 'u') ||
            (settings.magic[2] != 'G') ||
            (settings.magic[3] != 'S') ||
            (settings.version != 0))
            success = FALSE;
    }
    
    if (success)
    {
        if (settings.swapStereo)
        {
            swapStereoChannels();
        }
    }
    
    return success;
}


void swapStereoSettings(void)
{
    swapStereoChannels();
    settings.swapStereo = !settings.swapStereo;
    saveSettings();
}


int main(void)
{
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
    
    initNetwork();
    
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
