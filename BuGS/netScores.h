/*
 *  netScores.h
 *  NetScoresGS
 *
 *  Created by Jeremy Rand on 2021-05-23.
 * Copyright © 2021 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTNetScoresGS_FILEnetScores_
#define _GUARD_PROJECTNetScoresGS_FILEnetScores_


#include <TYPES.h>

typedef enum tNSGSErrorType
{
    NSGS_CONNECT_ERROR,
    NSGS_LOOKUP_ERROR,
    NSGS_SOCKET_ERROR,
    NSGS_PROTOCOL_ERROR
} tNSGSErrorType;


typedef enum ttNSGSProtocolErrors {
    NSGS_TCP_CONNECT_TIMEOUT_ERROR = 1,
    NSGS_HELLO_TIMEOUT_ERROR,
    NSGS_HELLO_TOO_BIG_ERROR,
    NSGS_HELLO_UNEXPECTED_RESPONSE_ERROR,
    NSGS_HIGH_SCORE_TIMEOUT_ERROR,
    NSGS_HIGH_SCORE_TOO_BIG_ERROR,
    NSGS_HIGH_SCORE_UNEXPECTED_RESPONSE_ERROR,
    NSGS_SET_SCORE_TIMEOUT_ERROR,
    NSGS_SET_SCORE_TOO_BIG_ERROR,
    NSGS_SET_SCORE_UNEXPECTED_RESPONSE_ERROR,
    NSGS_SET_SCORE_FAILED_ERROR,
} ttNSGSProtocolErrors;


typedef struct tNSGSHighScore
{
    char scoreText[10];
    char who[4];
    unsigned long score;
} tNSGSHighScore;

typedef struct tNSGSHighScores
{
    tNSGSHighScore score[10];
} tNSGSHighScores;

typedef struct tNSGSHighScoreInitParams
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
    
    /* Each of these timeouts are measured in poll periods.  So, if you call NSGS_PollNetwork() every 60th of a
       second, then you would use 60 to set the timeout to 1 second.  If these are zero, then the "good value"
       in the comment will be used as a default.
     
       The shutdown timeout controls how long we wait for a clean TCP disconnection before forcing an abort of
       the connection.  Two seconds is a good value for this timeout. */
    unsigned int shutdownTimeout;
    
    /* The connect timeout is the amount of time we wait for a TCP connection to come up before declaring a
       timeout protocol error.  Eight seconds is a good value for this timeout. */
    unsigned int connectTimeout;
    
    /* The read timeout is the amount of time we wait for a response from the server after we have made a
       request of it, whether that is getting the high score list or setting a new high score.  Five seconds
       is a good value for this timeout. */
    unsigned int readTimeout;
    
    /* The retry timeout is the amount of time we wait in an error state before retrying.  This only happens
       for "soft" errors where a retry is worthwhile.  Three minutes is a good value for this timeout. */
    unsigned int retryTimeout;
    
    /* This function should display a message to the user that the network is being brought up and they should
       be patient when the argument is TRUE and when the argument is FALSE, it should clear that message.  This
       function shouldn't block and just put something on the screen to say that the connection is being brought
       up or clear that message.  It is called sometimes (rarely) by NSGS_PollNetwork().  It is called with argument
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
        think something has hung while the upload is in progress.  It is called when NSGS_SendHighScore() is called
        by the game.
     */
    void (*uploadSpin)(int);
    
    /* When a score is successfully uploaded to the server, this function will be called with the position
       of this player's score among the total number of scores recorded for this game.  This information
       should be displayed to the user.  The function can block while this information is being displayed
       and that message should be cleaned up before the function returns to the caller.  This function is
       called by NSGS_SendHighScore().
     */
    void (*scorePosition)(unsigned int position, unsigned int numberOfScores);
    
    /* This function is only called from NSGS_PollNetwork() when something unexpected has occurred.
       The meaning of the error code depends on the error type.  For a protocol error, the error code
       is one of tNSGSProtocolErrors.  For other error codes, they come from Marinetti error codes.
       if the error code > $8000, then the error code is the socket state or-ed with $8000. */
    void (*displayError)(tNSGSErrorType errorType, unsigned int errorCode);
    
    /* This function is only called from NSGS_PollNetwork() when new scores have been downloaded.
       The scores passed should be copied because the pointer is not guaranteed to be valid after
       the callback returns. */
    void (*setHighScores)(const tNSGSHighScores * scores);
    
    /* This function is called to ask if it is time to refresh the global high score list.  This should
       be based on watching the elapsed time and it should return true if say 5 minutes has elapsed
       since high scores have been updated. */
    BOOLEAN (*shouldRefreshHighScores)(void);
} tNSGSHighScoreInitParams;


/* Call this function once at launch.  The pointer to the parameters is copied so the structure does not need
   to remain valid after the call to this function.
 */
extern void NSGS_InitNetwork(tNSGSHighScoreInitParams * params);


/* Call this when a game is about to start.  It will interrupt any network operation in progress and get ready for
   a quiet period where polling will stop until the game is over.  That way, all CPU time can be focused on the game.
   This function may call the waitForVbl() callback.
 */
extern void NSGS_DisconnectNetwork(void);


/* Call this every frame refresh period when a game is _not_ in progress.  This does any network operations required
   to download high scores.  During this function call, the displayConnectionString() callback may be called.
 */
extern void NSGS_PollNetwork(void);


/* Call this function once when the game is quitting. */
extern void NSGS_ShutdownNetwork(void);


/* Call this function when the player has a high score that should be recorded online.  This function will return
   TRUE if the network is up and a high score can be sent and if so, the game should call NSGS_SendHighScore() to send
   the high score.  If FALSE is returned, then the user is playing while offline and no attempt should be made to
   send the high score.
 */
extern BOOLEAN NSGS_CanSendHighScore(void);


/* Assuming NSGS_CanSendHighScore() returned TRUE, the game can call this function to actually try to send the high score
   to the server.  If this function returns TRUE, then the score was successfully sent to the server.  If FALSE
   is returned, then an error has occurred.  The game can offer the user the option to retry to the upload of the
   score and if the user would like to retry, just call NSGS_SendHighScore() again.  During this function call, the
   waitForVbl(), uploadSpin() and scorePosition() callbacks may be called.
 
   TODO - Pass the score as an argument rather than through globals.
 */
extern BOOLEAN NSGS_SendHighScore(const char * who, unsigned long score);


#endif /* define _GUARD_PROJECTNetScoresGS_FILEnetScores_ */
