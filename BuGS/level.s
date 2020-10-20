;
;  level.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-10-12.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

		case on
        mcopy level.macros
        keep level

level start
		using globalData


levelInit entry
		stz centipedeLevelNum
		stz colourLevelNum
		rtl


levelStart entry
		lda colourLevelNum
		jsl setColour
		
		ldx centipedeLevelNum
		lda levelTable,x
		tax
		lda |$0,x
		sta centipedeNum
		inx
		inx
levelStart_loop anop
		jsl addCentipede
		dec centipedeNum
		beq levelStart_done
		txa
		clc
		adc #8
		tax
		bra levelStart_loop
levelStart_done anop
		rtl


levelNext entry
		lda colourLevelNum
		inc a
		cmp #NUM_COLOUR_PALETTES
		blt levelNext_skip
		lda #0
levelNext_skip anop
		sta colourLevelNum

		lda centipedeLevelNum
		cmp #LEVEL_TABLE_LAST_OFFSET
		bge levelNext_wrap
		inc a
		inc a
		bra levelNext_noWrap
levelNext_wrap anop
		lda #LEVEL_TABLE_REPEAT_OFFSET
levelNext_noWrap anop
		sta centipedeLevelNum
		rtl


centipedeLevelNum	dc i2'0'
colourLevelNum		dc i2'0'
centipedeNum 		dc i2'0'

; The level structure looks like this:
;    number of independent centipedes (2 bytes)
;    { (for each independent centipede)
;        segment speed (2 bytes)
;        segment direction (2 bytes)
;        tile offset where it appears (2 bytes)
;        number of body segments (2 bytes)
;    }
levelOne	dc i2'1'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'11'					; Number of body segments

levelTwo	dc i2'2'
			dc i2'SEGMENT_SPEED_SLOW'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'10'					; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments

levelThree	dc i2'2'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'10'					; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelFour	dc i2'3'
			dc i2'SEGMENT_SPEED_SLOW'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'9'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelFive	dc i2'3'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'9'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelSix	dc i2'4'
			dc i2'SEGMENT_SPEED_SLOW'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'8'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelSeven	dc i2'4'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'8'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelEight	dc i2'5'
			dc i2'SEGMENT_SPEED_SLOW'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'7'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelNine	dc i2'5'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'7'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelTen	dc i2'6'
			dc i2'SEGMENT_SPEED_SLOW'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'6'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelEleven	dc i2'6'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'6'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelTwelve	dc i2'7'
			dc i2'SEGMENT_SPEED_SLOW'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'5'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelThirteen	dc i2'7'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'5'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelFourteen	dc i2'8'
			dc i2'SEGMENT_SPEED_SLOW'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'4'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'2'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelFifteen	dc i2'8'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'4'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'2'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelSixteen	dc i2'9'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'3'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'2'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'42'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelSeventeen	dc i2'10'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'2'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'2'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'10'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'42'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelEighteen	dc i2'11'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'1'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'2'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'10'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'34'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'42'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelNineteen	dc i2'12'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'2'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'10'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'22'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'34'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'42'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelTwenty	dc i2'1'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'11'					; Number of body segments

levelTwentyOne	dc i2'2'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'10'					; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelTwentyTwo	dc i2'3'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'9'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelTwentyThree	dc i2'4'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'8'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments

levelTwentyFour	dc i2'5'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'7'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelTwentyFive	dc i2'6'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'6'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

levelTwentySix	dc i2'7'
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'26'					; Tile offset
			dc i2'5'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'6'						; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'14'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_LEFT'
			dc i2'18'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'30'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'38'					; Tile offset
			dc i2'0'						; Number of body segments
			dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_DIR_RIGHT'
			dc i2'46'					; Tile offset
			dc i2'0'						; Number of body segments

; Once we reach level 26 of the centipede levels, we go back to level 15.  This is because
; we only have fast speed centipedes, with one more head at the start and one less body
; segment until they are all head segments and then back to a single 12 segment centipede at
; fast speed.  By looping back from 26th level to the 15th level, we do this.
LEVEL_TABLE_LAST_OFFSET	gequ 25*2
LEVEL_TABLE_REPEAT_OFFSET	gequ 14*2
levelTable	dc i2'levelOne'
			dc i2'levelTwo'
			dc i2'levelThree'
			dc i2'levelFour'
			dc i2'levelFive'
			dc i2'levelSix'
			dc i2'levelSeven'
			dc i2'levelEight'
			dc i2'levelNine'
			dc i2'levelTen'
			dc i2'levelEleven'
			dc i2'levelTwelve'
			dc i2'levelThirteen'
			dc i2'levelFourteen'
			dc i2'levelFifteen'
			dc i2'levelSixteen'
			dc i2'levelSeventeen'
			dc i2'levelEighteen'
			dc i2'levelNineteen'
			dc i2'levelTwenty'
			dc i2'levelTwentyOne'
			dc i2'levelTwentyTwo'
			dc i2'levelTwentyThree'
			dc i2'levelTwentyFour'
			dc i2'levelTwentyFive'
			dc i2'levelTwentySix'

        end
