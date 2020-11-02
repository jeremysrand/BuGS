;
;  globals.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-21.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy globals.macros
        keep globals

globals start
		end

globalData data


SEGMENT_DIR_LEFT    equ 0
SEGMENT_DIR_RIGHT   equ 1

; The code uses segmentPixelOffset and the segment speed to figure out whether to draw the shifted sprite
; or the regular sprite.  By AND-ing with the speed, if the result is 0, then we want a non-shifted sprite.
; If the result is non-zero, we want a shifted sprite.  Then, we just need a per segment speed instead of a
; per position offset screen shift.  Similarly, the same result can be used to figure out whether we need
; to increment/decrement the screen offset when updating segment position.
SEGMENT_SPEED_FAST      equ 0
SEGMENT_SPEED_SLOW      equ 1

; A spider only travels in the bottom N rows.  This defines that number.
SPIDER_MAX_NUM_POSSIBLE_ROWS    equ 10
SPIDER_STARTING_TOP_ROW         equ GAME_NUM_TILES_TALL-SPIDER_MAX_NUM_POSSIBLE_ROWS
SPIDER_STARTING_TOP_ROW_OFFSET  equ SPIDER_STARTING_TOP_ROW*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO

SCREEN_BYTES_PER_ROW    gequ 160

SIZEOF_TILE_INFO        gequ 2

TILE_PIXEL_WIDTH        gequ 8
TILE_PIXEL_HEIGHT       gequ 8

TILE_BYTE_WIDTH         gequ TILE_PIXEL_WIDTH/2

GAME_NUM_TILES_WIDE     gequ 25
GAME_NUM_TILES_TALL     gequ 25

NUM_GAME_TILES          gequ GAME_NUM_TILES_WIDE*GAME_NUM_TILES_TALL

RHS_NUM_TILES_WIDE      gequ 2
NUM_RHS_NON_GAME_TILES  gequ RHS_NUM_TILES_WIDE*GAME_NUM_TILES_TALL
RHS_FIRST_TILE          gequ NUM_GAME_TILES
RHS_FIRST_TILE_OFFSET   gequ RHS_FIRST_TILE*SIZEOF_TILE_INFO

LHS_NUM_TILES_WIDE      gequ 13
NUM_LHS_NON_GAME_TILES  gequ LHS_NUM_TILES_WIDE*GAME_NUM_TILES_TALL
LHS_FIRST_TILE          gequ RHS_FIRST_TILE+NUM_RHS_NON_GAME_TILES
LHS_FIRST_TILE_OFFSET   gequ LHS_FIRST_TILE*SIZEOF_TILE_INFO

NUM_NON_GAME_TILES      gequ NUM_RHS_NON_GAME_TILES+NUM_LHS_NON_GAME_TILES

TOTAL_NUM_TILES         gequ NUM_GAME_TILES+NUM_NON_GAME_TILES

INVALID_TILE_NUM        gequ $ffff

TILE_STATE_CLEAN        gequ 0
TILE_STATE_DIRTY        gequ 1

TILE_EMPTY              gequ 0
TILE_MUSHROOM1          gequ 1*4
TILE_MUSHROOM2          gequ 2*4
TILE_MUSHROOM3          gequ 3*4
TILE_MUSHROOM4          gequ 4*4
TILE_POISON_MUSHROOM1   gequ 9*4
TILE_POISON_MUSHROOM2   gequ 10*4
TILE_POISON_MUSHROOM3   gequ 11*4
TILE_POISON_MUSHROOM4   gequ 12*4

TILE_SYMBOL_C           gequ 5*4
TILE_SYMBOL_P           gequ 6*4
TILE_SYMBOL_DOT         gequ 7*4
TILE_SYMBOL_COLON       gequ 8*4

TILE_LETTER_A           gequ 13*4
TILE_LETTER_B           gequ 14*4
TILE_LETTER_C           gequ 15*4
TILE_LETTER_D           gequ 16*4
TILE_LETTER_E           gequ 17*4
TILE_LETTER_F           gequ 18*4
TILE_LETTER_G           gequ 19*4
TILE_LETTER_H           gequ 20*4
TILE_LETTER_I           gequ 21*4
TILE_LETTER_J           gequ 22*4
TILE_LETTER_K           gequ 23*4
TILE_LETTER_L           gequ 24*4
TILE_LETTER_M           gequ 25*4
TILE_LETTER_N           gequ 26*4
TILE_LETTER_O           gequ 27*4
TILE_LETTER_P           gequ 28*4
TILE_LETTER_Q           gequ 29*4
TILE_LETTER_R           gequ 30*4
TILE_LETTER_S           gequ 31*4
TILE_LETTER_T           gequ 32*4
TILE_LETTER_U           gequ 33*4
TILE_LETTER_V           gequ 34*4
TILE_LETTER_W           gequ 35*4
TILE_LETTER_X           gequ 36*4
TILE_LETTER_Y           gequ 37*4
TILE_LETTER_Z           gequ 38*4

