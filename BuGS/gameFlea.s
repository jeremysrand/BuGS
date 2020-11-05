;
;  gameFlea.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-18.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy gameFlea.macros
        keep gameFlea

gameFlea start
        using globalData
		using tileData

FLEA_STATE_NONE         equ 0
FLEA_STATE_FALLING      equ 1
FLEA_STATE_EXPLODING    equ 2

FLEA_SCREEN_SPEED_SLOW      equ 2*SCREEN_BYTES_PER_ROW
FLEA_SCREEN_SPEED_FAST      equ 4*SCREEN_BYTES_PER_ROW
FLEA_SLOW_UPDATES_PER_TILE  equ TILE_PIXEL_HEIGHT/2-1
FLEA_FAST_UPDATES_PER_TILE  equ TILE_PIXEL_HEIGHT/4-1


drawFlea entry
        lda fleaState
        bne drawFlea_cont
        rtl

drawFlea_cont anop
        ldy fleaScreenOffset
        ldx fleaSprite
        jsl fleaJump
        
        _dirtyGameOrNonGameTile fleaTileOffsets
        _dirtyGameOrNonGameTile fleaTileOffsets+2
        _dirtyGameOrNonGameTile fleaTileOffsets+4
        _dirtyGameOrNonGameTile fleaTileOffsets+6
        
        rtl
        
        
fleaJump entry
        cmp #FLEA_STATE_FALLING
        bne fleaJump_explosion
        
        lda fleaJumpTable,x
        sta jumpInst+1
        
        lda fleaJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
fleaJump_explosion anop
        lda explosionJumpTable,x
        sta jumpInst+1
        
        lda explosionJumpTable+2,x
        sta jumpInst+3
jumpInst jmp >flea1
        nop
        
        
updateFlea entry
        lda fleaState
        beq updateFlea_maybeAdd
		
        cmp #FLEA_STATE_FALLING
        beq updateFlea_cont

; Handle explosion
        lda fleaSprite
        beq updateFlea_explosionDone
        sec
        sbc #$4
        sta fleaSprite
        rtl
        
updateFlea_explosionDone anop
        stz fleaState
        rtl

updateFlea_maybeAdd anop
		lda gameRunning
		bne updateFlea_doNotAdd
		lda gameLevel
		beq updateFlea_doNotAdd
		lda scoreNum20000
		bne updateFlea_moreThan20000
; Below 20000 points, 5 or more mushrooms do not result in a flea
		lda #4
		bra updateFlea_checkNumMushrooms
updateFlea_moreThan20000 anop
		cmp #6
		bge updateFlea_moreThan120000
; Between 20000 and 120000, 9 or more mushrooms do not result in a flea
		lda #8
		bra updateFlea_checkNumMushrooms
updateFlea_moreThan120000 anop
; Above 120000, 15 or more mushrooms do not result in a flea and for every
; 20000 more points, this goes up by 1 more mushroom.  So, the accumulator
; has 6 in it for scores from 120000 to 139999.  Add 8 to that to get 14
; which is the threshold at which fleas appear.
		clc
		adc #8
updateFlea_checkNumMushrooms anop
		cmp numInfieldMushrooms
		blt updateFlea_doNotAdd
		jmp addFlea
		
updateFlea_doNotAdd anop
		rtl
        
updateFlea_cont anop
        lda fleaHeightInTile
        beq updateFlea_nextTile
        dec a
        sta fleaHeightInTile
        beq updateFlea_bottomOfTile
        bra updateFlea_nextAction
        
updateFlea_bottomOfTile anop
        lda fleaSpriteCounter
        eor #$1
        sta fleaSpriteCounter
        bne updateFlea_nextAction
        
        lda fleaSprite
        beq updateFlea_resetSprite
        sec
        sbc #$4
        sta fleaSprite
        bra updateFlea_nextAction
        
updateFlea_resetSprite anop
        lda #FLEA_SPRITE_LAST_OFFSET
        sta fleaSprite
        bra updateFlea_nextAction
        
