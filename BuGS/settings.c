/*
 *  settings.c
 *  BuGS
 *
 * Created by Jeremy Rand on 2021-06-03.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#include <string.h>

#include <gsos.h>
#include <orca.h>
#include <Memory.h>

#include "game.h"
#include "netScores.h"
#include "settings.h"
#include "tileData.h"


// Defines

#define SETTINGS_FILENAME "@:BuGS.settings"


/* Typedefs */

typedef struct tSettingsData
{
    char magic[4];
    int version;
    Boolean stereoCorrect;
    tNSGSHighScore highScores[NUM_HIGH_SCORES];
} tSettingsData;


// Globals

tSettingsData settings = {
    { 'B', 'u', 'G', 'S' },
    0,
    TRUE,
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

static RefNumRecGS closeRec;
static OpenRecGS openRec;
static IORecGS readRec;
static CreateRecGS createRec;
static IORecGS writeRec;
static NameRecGS destroyRec;
static Handle filenameHandle = NULL;


// Implementation

#if __ORCAC__
segment "settings";
#endif

static void allocateFilenameHandle(void)
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


static void deleteSettings(void)
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
        if (!settings.stereoCorrect)
        {
            swapStereoChannels();
        }
    }
    
    return success;
}


void swapStereoSettings(void)
{
    swapStereoChannels();
    settings.stereoCorrect = !settings.stereoCorrect;
    saveSettings();
}
