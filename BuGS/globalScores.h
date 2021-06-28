/*
 *  globalScores.h
 *  BuGS
 *
 *  Created by Jeremy Rand on 2021-05-23.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTBuGS_FILEglobalScores_
#define _GUARD_PROJECTBuGS_FILEglobalScores_


#include <types.h>


typedef struct tHighScore
{
    char scoreText[10];
    char who[4];
    unsigned long score;
} tHighScore;

extern unsigned int myUserId;

extern void initNetwork(void);
extern void disconnectNetwork(void);
extern void pollNetwork(void);
extern void shutdownNetwork(void);
extern BOOLEAN canSendHighScore(void);
extern BOOLEAN sendHighScore(void);

// These are actually assembly functions called from the C code.
extern void uploadSpin1(void);
extern void uploadSpin2(void);
extern void uploadSpin3(void);
extern void displayConnectionString(void);


#endif /* define _GUARD_PROJECTBuGS_FILEglobalScores_ */
