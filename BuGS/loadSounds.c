/*
 *  loadSounds.c
 *  BuGS
 *
 * Created by Jeremy Rand on 2021-06-03.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#include <memory.h>
#include <resources.h>
#include <sound.h>

#include "loadSounds.h"
#include "main.h"


segment "loadSounds";

static void loadSound(Word addr, Word soundNum)
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
