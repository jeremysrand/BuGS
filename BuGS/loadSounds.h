/*
 *  loadSounds.h
 *  BuGS
 *
 *  Created by Jeremy Rand on 2021-06-03.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTBuGS_FILEloadSounds_
#define _GUARD_PROJECTBuGS_FILEloadSounds_


#include <types.h>


extern void loadSpiderSound(Word addr);
extern void loadDeathSound(word addr);
extern void loadSegmentsSound(word addr);
extern void loadBonusSound(word addr);
extern void loadKillSound(word addr);
extern void loadFireSound(word addr);
extern void loadExtraLifeSound(word addr);
extern void loadFleaSound(word addr);
extern void loadScorpionSound(word addr);

extern void preloadSound(void);


#endif /* define _GUARD_PROJECTBuGS_FILEloadSounds_ */
