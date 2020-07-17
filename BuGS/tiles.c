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
    ((((Y) * GAME_NUM_TILES_WIDE) + (X)) * sizeof(tTile))

#define RHS_X_Y_TO_TILE_OFFSET(X, Y) \
    ((RHS_FIRST_TILE + ((Y) * RHS_NUM_TILES_WIDE) + (X)) * sizeof(tTile))

#define LHS_X_Y_TO_TILE_OFFSET(X, Y) \
    ((LHS_FIRST_TILE + ((Y) * LHS_NUM_TILES_WIDE) + (X)) * sizeof(tTile))

#define SCREEN_ADDRESS_FOR_TILE_AT_X_Y(X, Y) \
    (0x2000 + (0xa0 * (Y)) + ((X) / 2) + 3)

#define STARTING_NUM_MUSHROOMS 30
#define STARTING_NUM_PLAYERS 3

#define ADD_DIRTY_GAME_TILE(tileNum)                                        \
    if (!tiles[tileNum].dirty) {                                            \
        tiles[tileNum].dirty = 1;                                           \
        dirtyGameTiles[numDirtyGameTiles] = ((tileNum) * sizeof(tTile));    \
        numDirtyGameTiles++;                                                \
    }

#define ADD_DIRTY_NON_GAME_TILE(tileNum)                                        \
    if (!tiles[tileNum].dirty) {                                                \
        tiles[tileNum].dirty = 1;                                               \
        dirtyNonGameTiles[numDirtyNonGameTiles] = ((tileNum) * sizeof(tTile));  \
        numDirtyNonGameTiles++;                                                 \
    }

/* Globals */

tTile tiles[TOTAL_GAME_TILES];

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
    tTile * tilePtr = &(tiles[0]);
    tTile * rhsTilePtr = &(tiles[RHS_FIRST_TILE]);
    tTile * lhsTilePtr = &(tiles[LHS_FIRST_TILE]);
    
    for (tileY = 0; tileY < GAME_NUM_TILES_TALL; tileY++)
    {
        lastOffset = SCREEN_ADDRESS_FOR_TILE_AT_X_Y(0, tileY * TILE_HEIGHT);
        
        for (tileX = 0; tileX < LHS_NUM_TILES_WIDE; tileX++)
        {
            lhsTilePtr->dirty = 0;
            lhsTilePtr->offset = lastOffset;
            lhsTilePtr->type = TILE_EMPTY;

            if (tileY == 0)
                lhsTilePtr->tileAbove = INVALID_TILE_NUM;
            else
                lhsTilePtr->tileAbove = LHS_X_Y_TO_TILE_OFFSET(tileX, tileY - 1);
            
            if (tileY == GAME_NUM_TILES_TALL - 1)
                lhsTilePtr->tileBelow = INVALID_TILE_NUM;
            else
                lhsTilePtr->tileBelow = LHS_X_Y_TO_TILE_OFFSET(tileX, tileY + 1);
            
            if (tileX == 0)
                lhsTilePtr->tileLeft = INVALID_TILE_NUM;
            else
                lhsTilePtr->tileLeft = LHS_X_Y_TO_TILE_OFFSET(tileX - 1, tileY);
            
            if (tileX == LHS_NUM_TILES_WIDE - 1)
                lhsTilePtr->tileRight = GAME_X_Y_TO_TILE_OFFSET(0, tileY);
            else
                lhsTilePtr->tileRight = LHS_X_Y_TO_TILE_OFFSET(tileX + 1, tileY);

            lhsTilePtr->dummy = 0;
            
            lhsTilePtr++;
                
            lastOffset += 4;
        }
        
        for (tileX = 0; tileX < GAME_NUM_TILES_WIDE; tileX++)
        {
            tilePtr->dirty = 0;
            tilePtr->offset = lastOffset;
            tilePtr->type = TILE_EMPTY;
            
            if (tileY == 0)
                tilePtr->tileAbove = INVALID_TILE_NUM;
            else
                tilePtr->tileAbove = GAME_X_Y_TO_TILE_OFFSET(tileX, tileY - 1);
            
            if (tileY == GAME_NUM_TILES_TALL - 1)
                tilePtr->tileBelow = INVALID_TILE_NUM;
            else
                tilePtr->tileBelow = GAME_X_Y_TO_TILE_OFFSET(tileX, tileY + 1);
            
            if (tileX == 0)
                tilePtr->tileLeft = LHS_X_Y_TO_TILE_OFFSET(LHS_NUM_TILES_WIDE - 1, tileY);
            else
                tilePtr->tileLeft = GAME_X_Y_TO_TILE_OFFSET(tileX - 1, tileY);
            
            if (tileX == GAME_NUM_TILES_WIDE - 1)
                tilePtr->tileRight = RHS_X_Y_TO_TILE_OFFSET(0, tileY);
            else
                tilePtr->tileRight = GAME_X_Y_TO_TILE_OFFSET(tileX + 1, tileY);
            
            tilePtr->dummy = 0;
            tilePtr++;
            
            lastOffset += 4;
        }
        
        for (tileX = 0; tileX < RHS_NUM_TILES_WIDE; tileX++)
        {
            rhsTilePtr->dirty = 0;
            rhsTilePtr->offset = lastOffset;
            rhsTilePtr->type = TILE_EMPTY;

            if (tileY == 0)
                rhsTilePtr->tileAbove = INVALID_TILE_NUM;
            else
                rhsTilePtr->tileAbove = RHS_X_Y_TO_TILE_OFFSET(tileX, tileY - 1);
            
            if (tileY == GAME_NUM_TILES_TALL - 1)
                rhsTilePtr->tileBelow = INVALID_TILE_NUM;
            else
                rhsTilePtr->tileBelow = RHS_X_Y_TO_TILE_OFFSET(tileX, tileY + 1);
            
            if (tileX == 0)
                rhsTilePtr->tileLeft = GAME_X_Y_TO_TILE_OFFSET(GAME_NUM_TILES_WIDE - 1, tileY);
            else
                rhsTilePtr->tileLeft = RHS_X_Y_TO_TILE_OFFSET(tileX - 1, tileY);
            
            if (tileX == RHS_NUM_TILES_WIDE - 1)
                rhsTilePtr->tileRight = INVALID_TILE_NUM;
            else
                rhsTilePtr->tileRight = RHS_X_Y_TO_TILE_OFFSET(tileX + 1, tileY);

            rhsTilePtr->dummy = 0;
            rhsTilePtr++;
            
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
        tiles[tileNum].type = TILE_PLAYER;
        ADD_DIRTY_NON_GAME_TILE(tileNum);
    }
    
    tileNum = LHS_FIRST_TILE + (1 * LHS_NUM_TILES_WIDE) + 6;
    tiles[tileNum].type = TILE_LETTER_S;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_C;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_O;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_R;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_SYMBOL_COLON;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (4 * LHS_NUM_TILES_WIDE) - 2;
    tiles[tileNum].type = TILE_NUMBER_0;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (12 * LHS_NUM_TILES_WIDE) + 1;
    tiles[tileNum].type = TILE_LETTER_H;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_I;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_G;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_H;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_S;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_C;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_O;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_R;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tiles[tileNum].type = TILE_SYMBOL_COLON;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (15 * LHS_NUM_TILES_WIDE) - 2;
    tiles[tileNum].type = TILE_NUMBER_0;
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
        if (tiles[tileNum].type != TILE_EMPTY)
            continue;
        
        tiles[tileNum].type = TILE_MUSHROOM4;
        ADD_DIRTY_GAME_TILE(tileNum);
        numMushrooms++;
    }
}
