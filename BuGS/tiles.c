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

#define TILE_OFFSET_FOR_X_Y(X, Y) \
    (0x2000 + (0xa0 * (Y)) + ((X) / 2) + 3)

#define STARTING_NUM_MUSHROOMS 30
#define STARTING_NUM_PLAYERS 3


/* Globals */

tTile tiles[TOTAL_GAME_TILES];

unsigned int dirtyGameTiles[NUM_GAME_TILES + GAME_NUM_TILES_TALL];
unsigned int numDirtyGameTiles;

unsigned int dirtyNonGameTiles[NUM_NON_GAME_TILES];
unsigned int numDirtyNonGameTiles;

unsigned int numPlayers;


/* Implementation */

void initTiles(void)
{
    int tileX;
    int tileY;
    int lastOffset;
    tTile * tilePtr = &(tiles[0]);
    tTile * rhsTilePtr = &(tiles[RHS_FIRST_TILE]);
    tTile * lhsTilePtr = &(tiles[LHS_FIRST_TILE]);
    
    for (tileY = 0; tileY < GAME_NUM_TILES_TALL; tileY++)
    {
        lastOffset = TILE_OFFSET_FOR_X_Y(0, tileY * TILE_HEIGHT);
        
        for (tileX = 0; tileX < LHS_NUM_TILES_WIDE; tileX++)
        {
            lhsTilePtr->dirty = 0;
            lhsTilePtr->offset = lastOffset;
            lhsTilePtr->type = TILE_EMPTY;
            lhsTilePtr->dummy = 0;
            lhsTilePtr++;
                
            lastOffset += 4;
        }
        
        for (tileX = 0; tileX < GAME_NUM_TILES_WIDE; tileX++)
        {
            tilePtr->dirty = 0;
            tilePtr->offset = lastOffset;
            tilePtr->type = TILE_EMPTY;
            tilePtr->dummy = 0;
            tilePtr++;
            
            lastOffset += 4;
        }
        
        for (tileX = 0; tileX < RHS_NUM_TILES_WIDE; tileX++)
        {
            rhsTilePtr->dirty = 0;
            rhsTilePtr->offset = lastOffset;
            rhsTilePtr->type = TILE_EMPTY;
            rhsTilePtr->dummy = 0;
            rhsTilePtr++;
            
            lastOffset += 4;
        }
    }
    
    numDirtyGameTiles = 0;
}


void initNonGameTiles(void)
{
    unsigned int i;
    unsigned int tileNum;
    numPlayers = STARTING_NUM_PLAYERS;
    for (i = 0; i < numPlayers; i++)
    {
        tileNum = RHS_FIRST_TILE + i;
        tiles[tileNum].dirty = 1;
        tiles[tileNum].type = TILE_PLAYER;
        
        dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
        numDirtyNonGameTiles++;
    }
    
    tileNum = LHS_FIRST_TILE + (1 * LHS_NUM_TILES_WIDE) + 6;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_S;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_C;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_O;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_R;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_E;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_SYMBOL_COLON;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum = LHS_FIRST_TILE + (4 * LHS_NUM_TILES_WIDE) - 2;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_NUMBER_0;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum = LHS_FIRST_TILE + (12 * LHS_NUM_TILES_WIDE) + 1;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_H;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_I;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_G;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_H;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_S;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_C;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_O;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_R;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_LETTER_E;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum++;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_SYMBOL_COLON;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
    
    tileNum = LHS_FIRST_TILE + (15 * LHS_NUM_TILES_WIDE) - 2;
    tiles[tileNum].dirty = 1;
    tiles[tileNum].type = TILE_NUMBER_0;
    dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
    numDirtyNonGameTiles++;
}


void addStartingMushrooms(void)
{
    int tileNum;
    int numMushrooms = 0;
    
    while (numMushrooms < STARTING_NUM_MUSHROOMS)
    {
        /* We do not put mushrooms in the bottom tile so we subtract the width here to find
            a tile number above that last line */
        tileNum = rand() % (NUM_GAME_TILES - GAME_NUM_TILES_WIDE);
        if (tiles[tileNum].type != TILE_EMPTY)
            continue;
        
        tiles[tileNum].type = TILE_MUSHROOM4;
        tiles[tileNum].dirty = 1;
        dirtyGameTiles[numDirtyGameTiles] = tileNum;
        numDirtyGameTiles++;
        numMushrooms++;
    }
}
