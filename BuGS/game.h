/*
 *  game.h
 *  BuGS
 *
 *  Created by Jeremy Rand on 2020-06-10.
 * Copyright © 2020 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTBuGS_FILEgame_
#define _GUARD_PROJECTBuGS_FILEgame_

// These are assembly functions called from C.

extern void game(void);
extern void randInit(void);
extern void waitForVbl(void);
extern void uploadSpin1(void);
extern void uploadSpin2(void);
extern void uploadSpin3(void);
extern void displayConnectionString(void);
extern void swapStereoChannels(void);


#endif /* define _GUARD_PROJECTBuGS_FILEgame_ */
