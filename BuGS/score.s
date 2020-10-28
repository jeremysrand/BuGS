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

TILE_SCORE_7TH_ROW		equ LHS_FIRST_TILE+7*LHS_NUM_TILES_WIDE
TILE_SCORE_ONES 		equ TILE_SCORE_7TH_ROW-2
TILE_SCORE_ONES_OFFSET		equ TILE_SCORE_ONES*SIZEOF_TILE_INFO
TILE_SCORE_TENS_OFFSET		equ TILE_SCORE_ONES_OFFSET-SIZEOF_TILE_INFO
TILE_SCORE_HUNDREDS_OFFSET	equ TILE_SCORE_TENS_OFFSET-SIZEOF_TILE_INFO
TILE_SCORE_THOUSANDS_OFFSET	equ TILE_SCORE_HUNDREDS_OFFSET-SIZEOF_TILE_INFO
TILE_SCORE_TEN_THOUSANDS_OFFSET	equ TILE_SCORE_THOUSANDS_OFFSET-SIZEOF_TILE_INFO

scoreStartGame entry
		stz gameScore
		stz gameScore+2
		stz scoreWithin12000
		stz scoreWithin20000
		stz scoreNum20000
		
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


; The score tile to increment is in the X register
; Note that this function and the next one do no sanitization
; of the value in the X register.  That also means that if
; someone scores several trillion in a single game, we will
; keep adding digits to the score displayed, eventually
; occupying tiles on the previous line on the LHS.
;
; But it is kind of classic for these arcade games to act
; weird if people do something deemed impossible by the
; author.  So, I challenge you to get such a score!
scoreAddOneToTile entry
		_dirtyNonGameTile
		lda tileType,x
		beq scoreAddOneToTile_empty
		cmp #TILE_NUMBER_9
		beq scoreAddOneToTile_isNine anop
		clc
		adc #4
		bra scoreAddOneToTile_done
scoreAddOneToTile_empty anop
		lda #TILE_NUMBER_1
scoreAddOneToTile_done anop
		sta tileType,x
		rtl
scoreAddOneToTile_isNine anop
		lda #TILE_NUMBER_0
		sta tileType,x
		dex
		dex
		jmp scoreAddOneToTile
		

; The score tile to add to is in the X register
; The amount to add to the tile is in the accumulator
; and must be 4 to 36 in multiples of 4.  This is because
; the tile types are all 4 apart.  So, to add one, we
; actually add 4 to the tile type.
scoreAddToTile entry
		ldy tileType,x
		bne scoreAddToTile_notEmpty
		tay
		lda #TILE_NUMBER_0
		sta tileType,x
		tya
scoreAddToTile_notEmpty anop
		clc
		adc tileType,x
		cmp #TILE_NUMBER_9+1
		blt scoreAddToTile_done
		sec
		sbc #40
		sta tileType,x
		_dirtyNonGameTile
		dex
		dex
		jmp scoreAddOneToTile
scoreAddToTile_done anop
		sta tileType,x
		_dirtyNonGameTile
		rtl
		
		
scoreAddOne entry
		_incrementScore 1
		ldx #TILE_SCORE_ONES_OFFSET
		jmp scoreAddOneToTile


scoreAddFive entry
		_incrementScore 5
		ldx #TILE_SCORE_ONES_OFFSET
		lda #5*4
		jmp scoreAddToTile


scoreAddTen entry
		_incrementScore 10
		lda tileType+TILE_SCORE_ONES_OFFSET
		bne scoreAddTen_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_ONES_OFFSET
		ldx #TILE_SCORE_ONES_OFFSET
		_dirtyNonGameTile
scoreAddTen_skipZeroOnes anop
		ldx #TILE_SCORE_TENS_OFFSET
		jmp scoreAddOneToTile


scoreAddOneHundred entry
		_incrementScore 100
		lda tileType+TILE_SCORE_ONES_OFFSET
		bne scoreAddHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_ONES_OFFSET
		ldx #TILE_SCORE_ONES_OFFSET
		_dirtyNonGameTile
scoreAddHundred_skipZeroOnes anop
		lda tileType+TILE_SCORE_TENS_OFFSET
		bne scoreAddHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_TENS_OFFSET
		ldx #TILE_SCORE_TENS_OFFSET
		_dirtyNonGameTile
scoreAddHundred_skipZeroTens anop
		ldx #TILE_SCORE_HUNDREDS_OFFSET
		jmp scoreAddOneToTile


