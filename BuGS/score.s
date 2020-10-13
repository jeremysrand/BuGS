;
;  score.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-10-12.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

		case on
        mcopy score.macros
        keep score

score start
		using globalData

TILE_SCORE_ONES 		equ 4*LHS_NUM_TILES_WIDE+LHS_FIRST_TILE-2
TILE_SCORE_ONES_OFFSET		equ TILE_SCORE_ONES*SIZEOF_TILE_INFO
TILE_SCORE_TENS_OFFSET		equ TILE_SCORE_ONES-SIZEOF_TILE_INFO
TILE_SCORE_HUNDREDS_OFFSET	equ TILE_SCORE_TENS_OFFSET-SIZEOF_TILE_INFO
TILE_SCORE_THOUSANDS_OFFSET	equ TILE_SCORE_HUNDREDS_OFFSET-SIZEOF_TILE_INFO

scoreStartGame entry
		stz gameScore
		stz gameScore+2
		lda #1
		sta gameIsHighScore
		
		ldx #TILE_SCORE_ONES_OFFSET
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile

; Tens
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Hundreds
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Thousands
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Tens of Thousands
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Hundreds of Thousands
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Millions
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Tens of Millions
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Hundreds of Millions
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

; Billions
		dex
		dex
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile

		rtl


scoreAddOne entry
; TODO - Write this code...
		rtl


scoreAddFive entry
; TODO - Write this code...
		rtl


scoreAddTen entry
; TODO - Write this code...
		rtl


scoreAddOneHundred entry
; TODO - Write this code...
		rtl


scoreAddTwoHundred entry
; TODO - Write this code...
		rtl


scoreAddThreeHundred entry
; TODO - Write this code...
		rtl


scoreAddSixHundred entry
; TODO - Write this code...
		rtl


scoreAddNineHundred entry
; TODO - Write this code...
		rtl


scoreAddOneThousand entry
; TODO - Write this code...
		rtl


highScore	dc i4'0'
gameScore  	dc i4'0'
gameIsHighScore	dc i2'1'

        end
