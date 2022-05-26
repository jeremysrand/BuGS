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


typedef struct tHighScoreInitParams
{
    /* This structure is initialized by the game and passed by pointer to the high score code.  It consists of
        a series of data members and a series of callbacks which are provided by the game.
     */
    
    /* This is the memory manager ID of the game. */
    unsigned int userId;
    
    /* This is a Pascal string (not a C string) of the hostname of the score server to connect to. */
    const char * scoreServer;
    
    /* This is the TCP port number of the score server to connect to. */
    unsigned int scorePort;
    
    /* These two 32-bit values are the shared secrets used by the connect between the game and the score server
       which is used to try to reduce the amount of game score hacking.
     */
    unsigned long secret1;
    unsigned long secret2;
    
    
    /* This function should display a message to the user that the network is being brought up and they should
       be patient when the argument is TRUE and when the argument is FALSE, it should clear that message.  This
       function shouldn't block and just put something on the screen to say that the connection is being brought
       up or clear that message.  It is called sometimes (rarely) by pollNetwork().  It is called with argument
       TRUE and will always be called with FALSE sometime after that.
     */
    void (*displayConnectionString)(BOOLEAN display);
    
    /* This function should wait for the next VBL and is used to poll the network and limit upload time for a
        high score.
    */
    void (*waitForVbl)(void);
    
    /* This argument iterates over 0, 1, 2, 3 and then back to 0, 1, 2, etc and is intended to show some kind
        of spinner to the user while uploading a high score to the server.  This function shouldn't block for
        any real amount of time and just cause something on the screen to change to make sure the player doesn't
        think something has hung while the upload is in progress.  It is called when sendHighScore() is called
        by the game.
     */
    void (*uploadSpin)(int);
    
    /* When a score is successfully uploaded to the server, this function will be called with the position
       of this player's score among the total number of scores recorded for this game.  This information
       should be displayed to the user.  The function can block while this information is being displayed
       and that message should be cleaned up before the function returns to the caller.  This function is
       called by sendHighScore().
     */
    void (*scorePosition)(unsigned int position, unsigned int numberOfScores);
} tHighScoreInitParams;


/* Call this function once at launch.  The pointer to the parameters is copied so the structure does not need
   to remain valid after the call to this function.
 */
extern void initNetwork(tHighScoreInitParams * params);


/* Call this when a game is about to start.  It will interrupt any network operation in progress and get ready for
   a quiet period where polling will stop until the game is over.  That way, all CPU time can be focused on the game.
   This function may call the waitForVbl() callback.
 */
extern void disconnectNetwork(void);


/* Call this every frame refresh period when a game is _not_ in progress.  This does any network operations required
   to download high scores.  During this function call, the displayConnectionString() callback may be called.
 */
extern void pollNetwork(void);


/* Call this function once when the game is quitting. */
extern void shutdownNetwork(void);


/* Call this function when the player has a high score that should be recorded online.  This function will return
   TRUE if the network is up and a high score can be sent and if so, the game should call sendHighScore() to send
   the high score.  If FALSE is returned, then the user is playing while offline and no attempt should be made to
   send the high score.
 */
extern BOOLEAN canSendHighScore(void);


/* Assuming canSendHighScore() returned TRUE, the game can call this function to actually try to send the high score
   to the server.  If this function returns TRUE, then the score was successfully sent to the server.  If FALSE
   is returned, then an error has occurred.  The game can offer the user the option to retry to the upload of the
   score and if the user would like to retry, just call sendHighScore() again.  During this function call, the
   waitForVbl(), uploadSpin() and scorePosition() callbacks may be called.
 
   TODO - Pass the score as an argument rather than through globals.
 */
extern BOOLEAN sendHighScore(void);


#endif /* define _GUARD_PROJECTBuGS_FILEglobalScores_ */
