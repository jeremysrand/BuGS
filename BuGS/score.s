;
;  score.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-10-12.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;


		case on
		datachk off
        mcopy score.macros
        keep score

score start
		using globalData
		using tileData
		

scoreStartGame entry
		stz gameScore
		stz gameScore+2
		stz gameScore+4
		stz gameScore+6
		stz scoreWithin12000
		stz scoreWithin12000+2
		stz scoreWithin20000
		stz scoreWithin20000+2
		stz scoreNum20000
		stz scoreNum20000+2
		
		ldx #P1_SCORE_ONES_OFFSET
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
		dex
		dex
		
scoreStartGame_loop1 anop
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile
		dex
		dex
		cpx #P1_SCORE_FIRST_OFFSET
		bge scoreStartGame_loop1
		
		ldx #P2_SCORE_ONES_OFFSET
		lda isSinglePlayer
		beq scoreStartGame_loop2
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
		dex
		dex
scoreStartGame_loop2 anop
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile
		dex
		dex
		cpx #P2_SCORE_FIRST_OFFSET
		bge scoreStartGame_loop2
		rtl

		
scoreSwitchPlayer entry
		lda playerNum
		cmp #PLAYER_ONE
		beq scoreSwitchPlayer_isPlayer1
		lda #P2_SCORE_ONES_OFFSET
		sta scoreOnesOffset
		lda #P2_SCORE_TENS_OFFSET
		sta scoreTensOffset
		lda #P2_SCORE_HUNDREDS_OFFSET
		sta scoreHundredsOffset
		lda #P2_SCORE_THOUSANDS_OFFSET
		sta scoreThousandsOffset
		bra scoreSwitchPlayer_done
scoreSwitchPlayer_isPlayer1 anop
		lda #P1_SCORE_ONES_OFFSET
		sta scoreOnesOffset
		lda #P1_SCORE_TENS_OFFSET
		sta scoreTensOffset
		lda #P1_SCORE_HUNDREDS_OFFSET
		sta scoreHundredsOffset
		lda #P1_SCORE_THOUSANDS_OFFSET
		sta scoreThousandsOffset
scoreSwitchPlayer_done anop
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
		ldx scoreOnesOffset
		jmp scoreAddOneToTile


scoreAddFive entry
		_incrementScore 5
		ldx scoreOnesOffset
		lda #5*4
		jmp scoreAddToTile


scoreAddTen entry
		_incrementScore 10
		ldx scoreOnesOffset
		lda tileType,x
		bne scoreAddTen_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddTen_skipZeroOnes anop
		ldx scoreTensOffset
		jmp scoreAddOneToTile


scoreAddOneHundred entry
		_incrementScore 100
		ldx scoreOnesOffset
		lda tileType,x
		bne scoreAddHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddHundred_skipZeroOnes anop
		ldx scoreTensOffset
		lda tileType,x
		bne scoreAddHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddHundred_skipZeroTens anop
		ldx scoreHundredsOffset
		jmp scoreAddOneToTile


scoreAddTwoHundred entry
		_incrementScore 200
		ldx scoreOnesOffset
		lda tileType,x
		bne scoreAddTwoHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddTwoHundred_skipZeroOnes anop
		ldx scoreTensOffset
		lda tileType,x
		bne scoreAddTwoHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddTwoHundred_skipZeroTens anop
		ldx scoreHundredsOffset
		lda #2*4
		jmp scoreAddToTile


scoreAddThreeHundred entry
		_incrementScore 300
		ldx scoreOnesOffset
		lda tileType,x
		bne scoreAddThreeHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddThreeHundred_skipZeroOnes anop
		ldx scoreTensOffset
		lda tileType,x
		bne scoreAddThreeHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddThreeHundred_skipZeroTens anop
		ldx scoreHundredsOffset
		lda #3*4
		jmp scoreAddToTile


scoreAddSixHundred entry
		_incrementScore 600
		ldx scoreOnesOffset
		lda tileType,x
		bne scoreAddSixHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddSixHundred_skipZeroOnes anop
		ldx scoreTensOffset
		lda tileType,x
		bne scoreAddSixHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddSixHundred_skipZeroTens anop
		ldx scoreHundredsOffset
		lda #6*4
		jmp scoreAddToTile


