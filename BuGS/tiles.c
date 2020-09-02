/*
 *  tiles.c
 *  BuGS
 *
 * Created by Jeremy Rand on 2020-07-14.
 * Copyright © 2020 Jeremy Rand. All rights reserved.
 */

#include <string.h>

#include "tiles.h"


/* Defines */

#define TILE_WIDTH 8
#define TILE_HEIGHT 8

#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 200

#define GAME_LEFT_MOST_X_POS (13 * TILE_WIDTH)       /* 13 tiles from the left */
#define GAME_TOP_MOST_Y_POS (0 * TILE_HEIGHT)

#define GAME_X_Y_TO_TILE_OFFSET(X, Y) \
    ((((Y) * GAME_NUM_TILES_WIDE) + (X)) * sizeof(word))

#define RHS_X_Y_TO_TILE_OFFSET(X, Y) \
    ((RHS_FIRST_TILE + ((Y) * RHS_NUM_TILES_WIDE) + (X)) * sizeof(word))

#define LHS_X_Y_TO_TILE_OFFSET(X, Y) \
    ((LHS_FIRST_TILE + ((Y) * LHS_NUM_TILES_WIDE) + (X)) * sizeof(word))

#define SCREEN_ADDRESS_FOR_TILE_AT_X_Y(X, Y) \
    (0x2000 + (0xa0 * (Y)) + ((X) / 2) + 3)

#define STARTING_NUM_MUSHROOMS 30
#define STARTING_NUM_PLAYERS 3

#define ADD_DIRTY_GAME_TILE(tileNum)                                        \
    if (!tileDirty[tileNum]) {                                              \
        tileDirty[tileNum] = 1;                                             \
        dirtyGameTiles[numDirtyGameTiles / 2] = ((tileNum) * sizeof(word)); \
        numDirtyGameTiles += 2;                                             \
    }

#define ADD_DIRTY_NON_GAME_TILE(tileNum)                                          \
    if (!tileDirty[tileNum]) {                                                    \
        tileDirty[tileNum] = 1;                                                   \
        dirtyNonGameTiles[numDirtyNonGameTiles / 2] = ((tileNum) * sizeof(word)); \
        numDirtyNonGameTiles += 2;                                                \
    }

/* Globals */

word tileDirty[TOTAL_NUM_TILES];
word tileOffset[TOTAL_NUM_TILES];
tTileType tileType[TOTAL_NUM_TILES];
tTileOffset tileAbove[TOTAL_NUM_TILES];
tTileOffset tileBelow[TOTAL_NUM_TILES];
tTileOffset tileLeft[TOTAL_NUM_TILES];
tTileOffset tileRight[TOTAL_NUM_TILES];

tTileOffset dirtyGameTiles[NUM_GAME_TILES + GAME_NUM_TILES_TALL];
word numDirtyGameTiles;

tTileOffset dirtyNonGameTiles[NUM_NON_GAME_TILES];
word numDirtyNonGameTiles;

word numPlayers;


/* Implementation */

