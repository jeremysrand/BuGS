/*
 *  globalScores.h
 *  BuGS
 *
 *  Created by Jeremy Rand on 2021-05-23.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTBuGS_FILEglobalScores_
#define _GUARD_PROJECTBuGS_FILEglobalScores_


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


#endif /* define _GUARD_PROJECTBuGS_FILEglobalScores_ */
