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
		using tileData


levelInit entry
		stz gameLevel
		stz gameLevel+2
		stz nextGameLevel
		stz nextGameLevel+2
		stz centipedeLevelNum
		stz centipedeLevelNum+2
		stz colourLevelNum
		stz colourLevelNum+2
		lda #SEGMENT_SPEED_FAST
		sta levelSpeed
		sta levelSpeed+2
		rtl


levelStart entry
		ldx playerNum
		lda colourLevelNum,x
		jsl setColour
		jsl startSegmentSound
		
		ldy playerNum
		lda nextGameLevel,y
		sta gameLevel,y
		ldx centipedeLevelNum,y
		lda levelTable,x
		tax
		lda levelSpeed,y
		sta |$2,x
		lda |$0,x
		sta centipedeNum
; We add centipedes in reverse order which means we need to load X up with the address
; of the last centipede.  To do so, we:
;	- subtract one from the number of centipedes
;	- multiply by eight
;   - add the starting location of the level information
;   - add 2 to skip past the number of centipedes so we should now be
;     at the start of the last centipede
; We do this because it is important that the single head segments are the ones which
; need to "avoid" the other segments and that happens when they are added first.
; See the update code in gameSegments.s to see why.
		dec a
		asl a
		asl a
		asl a
		ldx centipedeLevelNum,y
		clc
		adc levelTable,x
		tax
		inx
		inx
levelStart_loop anop
		jsl addCentipede
		dec centipedeNum
		beq levelStart_done
		txa
		sec
		sbc #8
		tax
		bra levelStart_loop
levelStart_done anop
		rtl
		

levelNext entry
		ldx playerNum
		lda colourLevelNum,x
		inc a
		cmp #NUM_COLOUR_PALETTES
		blt levelNext_skip
		lda #0
levelNext_skip anop
		sta colourLevelNum,x
		ldx playerNum
		inc nextGameLevel,x
		
		lda scoreNum20000,x
		cmp #2
		bge levelNext_fastOnly
		
		ldx playerNum
		lda levelSpeed,x
		cmp #SEGMENT_SPEED_FAST
		beq levelNext_slowIncrement
		lda #SEGMENT_SPEED_FAST
		sta levelSpeed,x
		rtl

levelNext_slowIncrement anop
		lda #SEGMENT_SPEED_SLOW
		sta levelSpeed,x
		lda centipedeLevelNum,x
		cmp #LEVEL_TABLE_LAST_OFFSET
		bge levelNext_slowWrap
		inc a
		inc a
		bra levelNext_slowNoWrap
levelNext_slowWrap anop
		lda #0
levelNext_slowNoWrap anop
		sta centipedeLevelNum,x
		rtl

levelNext_fastOnly anop
		ldx playerNum
		lda #SEGMENT_SPEED_FAST
		sta levelSpeed,x
		lda centipedeLevelNum,x
		cmp #LEVEL_TABLE_LAST_OFFSET
		bge levelNext_fastWrap
		inc a
		inc a
		bra levelNext_fastNoWrap
levelNext_fastWrap anop
		lda #0
levelNext_fastNoWrap anop
		sta centipedeLevelNum,x
		rtl


centipedeNum 	dc i2'0'
levelSpeed	dc i2'SEGMENT_SPEED_FAST'
			dc i2'SEGMENT_SPEED_FAST'

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

levelThree	dc i2'3'
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

levelFour	dc i2'4'
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

levelFive	dc i2'5'
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

levelSix	dc i2'6'
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

levelSeven	dc i2'7'
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

levelEight	dc i2'8'
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

levelNine	dc i2'9'
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

levelTen	dc i2'10'
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

levelEleven	dc i2'11'
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

levelTwelve	dc i2'12'
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

; Once we reach level 26 of the centipede levels, we go back to level 15.  This is because
; we only have fast speed centipedes, with one more head at the start and one less body
; segment until they are all head segments and then back to a single 12 segment centipede at
; fast speed.  By looping back from 26th level to the 15th level, we do this.
LEVEL_TABLE_LAST_OFFSET	gequ 11*2
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

        end