void initTiles(void)
{
    word tileX;
    word tileY;
    word lastOffset;
    word tileIndex = 0;
    word rhsTileIndex = RHS_FIRST_TILE;
    word lhsTileIndex = LHS_FIRST_TILE;
    
    for (tileY = 0; tileY < GAME_NUM_TILES_TALL; tileY++)
    {
        lastOffset = SCREEN_ADDRESS_FOR_TILE_AT_X_Y(0, tileY * TILE_HEIGHT);
        
        for (tileX = 0; tileX < LHS_NUM_TILES_WIDE; tileX++)
        {
            tileDirty[lhsTileIndex] = 0;
            tileOffset[lhsTileIndex] = lastOffset;
            tileType[lhsTileIndex] = TILE_EMPTY;

            if (tileY == 0)
                tileAbove[lhsTileIndex] = INVALID_TILE_NUM;
            else
                tileAbove[lhsTileIndex] = LHS_X_Y_TO_TILE_OFFSET(tileX, tileY - 1);
            
            if (tileY == GAME_NUM_TILES_TALL - 1)
                tileBelow[lhsTileIndex] = INVALID_TILE_NUM;
            else
                tileBelow[lhsTileIndex] = LHS_X_Y_TO_TILE_OFFSET(tileX, tileY + 1);
            
            if (tileX == 0)
                tileLeft[lhsTileIndex] = INVALID_TILE_NUM;
            else
                tileLeft[lhsTileIndex] = LHS_X_Y_TO_TILE_OFFSET(tileX - 1, tileY);
            
            if (tileX == LHS_NUM_TILES_WIDE - 1)
                tileRight[lhsTileIndex] = GAME_X_Y_TO_TILE_OFFSET(0, tileY);
            else
                tileRight[lhsTileIndex] = LHS_X_Y_TO_TILE_OFFSET(tileX + 1, tileY);
            
            lhsTileIndex++;
                
            lastOffset += 4;
        }
        
        for (tileX = 0; tileX < GAME_NUM_TILES_WIDE; tileX++)
        {
            tileDirty[tileIndex] = 0;
            tileOffset[tileIndex] = lastOffset;
            tileType[tileIndex] = TILE_EMPTY;
            
            if (tileY == 0)
                tileAbove[tileIndex] = INVALID_TILE_NUM;
            else
                tileAbove[tileIndex] = GAME_X_Y_TO_TILE_OFFSET(tileX, tileY - 1);
            
            if (tileY == GAME_NUM_TILES_TALL - 1)
                tileBelow[tileIndex] = INVALID_TILE_NUM;
            else
                tileBelow[tileIndex] = GAME_X_Y_TO_TILE_OFFSET(tileX, tileY + 1);
            
            if (tileX == 0)
                tileLeft[tileIndex] = LHS_X_Y_TO_TILE_OFFSET(LHS_NUM_TILES_WIDE - 1, tileY);
            else
                tileLeft[tileIndex] = GAME_X_Y_TO_TILE_OFFSET(tileX - 1, tileY);
            
            if (tileX == GAME_NUM_TILES_WIDE - 1)
                tileRight[tileIndex] = RHS_X_Y_TO_TILE_OFFSET(0, tileY);
            else
                tileRight[tileIndex] = GAME_X_Y_TO_TILE_OFFSET(tileX + 1, tileY);
            
            tileIndex++;
            
            lastOffset += 4;
        }
        
        for (tileX = 0; tileX < RHS_NUM_TILES_WIDE; tileX++)
        {
            tileDirty[rhsTileIndex] = 0;
            tileOffset[rhsTileIndex] = lastOffset;
            tileType[rhsTileIndex] = TILE_EMPTY;

            if (tileY == 0)
                tileAbove[rhsTileIndex] = INVALID_TILE_NUM;
            else
                tileAbove[rhsTileIndex] = RHS_X_Y_TO_TILE_OFFSET(tileX, tileY - 1);
            
            if (tileY == GAME_NUM_TILES_TALL - 1)
                tileBelow[rhsTileIndex] = INVALID_TILE_NUM;
            else
                tileBelow[rhsTileIndex] = RHS_X_Y_TO_TILE_OFFSET(tileX, tileY + 1);
            
            if (tileX == 0)
                tileLeft[rhsTileIndex] = GAME_X_Y_TO_TILE_OFFSET(GAME_NUM_TILES_WIDE - 1, tileY);
            else
                tileLeft[rhsTileIndex] = RHS_X_Y_TO_TILE_OFFSET(tileX - 1, tileY);
            
            if (tileX == RHS_NUM_TILES_WIDE - 1)
                tileRight[rhsTileIndex] = INVALID_TILE_NUM;
            else
                tileRight[rhsTileIndex] = RHS_X_Y_TO_TILE_OFFSET(tileX + 1, tileY);

            rhsTileIndex++;
            
            lastOffset += 4;
        }
    }
    
    numDirtyGameTiles = 0;
    numDirtyNonGameTiles = 0;
}


void initNonGameTiles(void)
{
    unsigned int i;
    tTileNum tileNum;
    numPlayers = STARTING_NUM_PLAYERS;
    for (i = 0; i < numPlayers; i++)
    {
        tileNum = RHS_FIRST_TILE + i;
        tileType[tileNum] = TILE_PLAYER;
        ADD_DIRTY_NON_GAME_TILE(tileNum);
    }
    
    tileNum = LHS_FIRST_TILE + (1 * LHS_NUM_TILES_WIDE) + 6;
    tileType[tileNum] = TILE_LETTER_S;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_C;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_O;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_R;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_SYMBOL_COLON;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (4 * LHS_NUM_TILES_WIDE) - 2;
    tileType[tileNum] = TILE_NUMBER_0;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (12 * LHS_NUM_TILES_WIDE) + 1;
    tileType[tileNum] = TILE_LETTER_H;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_I;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_G;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_H;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileNum++;
    tileType[tileNum] = TILE_LETTER_S;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_C;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_O;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_R;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_SYMBOL_COLON;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (15 * LHS_NUM_TILES_WIDE) - 2;
    tileType[tileNum] = TILE_NUMBER_0;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
}


void addStartingMushrooms(void)
{
    tTileNum tileNum;
    unsigned int numMushrooms = 0;
    
    while (numMushrooms < STARTING_NUM_MUSHROOMS)
    {
        /* We do not put mushrooms in the bottom tile so we subtract the width here to find
            a tile number above that last line */
        tileNum = rand() % (NUM_GAME_TILES - GAME_NUM_TILES_WIDE);
        if (tileType[tileNum] != TILE_EMPTY)
            continue;
        
        tileType[tileNum] = TILE_MUSHROOM4;
        ADD_DIRTY_GAME_TILE(tileNum);
        numMushrooms++;
    }
}
