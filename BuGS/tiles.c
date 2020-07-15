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

unsigned int dirtyGameTiles[NUM_GAME_TILES];
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
    tTile * playerTilePtr = &(tiles[FIRST_PLAYER_TILE]);
    
    for (tileY = 0; tileY < GAME_NUM_TILES_TALL; tileY++)
    {
        lastOffset = TILE_OFFSET_FOR_X_Y(GAME_LEFT_MOST_X_POS, GAME_TOP_MOST_Y_POS + (tileY * TILE_HEIGHT));
        tilePtr->dirty = 0;
        tilePtr->offset = lastOffset;
        tilePtr->type = TILE_EMPTY;
        tilePtr->dummy = 0;
        tilePtr++;
        
        for (tileX = 1; tileX < GAME_NUM_TILES_WIDE; tileX++)
        {
            lastOffset += 4;
            tilePtr->dirty = 0;
            tilePtr->offset = lastOffset;
            tilePtr->type = TILE_EMPTY;
            tilePtr->dummy = 0;
            tilePtr++;
        }
        
        lastOffset += 4;
        playerTilePtr->dirty = 0;
        playerTilePtr->offset = lastOffset;
        playerTilePtr->type = TILE_EMPTY;
        playerTilePtr->dummy = 0;
        playerTilePtr++;
        
        lastOffset += 4;
        playerTilePtr->dirty = 0;
        playerTilePtr->offset = lastOffset;
        playerTilePtr->type = TILE_EMPTY;
        playerTilePtr->dummy = 0;
        playerTilePtr++;
    }
    
    numDirtyGameTiles = 0;
}


void initPlayer(void)
{
    unsigned int i;
    unsigned int tileNum;
    numPlayers = STARTING_NUM_PLAYERS;
    for (i = 0; i < numPlayers; i++)
    {
        tileNum = FIRST_PLAYER_TILE + i;
        tiles[tileNum].dirty = 1;
        tiles[tileNum].type = TILE_PLAYER;
        
        dirtyNonGameTiles[numDirtyNonGameTiles] = tileNum;
        numDirtyNonGameTiles++;
    }
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
