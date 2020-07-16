/*
 *  tiles.h
 *  BuGS
 *
 *  Created by Jeremy Rand on 2020-07-14.
 * Copyright © 2020 Jeremy Rand. All rights reserved.
 */

#ifndef _GUARD_PROJECTBuGS_FILEtiles_
#define _GUARD_PROJECTBuGS_FILEtiles_


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


/* Types */

typedef enum {
    TILE_EMPTY = 0,
    TILE_MUSHROOM1 = 1,
    TILE_MUSHROOM2 = 2,
    TILE_MUSHROOM3 = 3,
    TILE_MUSHROOM4 = 4,
    TILE_POISON_MUSHROOM1 = 9,
    TILE_POISON_MUSHROOM2 = 10,
    TILE_POISON_MUSHROOM3 = 11,
    TILE_POISON_MUSHROOM4 = 12,
    
    TILE_SYMBOL_C = 5,
    TILE_SYMBOL_P = 6,
    TILE_SYMBOL_DOT = 7,
    TILE_SYMBOL_COLON = 8,
    
    TILE_LETTER_A = 13,
    TILE_LETTER_B = 14,
    TILE_LETTER_C = 15,
    TILE_LETTER_D = 16,
    TILE_LETTER_E = 17,
    TILE_LETTER_F = 18,
    TILE_LETTER_G = 19,
    TILE_LETTER_H = 20,
    TILE_LETTER_I = 21,
    TILE_LETTER_J = 22,
    TILE_LETTER_K = 23,
    TILE_LETTER_L = 24,
    TILE_LETTER_M = 25,
    TILE_LETTER_N = 26,
    TILE_LETTER_O = 27,
    TILE_LETTER_P = 28,
    TILE_LETTER_Q = 29,
    TILE_LETTER_R = 30,
    TILE_LETTER_S = 31,
    TILE_LETTER_T = 32,
    TILE_LETTER_U = 33,
    TILE_LETTER_V = 34,
    TILE_LETTER_W = 35,
    TILE_LETTER_X = 36,
    TILE_LETTER_Y = 37,
    TILE_LETTER_Z = 38,
    
    TILE_NUMBER_0 = 39,
    TILE_NUMBER_1 = 40,
    TILE_NUMBER_2 = 41,
    TILE_NUMBER_3 = 42,
    TILE_NUMBER_4 = 43,
    TILE_NUMBER_5 = 44,
    TILE_NUMBER_6 = 45,
    TILE_NUMBER_7 = 46,
    TILE_NUMBER_8 = 47,
    TILE_NUMBER_9 = 48,
    
    TILE_SOLID1 = 49,
    TILE_SOLID2 = 50,
    TILE_SOLID3 = 51,
    
    TILE_PLAYER = 52,
} tTileType;


typedef struct
{
    unsigned int dirty;
    unsigned int offset;
    tTileType type;
    unsigned int dummy; /* I want a size which is a multiple of 2 */
} tTile;


/* Globals */

extern tTile tiles[TOTAL_GAME_TILES];
extern unsigned int dirtyGameTiles[NUM_GAME_TILES + GAME_NUM_TILES_TALL];
extern unsigned int numDirtyGameTiles;
extern unsigned int dirtyNonGameTiles[NUM_NON_GAME_TILES];
extern unsigned int numDirtyNonGameTiles;


/* API */

extern void initTiles(void);
extern void initPlayer(void);
extern void addStartingMushrooms(void);


#endif /* define _GUARD_PROJECTBuGS_FILEtiles_ */