TILE_NUMBER_0           gequ 39*4
TILE_NUMBER_1           gequ 40*4
TILE_NUMBER_2           gequ 41*4
TILE_NUMBER_3           gequ 42*4
TILE_NUMBER_4           gequ 43*4
TILE_NUMBER_5           gequ 44*4
TILE_NUMBER_6           gequ 45*4
TILE_NUMBER_7           gequ 46*4
TILE_NUMBER_8           gequ 47*4
TILE_NUMBER_9           gequ 48*4

TILE_SOLID1             gequ 49*4
TILE_SOLID2             gequ 50*4
TILE_SOLID3             gequ 51*4

TILE_PLAYER             gequ 52*4
TILE_LETTER_WHITE_U     gequ 53*4
TILE_LETTER_GREEN_G     gequ 54*4
TILE_LETTER_GREEN_S     gequ 55*4

TILE_POISON_A_MUSHROOM  gequ TILE_POISON_MUSHROOM4-TILE_MUSHROOM4

NUM_COLOUR_PALETTES     gequ 14

SPRITE_SPEED_SLOW     gequ 0
SPRITE_SPEED_FAST     gequ 1

KEYBOARD                gequ $e0c000
KEYBOARD_STROBE         gequ $e0c010
READ_VBL                gequ $e0c019
SHADOW_REGISTER         gequ $e0c035
NEW_VIDEO_REGISTER      gequ $e0c029
BORDER_COLOUR_REGISTER  gequ $e0c034
STATE_REGISTER          gequ $e1c068
VERTICAL_COUNTER        gequ $e0c02e
MOUSE_STATUS			gequ $c027
MOUSE_DATA_REG			gequ $c024


gameRunning	dc i2'1'

; The following data values hold the game state and when/if 2 player is supported,
; this information will need to be copied to a backup location when the player
; switches.
numSegments 		dc i2'0'
gameLevel   		dc i2'0'
gameScore  			dc i4'0'
scoreWithin12000	dc i2'0'
scoreWithin20000	dc i2'0'
scoreNum20000		dc i2'0'
centipedeLevelNum	dc i2'0'
colourLevelNum		dc i2'0'
; numInfieldMushrooms
; tileType


backupStack dc i2'0'

tileJumpTable dc a4'solid0'
              dc a4'mushroom4'
              dc a4'mushroom3'
              dc a4'mushroom2'
              dc a4'mushroom1'
              dc a4'symbolC'
              dc a4'symbolP'
              dc a4'symbolDot'
              dc a4'symbolColon'
              dc a4'poisonedMushroom4'
              dc a4'poisonedMushroom3'
              dc a4'poisonedMushroom2'
              dc a4'poisonedMushroom1'
              dc a4'letterA'
              dc a4'letterB'
              dc a4'letterC'
              dc a4'letterD'
              dc a4'letterE'
              dc a4'letterF'
              dc a4'letterG'
              dc a4'letterH'
              dc a4'letterI'
              dc a4'letterJ'
              dc a4'letterK'
              dc a4'letterL'
              dc a4'letterM'
              dc a4'letterN'
              dc a4'letterO'
              dc a4'letterP'
              dc a4'letterQ'
              dc a4'letterR'
              dc a4'letterS'
              dc a4'letterT'
              dc a4'letterU'
              dc a4'letterV'
              dc a4'letterW'
              dc a4'letterX'
              dc a4'letterY'
              dc a4'letterZ'
              dc a4'number0'
              dc a4'number1'
              dc a4'number2'
              dc a4'number3'
              dc a4'number4'
              dc a4'number5'
              dc a4'number6'
              dc a4'number7'
              dc a4'number8'
              dc a4'number9'
              dc a4'solid1'
              dc a4'solid2'
              dc a4'solid3'
              dc a4'drawPlayer'
              dc a4'letterWhiteU'
              dc a4'letterGreenG'
              dc a4'letterGreenS'


EXPLOSION_LAST_OFFSET   gequ 20

explosionJumpTable dc i4'explosion6'
                   dc i4'explosion5'
                   dc i4'explosion4'
                   dc i4'explosion3'
                   dc i4'explosion2'
                   dc i4'explosion1'
                   
        end