updateFlea_nextTile anop
        lda fleaUpdatePerTile
        sta fleaHeightInTile
        
        ldx fleaTileOffsets
        stx fleaTileOffsets+4
        lda tileBelow,x
        cmp #INVALID_TILE_NUM
        beq updateFlea_bottom
        sta fleaTileOffsets
        
        ldx fleaTileOffsets+2
        stx fleaTileOffsets+6
        lda tileBelow,x
        sta fleaTileOffsets+2
        
        ldx fleaTileOffsets+4
        lda tileType,x
        bne updateFlea_nextAction
        
        jsl rand0_to_65534
        and #$3
        bne updateFlea_nextAction
        lda #TILE_MUSHROOM4
        sta tileType,x
		cpx #SPIDER_STARTING_TOP_ROW_OFFSET
		blt updateFlea_nextAction
        inc numInfieldMushrooms
        bra updateFlea_nextAction
        
updateFlea_bottom anop
        stz fleaState
; Uncomment the next line to continuously display fleas.
;        jsl addFlea
        rtl

updateFlea_nextAction anop
        lda fleaScreenOffset
        clc
        adc fleaSpeed
        sta fleaScreenOffset
        
updateFlea_done anop
        rtl
        

addFlea entry
        lda fleaState
        bne addFlea_done
		
		lda scoreNum20000
		cmp #3
		bge addFlea_fast
		lda #SPRITE_SPEED_SLOW
		bra addFlea_setSpeed
addFlea_fast anop
		lda #SPRITE_SPEED_FAST
addFlea_setSpeed anop
        jsl setFleaSpeed
        
        lda #FLEA_STATE_FALLING
        sta fleaState
        
        lda fleaUpdatePerTile
        sta fleaHeightInTile
        
        stz fleaSpriteCounter
        lda #FLEA_SPRITE_LAST_OFFSET
        sta fleaSprite
        
        jsl rand25
        asl a
        sta fleaTileOffsets
        sta fleaTileOffsets+4
        
        tax
        lda tileLeft,x
        sta fleaTileOffsets+2
        sta fleaTileOffsets+6
        
        lda tileScreenOffset,x
        sec
        sbc #6*SCREEN_BYTES_PER_ROW+3
        sta fleaScreenOffset
        
addFlea_done anop
        rtl
        

setFleaSpeed entry
        sta fleaSpriteSpeed
        cmp #SPRITE_SPEED_FAST
        beq setFleaSpeed_fast
        
        lda #FLEA_SCREEN_SPEED_SLOW
        sta fleaSpeed
        lda #FLEA_SLOW_UPDATES_PER_TILE
        sta fleaUpdatePerTile
        rtl
        
setFleaSpeed_fast anop
        lda #FLEA_SCREEN_SPEED_FAST
        sta fleaSpeed
        lda #FLEA_FAST_UPDATES_PER_TILE
        sta fleaUpdatePerTile
        rtl

        
shootFlea entry
        lda fleaState
        cmp #FLEA_STATE_FALLING
        bne shootFlea_done
        
        lda fleaSpeed
        cmp #FLEA_SCREEN_SPEED_SLOW
        beq shootFlea_faster
        
        lda #FLEA_STATE_EXPLODING
        sta fleaState
        
        lda #EXPLOSION_LAST_OFFSET
        sta fleaSprite

		jmp scoreAddTwoHundred
        
shootFlea_faster anop
        jsl setFleaSpeed_fast
        
        lda fleaHeightInTile
        lsr a
        sta fleaHeightInTile
        bcc shootFlea_done
        
        lda fleaScreenOffset
        sec
        sbc #SCREEN_BYTES_PER_ROW
        sta fleaScreenOffset
        
shootFlea_done anop
        rtl
        
        
fleaState        dc i2'FLEA_STATE_NONE'
fleaScreenOffset dc i2'0'
fleaTileOffsets  dc i2'0'
                 dc i2'0'
                 dc i2'0'
                 dc i2'0'
fleaHeightInTile dc i2'0'
fleaSpriteCounter dc i2'0'
fleaSprite       dc i2'0'

FLEA_SPRITE_LAST_OFFSET gequ 3*4
fleaJumpTable    dc i4'flea4'
                 dc i4'flea3'
                 dc i4'flea2'
                 dc i4'flea1'
                 
fleaSpriteSpeed     dc i2'SPRITE_SPEED_SLOW'
fleaSpeed           dc i2'FLEA_SCREEN_SPEED_SLOW'
fleaUpdatePerTile   dc i2'FLEA_SLOW_UPDATES_PER_TILE'

        end