scoreAddNineHundred entry
		_incrementScore 900
		ldx scoreOnesOffset
		lda tileType,x
		bne scoreAddNineHundred_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddNineHundred_skipZeroOnes anop
		ldx scoreTensOffset
		lda tileType,x
		bne scoreAddNineHundred_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddNineHundred_skipZeroTens anop
		ldx scoreHundredsOffset
		lda #9*4
		jmp scoreAddToTile


scoreAddOneThousand entry
		_incrementScore 1000
		ldx scoreOnesOffset
		lda tileType,x
		bne scoreAddOneThousand_skipZeroOnes
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddOneThousand_skipZeroOnes anop
		ldx scoreTensOffset
		lda tileType,x
		bne scoreAddOneThousand_skipZeroTens
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddOneThousand_skipZeroTens anop
		ldx scoreHundredsOffset
		lda tileType,x
		bne scoreAddOneThousand_skipZeroHundreds
		lda #TILE_NUMBER_0
		sta tileType,x
		_dirtyNonGameTile
scoreAddOneThousand_skipZeroHundreds anop
		ldx scoreThousandsOffset
		jmp scoreAddOneToTile
		

		

		
        end


scoreExtras start extraSeg
		using globalData
		using tileData
		using playerData
	

updateHighScore entry
		ldx #HIGH_SCORE_ONES_OFFSET
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+9
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+8
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+7
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+6
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+5
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+4
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+3
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+2
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+1
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		
		dex
		dex
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET
		jsl asciiToTileType
		sta tileType,x
		_dirtyNonGameTile
		rtl
		
		
checkHighScore entry
		ldy #0
checkHighScore_loop anop
		lda playerNum
		asl a
		tax
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_OFFSET+2,y
		cmp gameScore+2,x
		blt checkHighScore_isHighScore
		bne checkHighScore_next
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_OFFSET,y
		cmp gameScore,x
		blt checkHighScore_isHighScore
checkHighScore_next anop
		tya
		clc
		adc #SETTINGS_HIGH_SCORE_SIZE
		tay
		cpy #SETTINGS_HIGH_SCORE_SIZE*10
		blt checkHighScore_loop
		clc
		rtl
checkHighScore_isHighScore anop
		sty scoreIndex
		ldx #SETTINGS_HIGH_SCORE_SIZE*10-2
		ldy #SETTINGS_HIGH_SCORE_SIZE*9-2
		cpy scoreIndex
		blt checkHighScore_doneCopy
checkHighScore_copyLoop anop
		lda settings+SETTINGS_HIGH_SCORE_OFFSET,y
		sta settings+SETTINGS_HIGH_SCORE_OFFSET,x
		cpy scoreIndex
		beq checkHighScore_doneCopy
		dey
		dey
		dex
		dex
		bra checkHighScore_copyLoop
checkHighScore_doneCopy anop
		ldy scoreIndex
		lda playerNum
		asl a
		tax
		lda gameScore,x
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_OFFSET,y
		sta setHighScoreRequest+6
		lda gameScore+2,x
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_OFFSET+2,y
		sta setHighScoreRequest+8

		lda playerNum
		cmp #PLAYER_ONE
		beq checkHighScore_isPlayer1
		ldx #P2_SCORE_ONES_OFFSET-18
		bra checkHighScore_saveHighScore
checkHighScore_isPlayer1 anop
		ldx #P1_SCORE_ONES_OFFSET-18
checkHighScore_saveHighScore anop
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+1,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+2,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+3,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+4,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+5,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+6,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+7,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+8,y

		inx
		inx
		lda tileType,x
		jsl tileTypeToAscii
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_SCORE_TEXT_OFFSET+9,y

		ldx #GAME_NUM_TILES_WIDE*4+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*6+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_G
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_M
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_V
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*8+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_P
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		lda playerNum
		beq checkHighScore_printPlayer1
		_overwriteGameTile TILE_NUMBER_2
		bra checkHighScore_donePrintingPlayer
checkHighScore_printPlayer1 anop
		_overwriteGameTile TILE_NUMBER_1
checkHighScore_donePrintingPlayer anop
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*10+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*12+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_G
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_LETTER_C
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*14+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_N
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_I
		_overwriteGameTile TILE_LETTER_N
		_overwriteGameTile TILE_LETTER_I
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_LETTER_I
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*16+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*18+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_SOLID2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*20+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*18+20
checkHighScore_nextKey anop
		jsl waitForKey
		cmp #$08
		beq checkHighScore_backspace
		blt checkHighScore_isInvalid
		cmp #$7f
		beq checkHighScore_backspace
		cmp #$0d
		beq checkHighScore_isEnter
		blt checkHighScore_isInvalid
		cmp #'0'
		blt checkHighScore_isInvalid
		cmp #'9'+1
		blt checkHighScore_isValid
		cmp #'a'
		blt checkHighScore_skipToUpperCase
		sec
		sbc #$20