scoreAddTwoHundred entry
		_incrementScore 200
		lda tileType+TILE_SCORE_ONES_OFFSET
		bne scoreAddTwoHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_ONES_OFFSET
		ldx #TILE_SCORE_ONES_OFFSET
		_dirtyNonGameTile
scoreAddTwoHundred_skipZeroOnes anop
		lda tileType+TILE_SCORE_TENS_OFFSET
		bne scoreAddTwoHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_TENS_OFFSET
		ldx #TILE_SCORE_TENS_OFFSET
		_dirtyNonGameTile
scoreAddTwoHundred_skipZeroTens anop
		ldx #TILE_SCORE_HUNDREDS_OFFSET
		lda #2*4
		jmp scoreAddToTile


scoreAddThreeHundred entry
		_incrementScore 300
		lda tileType+TILE_SCORE_ONES_OFFSET
		bne scoreAddThreeHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_ONES_OFFSET
		ldx #TILE_SCORE_ONES_OFFSET
		_dirtyNonGameTile
scoreAddThreeHundred_skipZeroOnes anop
		lda tileType+TILE_SCORE_TENS_OFFSET
		bne scoreAddThreeHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_TENS_OFFSET
		ldx #TILE_SCORE_TENS_OFFSET
		_dirtyNonGameTile
scoreAddThreeHundred_skipZeroTens anop
		ldx #TILE_SCORE_HUNDREDS_OFFSET
		lda #3*4
		jmp scoreAddToTile


scoreAddSixHundred entry
		_incrementScore 600
		lda tileType+TILE_SCORE_ONES_OFFSET
		bne scoreAddSixHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_ONES_OFFSET
		ldx #TILE_SCORE_ONES_OFFSET
		_dirtyNonGameTile
scoreAddSixHundred_skipZeroOnes anop
		lda tileType+TILE_SCORE_TENS_OFFSET
		bne scoreAddSixHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_TENS_OFFSET
		ldx #TILE_SCORE_TENS_OFFSET
		_dirtyNonGameTile
scoreAddSixHundred_skipZeroTens anop
		ldx #TILE_SCORE_HUNDREDS_OFFSET
		lda #6*4
		jmp scoreAddToTile


scoreAddNineHundred entry
		_incrementScore 900
		lda tileType+TILE_SCORE_ONES_OFFSET
		bne scoreAddNineHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_ONES_OFFSET
		ldx #TILE_SCORE_ONES_OFFSET
		_dirtyNonGameTile
scoreAddNineHundred_skipZeroOnes anop
		lda tileType+TILE_SCORE_TENS_OFFSET
		bne scoreAddNineHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_TENS_OFFSET
		ldx #TILE_SCORE_TENS_OFFSET
		_dirtyNonGameTile
scoreAddNineHundred_skipZeroTens anop
		ldx #TILE_SCORE_HUNDREDS_OFFSET
		lda #9*4
		jmp scoreAddToTile


scoreAddOneThousand entry
		_incrementScore 1000
		lda tileType+TILE_SCORE_ONES_OFFSET
		bne scoreAddOneThousand_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_ONES_OFFSET
		ldx #TILE_SCORE_ONES_OFFSET
		_dirtyNonGameTile
scoreAddOneThousand_skipZeroOnes anop
		lda tileType+TILE_SCORE_TENS_OFFSET
		bne scoreAddOneThousand_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_TENS_OFFSET
		ldx #TILE_SCORE_TENS_OFFSET
		_dirtyNonGameTile
scoreAddOneThousand_skipZeroTens anop
		lda tileType+TILE_SCORE_HUNDREDS_OFFSET
		bne scoreAddOneThousand_skipZeroHundreds
		lda #TILE_NUMBER_0
		sta tileType+TILE_SCORE_HUNDREDS_OFFSET
		ldx #TILE_SCORE_HUNDREDS_OFFSET
		_dirtyNonGameTile
scoreAddOneThousand_skipZeroHundreds anop
		ldx #TILE_SCORE_THOUSANDS_OFFSET
		jmp scoreAddOneToTile
		

; This function is used purely for debug to test high score threshold stuff.  It
; doesn't do all the right things though to update the score on the display so I am
; cheating a bit here.
scoreAddTwentyThousand entry
		_incrementScore 20000
		ldx #TILE_SCORE_TEN_THOUSANDS_OFFSET
		lda #2*4
		jmp scoreAddToTile
		
		
scoreEvery12000 entry
; TODO - Write code to add a new life.
		rtl
		
		
highScore	dc i4'0'

        end
