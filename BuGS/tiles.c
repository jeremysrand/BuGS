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

#define STARTING_NUM_PLAYERS 3

#define ADD_DIRTY_NON_GAME_TILE(tileNum)                                          \
    if (!tileDirty[tileNum]) {                                                    \
        tileDirty[tileNum] = 1;                                                   \
        dirtyNonGameTiles[numDirtyNonGameTiles / 2] = ((tileNum) * sizeof(word)); \
        numDirtyNonGameTiles += 2;                                                \
    }

/* Globals */

word tileDirty[TOTAL_NUM_TILES];
word tileScreenOffset[TOTAL_NUM_TILES];
tTileType tileType[TOTAL_NUM_TILES];
tTileOffset tileAbove[TOTAL_NUM_TILES];
tTileOffset tileBelow[TOTAL_NUM_TILES];
tTileOffset tileLeft[TOTAL_NUM_TILES];
tTileOffset tileRight[TOTAL_NUM_TILES];
word tileBitOffset[NUM_GAME_TILES];
word tileBitMask[NUM_GAME_TILES];

tTileOffset dirtyNonGameTiles[NUM_NON_GAME_TILES];
word numDirtyNonGameTiles;


/* Implementation */

void initTiles(void)
{
    word tileX;
    word tileY;
    word lastOffset;
    word tileIndex = 0;
    word bitOffset = 0;
    word bitMask = 1;
    word rhsTileIndex = RHS_FIRST_TILE;
    word lhsTileIndex = LHS_FIRST_TILE;
    
    for (tileY = 0; tileY < GAME_NUM_TILES_TALL; tileY++)
    {
        lastOffset = SCREEN_ADDRESS_FOR_TILE_AT_X_Y(0, tileY * TILE_HEIGHT);
        
        for (tileX = 0; tileX < LHS_NUM_TILES_WIDE; tileX++)
        {
            tileDirty[lhsTileIndex] = 0;
            tileScreenOffset[lhsTileIndex] = lastOffset;
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
            tileScreenOffset[tileIndex] = lastOffset;
            tileType[tileIndex] = TILE_EMPTY;
            tileBitOffset[tileIndex] = bitOffset;
            tileBitMask[tileIndex] = bitMask;
            
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
            
            if (bitMask == 0x8000)
            {
                bitOffset += sizeof(word);
                bitMask = 1;
            }
            else
            {
                bitMask <<= 1;
            }
            
            lastOffset += 4;
        }
        
        for (tileX = 0; tileX < RHS_NUM_TILES_WIDE; tileX++)
        {
            tileDirty[rhsTileIndex] = 0;
            tileScreenOffset[rhsTileIndex] = lastOffset;
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
    
    numDirtyNonGameTiles = 0;
}


void initNonGameTiles(void)
{
    unsigned int i;
    tTileNum tileNum;
    
    tileNum = LHS_FIRST_TILE + (LHS_NUM_TILES_WIDE / 2);
    tileType[tileNum] = TILE_LETTER_B;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_WHITE_U;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_GREEN_G;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_GREEN_S;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (3 * LHS_NUM_TILES_WIDE);
    tileType[tileNum] = TILE_LETTER_P;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_L;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_A;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_Y;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_R;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileNum++;
    tileType[tileNum] = TILE_NUMBER_1;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (5 * LHS_NUM_TILES_WIDE) + 2;
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
    
    tileNum = LHS_FIRST_TILE + (7 * LHS_NUM_TILES_WIDE) - 2;
    tileType[tileNum] = TILE_NUMBER_0;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (8 * LHS_NUM_TILES_WIDE) + 2;
    tileType[tileNum] = TILE_LETTER_L;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_I;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_V;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_S;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_SYMBOL_COLON;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (10 * LHS_NUM_TILES_WIDE) - 2;
    for (i = 0; i < STARTING_NUM_PLAYERS; i++)
    {
        tileType[tileNum] = TILE_PLAYER;
        ADD_DIRTY_NON_GAME_TILE(tileNum);
        tileNum--;
    }
    
    tileNum = LHS_FIRST_TILE + (12 * LHS_NUM_TILES_WIDE);
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
    
    tileNum = LHS_FIRST_TILE + (14 * LHS_NUM_TILES_WIDE) - 2;
    tileType[tileNum] = TILE_NUMBER_0;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (16 * LHS_NUM_TILES_WIDE);
    tileType[tileNum] = TILE_LETTER_P;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_L;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_A;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_Y;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_R;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileNum++;
    tileType[tileNum] = TILE_NUMBER_2;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (18 * LHS_NUM_TILES_WIDE) + 2;
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
    
    tileNum = LHS_FIRST_TILE + (20 * LHS_NUM_TILES_WIDE) - 2;
    tileType[tileNum] = TILE_NUMBER_0;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (21 * LHS_NUM_TILES_WIDE) + 2;
    tileType[tileNum] = TILE_LETTER_L;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_I;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_V;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_E;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_LETTER_S;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum++;
    tileType[tileNum] = TILE_SYMBOL_COLON;
    ADD_DIRTY_NON_GAME_TILE(tileNum);
    
    tileNum = LHS_FIRST_TILE + (23 * LHS_NUM_TILES_WIDE) - 2;
    for (i = 0; i < STARTING_NUM_PLAYERS; i++)
    {
        tileType[tileNum] = TILE_PLAYER;
        ADD_DIRTY_NON_GAME_TILE(tileNum);
        tileNum--;
    }
}