checkHighScore_skipToUpperCase anop
		cmp #'A'
		blt checkHighScore_isInvalid
		cmp #'Z'+1
		bge checkHighScore_isInvalid
		  
checkHighScore_isValid anop
		cpx #GAME_NUM_TILES_WIDE*18+26
		bge checkHighScore_isInvalid
		sta settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_WHO_OFFSET,y
		iny
		jsl asciiToTileType
		jsl overwriteGameTile
		_overwriteGameTile TILE_SOLID2
		dex
		dex
		bra checkHighScore_nextKey

checkHighScore_backspace anop
		cpx #GAME_NUM_TILES_WIDE*18+21
		blt checkHighScore_isInvalid
		dey
		_overwriteGameTile TILE_EMPTY
		dex
		dex
		dex
		dex
		_overwriteGameTile TILE_SOLID2
		dex
		dex
		bra checkHighScore_nextKey
		  
checkHighScore_isEnter anop
		cpx #GAME_NUM_TILES_WIDE*18+26
		blt checkHighScore_isInvalid
		bra checkHighScore_doneInitials
checkHighScore_isInvalid anop
		bra checkHighScore_nextKey
		  
checkHighScore_doneInitials anop
		_overwriteGameTile TILE_EMPTY
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_WHO_OFFSET-3,y
		sta setHighScoreRequest+2
		lda settings+SETTINGS_HIGH_SCORE_OFFSET+HIGH_SCORE_WHO_OFFSET-1,y
		sta setHighScoreRequest+4
		jsl saveSettings
		jsl canSendHighScore
		bne checkHighScore_retry
		brl checkHighScore_doneNetwork

checkHighScore_retry anop
		ldx #GAME_NUM_TILES_WIDE*22+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_P
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_D
		_overwriteGameTile TILE_LETTER_I
		_overwriteGameTile TILE_LETTER_N
		_overwriteGameTile TILE_LETTER_G
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_LETTER_C
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_SOLID1
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		jsl sendHighScore
		beq checkHighScore_retryPrompt
		brl checkHighScore_doneNetwork
		  
checkHighScore_retryPrompt anop
		ldx #GAME_NUM_TILES_WIDE*22+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_LETTER_C
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_P
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_D
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_F
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_I
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_D
		_overwriteGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*24+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_P
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_D
		_overwriteGameTile TILE_SYMBOL_COLON
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_SYMBOL_COLON
		_overwriteGameTile TILE_LETTER_N
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_SOLID2
		_overwriteGameTile TILE_EMPTY

		jsl waitForKey
		and #$df
		cmp #'N'
		beq checkHighScore_doneNetwork
		cmp #'Y'
		beq checkHighScore_doRetry
		brl checkHighScore_retryPrompt
		  
checkHighScore_doneNetwork anop
		jsl updateHighScore
		sec
		rtl
checkHighScore_doRetry anop
		ldx #GAME_NUM_TILES_WIDE*24+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		brl checkHighScore_retry
		  
		  
uploadSpin1 entry
		ldx #GAME_NUM_TILES_WIDE*22+36
		_overwriteGameTile TILE_SOLID1
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		rtl
		  
		  
uploadSpin2 entry
		ldx #GAME_NUM_TILES_WIDE*22+36
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_SOLID1
		_overwriteGameTile TILE_EMPTY
		rtl
		  
		  
uploadSpin3 entry
		ldx #GAME_NUM_TILES_WIDE*22+36
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_SOLID1
		rtl
		
		
displayScorePosition entry
		ldx #GAME_NUM_TILES_WIDE*22
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_LETTER_C
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_G
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_B
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_I
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_SYMBOL_COLON
		_overwriteGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*24
		ldy #0
displayScorePosition_loop anop
		lda globalScoreInfo,y
		and #$ff
		beq displayScorePosition_done
		jsl asciiToTileType
		jsl overwriteGameTile
		iny
		bra displayScorePosition_loop
		
displayScorePosition_done anop
		rtl
		  
		end
