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

extern char globalScoreInfo[26]; /* TODO - Get rid of this global and the hard coded length */

typedef struct tHighScoreInitParams
{
    unsigned int userId;
    const char * scoreServer;       /* Pascal string of the hostname of the score server. */
    unsigned int scorePort;
    unsigned long secret1;
    unsigned long secret2;
    
    void (*displayConnectionString)(void);  /* This function should display a message to the user that the network is being brought up. */
    void (*waitForVbl)(void);               /* This function should wait for the next VBL and is used to poll the network and limit upload time for a high score. */
    void (*uploadSpin)(int);                /* This argument iterates over 0, 1, 2, 3 and then back to 0, 1, 2, etc and is intended to show some kind of spinner to the user
                                                  while uploading a high score. */
} tHighScoreInitParams;

extern void initNetwork(tHighScoreInitParams * params);
extern void disconnectNetwork(void);
extern void pollNetwork(void);
extern void shutdownNetwork(void);
extern BOOLEAN canSendHighScore(void);
extern BOOLEAN sendHighScore(void);

// These are actually assembly functions called from the C code.
extern void displayScorePosition(void);


#endif /* define _GUARD_PROJECTBuGS_FILEglobalScores_ */
