/*
 *  tiles.h
 *  BuGS
 *
 *  Created by Jeremy Rand on 2020-07-14.
 * Copyright © 2020 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTBuGS_FILEtiles_
#define _GUARD_PROJECTBuGS_FILEtiles_


#include <types.h>


/* Defines */

#define GAME_NUM_TILES_WIDE 25
#define GAME_NUM_TILES_TALL 25

#define NUM_GAME_TILES (GAME_NUM_TILES_WIDE * GAME_NUM_TILES_TALL)

#define RHS_NUM_TILES_WIDE 2
#define NUM_RHS_NON_GAME_TILES (RHS_NUM_TILES_WIDE * GAME_NUM_TILES_TALL)
#define RHS_FIRST_TILE NUM_GAME_TILES

#define LHS_NUM_TILES_WIDE 13
#define NUM_LHS_NON_GAME_TILES (LHS_NUM_TILES_WIDE * GAME_NUM_TILES_TALL)
#define LHS_FIRST_TILE (RHS_FIRST_TILE + NUM_RHS_NON_GAME_TILES)

#define NUM_NON_GAME_TILES (NUM_RHS_NON_GAME_TILES + NUM_LHS_NON_GAME_TILES)

#define TOTAL_GAME_TILES (NUM_GAME_TILES + NUM_NON_GAME_TILES)

#define INVALID_TILE_NUM 0xffff


/* Types */

typedef word tTileNum;
typedef word tTileOffset;   /* A tile offset is a tile number times the sizeof(tTile). */


typedef enum {
    TILE_EMPTY = 0,
    TILE_MUSHROOM1 = 1 * 4,
    TILE_MUSHROOM2 = 2 * 4,
    TILE_MUSHROOM3 = 3 * 4,
    TILE_MUSHROOM4 = 4 * 4,
    TILE_POISON_MUSHROOM1 = 9 * 4,
    TILE_POISON_MUSHROOM2 = 10 * 4,
    TILE_POISON_MUSHROOM3 = 11 * 4,
    TILE_POISON_MUSHROOM4 = 12 * 4,
    
    TILE_SYMBOL_C = 5 * 4,
    TILE_SYMBOL_P = 6 * 4,
    TILE_SYMBOL_DOT = 7 * 4,
    TILE_SYMBOL_COLON = 8 * 4,
    
    TILE_LETTER_A = 13 * 4,
    TILE_LETTER_B = 14 * 4,
    TILE_LETTER_C = 15 * 4,
    TILE_LETTER_D = 16 * 4,
    TILE_LETTER_E = 17 * 4,
    TILE_LETTER_F = 18 * 4,
    TILE_LETTER_G = 19 * 4,
    TILE_LETTER_H = 20 * 4,
    TILE_LETTER_I = 21 * 4,
    TILE_LETTER_J = 22 * 4,
    TILE_LETTER_K = 23 * 4,
    TILE_LETTER_L = 24 * 4,
    TILE_LETTER_M = 25 * 4,
    TILE_LETTER_N = 26 * 4,
    TILE_LETTER_O = 27 * 4,
    TILE_LETTER_P = 28 * 4,
    TILE_LETTER_Q = 29 * 4,
    TILE_LETTER_R = 30 * 4,
    TILE_LETTER_S = 31 * 4,
    TILE_LETTER_T = 32 * 4,
    TILE_LETTER_U = 33 * 4,
    TILE_LETTER_V = 34 * 4,
    TILE_LETTER_W = 35 * 4,
    TILE_LETTER_X = 36 * 4,
    TILE_LETTER_Y = 37 * 4,
    TILE_LETTER_Z = 38 * 4,
    
    TILE_NUMBER_0 = 39 * 4,
    TILE_NUMBER_1 = 40 * 4,
    TILE_NUMBER_2 = 41 * 4,
    TILE_NUMBER_3 = 42 * 4,
    TILE_NUMBER_4 = 43 * 4,
    TILE_NUMBER_5 = 44 * 4,
    TILE_NUMBER_6 = 45 * 4,
    TILE_NUMBER_7 = 46 * 4,
    TILE_NUMBER_8 = 47 * 4,
    TILE_NUMBER_9 = 48 * 4,
    
    TILE_SOLID1 = 49 * 4,
    TILE_SOLID2 = 50 * 4,
    TILE_SOLID3 = 51 * 4,
    
    TILE_PLAYER = 52 * 4,
} tTileType;


typedef struct
{
    word dirty;
    word offset;
    tTileType type;
    
    tTileOffset tileAbove;
    tTileOffset tileBelow;
    tTileOffset tileLeft;
    tTileOffset tileRight;
    word dummy; /* I want a size which is a multiple of 2 */
} tTile;


/* Globals */

extern tTile tiles[TOTAL_GAME_TILES];
extern tTileOffset dirtyGameTiles[NUM_GAME_TILES + GAME_NUM_TILES_TALL];
extern word numDirtyGameTiles;
extern tTileOffset dirtyNonGameTiles[NUM_NON_GAME_TILES];
extern word numDirtyNonGameTiles;


/* API */

extern void initTiles(void);
extern void initPlayer(void);
extern void addStartingMushrooms(void);


#endif /* define _GUARD_PROJECTBuGS_FILEtiles_ */
