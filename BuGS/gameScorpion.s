;
;  gameScorpion.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-20.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy gameScorpion.macros
        keep gameScorpion

gameScorpion start
        using globalData
		using tileData


SCORPION_STATE_NONE      equ 0
SCORPION_STATE_LEFT      equ 1
SCORPION_STATE_RIGHT     equ 2
SCORPION_STATE_EXPLODING equ 3

SCORPION_SLOW_UPDATES_PER_TILE  equ TILE_PIXEL_WIDTH-1
SCORPION_FAST_UPDATES_PER_TILE  equ TILE_PIXEL_WIDTH/2-1

; A scorpion will only be generated in the top N rows.  This defines that number.
SCORPION_NUM_POSSIBLE_ROWS      equ 15


scorpionInitLevel entry
		stz scorpionState
		rtl


drawScorpion entry
        lda scorpionState
        bne drawScorpion_cont
        rtl
        
drawScorpion_cont anop
        ldy scorpionScreenOffset
        ldx scorpionSprite
        jsl scorpionJump
        
        _dirtyGameOrNonGameTile scorpionTileOffsets
        _dirtyGameOrNonGameTile scorpionTileOffsets+2
        _dirtyGameOrNonGameTile scorpionTileOffsets+4
        
        rtl
        
        
scorpionJump entry
        cmp #SCORPION_STATE_LEFT
        bne scorpionJump_next
        
        lda scorpionLeftJumpTable,x
        sta jumpInst+1
        
        lda scorpionLeftJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
scorpionJump_next anop
        cmp #SCORPION_STATE_RIGHT
        bne scorpionJump_explosion
        
        lda scorpionRightJumpTable,x
        sta jumpInst+1
        
        lda scorpionRightJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
scorpionJump_explosion anop
        lda explosionJumpTable,x
        sta jumpInst+1
        
        lda explosionJumpTable+2,x
        sta jumpInst+3
        
jumpInst jmp >leftScorpion1
        nop


updateScorpion entry
		lda playerState
		cmp #PLAYER_STATE_ONSCREEN
		beq updateScorpion_playerOnscreen
		rtl
updateScorpion_playerOnscreen anop
        lda scorpionState
        bne updateScorpion_cont
		ldx playerNum
		lda gameLevel,x
		cmp #3
		blt updateScorpion_doNotAdd
		jsl rand0_to_65534
		and #$3ff
; This used to just do an AND and add a scorpion when zero.  But because of the nature of the
; random number generator, if you get 0 once after the mask, chances are good you will get 0
; again on the next call to the random number generator.  Better to just look for some non-zero
; value.  I picked $20 which has a nice distribution when I checked the random number generator.
		cmp #$0020
		bne updateScorpion_doNotAdd
		jmp addScorpion
updateScorpion_doNotAdd anop
		rtl
        
updateScorpion_cont anop
        cmp #SCORPION_STATE_EXPLODING
        bne updateScorpion_notExploding
        jmp updateScorpion_exploding

updateScorpion_notExploding anop
; Common code for left or right moving scorpions
        lda scorpionSprite
        beq updateScorpion_resetSprite
        sec
        sbc scorpionSpriteUpdateDec
        sta scorpionSprite
        
        bra updateScorpion_nextAction
        
updateScorpion_resetSprite anop
        lda scorpionSpriteLastOffset
        sta scorpionSprite
        
updateScorpion_nextAction anop
        lda scorpionShiftInTile
        beq updateScorpion_nextTile
        dec a
        sta scorpionShiftInTile

updateScorpion_nextByteTest anop
        and #$1
		bne updateScorpion_isNextByte
		rtl
updateScorpion_isNextByte anop
        lda scorpionState
        cmp #SCORPION_STATE_LEFT
        beq updateScorpion_screenLeft
        inc scorpionScreenOffset
        rtl
        
updateScorpion_screenLeft anop
        dec scorpionScreenOffset
        rtl
        

updateScorpion_nextTile anop
        lda scorpionState
        cmp #SCORPION_STATE_LEFT
        beq updateScorpionLeft_nextTile

updateScorpionRight_nextTile anop
        inc scorpionScreenOffset
        lda scorpionUpdatesPerTile
        sta scorpionShiftInTile
        
        ldx scorpionTileOffsets+2
        cpx #RHS_FIRST_TILE_OFFSET
        blt updateScorpionRight_notOffScreen
        cpx #LHS_FIRST_TILE_OFFSET
        bge updateScorpionRight_notOffScreen
        bra updateScorpion_offScreen

updateScorpionLeft_nextTile anop
        dec scorpionScreenOffset
        lda scorpionUpdatesPerTile
        sta scorpionShiftInTile
        
        ldx scorpionTileOffsets+2
        cpx #LHS_FIRST_TILE_OFFSET
        bge updateScorpion_offScreen
        
        stx scorpionTileOffsets+4
        ldx scorpionTileOffsets
        stx scorpionTileOffsets+2
        lda tileLeft,x
        sta scorpionTileOffsets
		jsl updateScorpionSound
		ldx scorpionTileOffsets+2
        bra updateScorpion_maybePoison
        
updateScorpionRight_notOffScreen anop
        stx scorpionTileOffsets+4
        ldx scorpionTileOffsets
        stx scorpionTileOffsets+2
        lda tileRight,x
        sta scorpionTileOffsets
		jsl updateScorpionSound
		ldx scorpionTileOffsets+2
        
updateScorpion_maybePoison anop
        lda tileType,x
        beq updateScorpion_done
        cmp #TILE_MUSHROOM4+1
        bge updateScorpion_done

        ora #TILE_POISON_A_MUSHROOM
        sta tileType,x
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
updateScorpion_done anop
        rtl
        
updateScorpion_offScreen anop
        stz scorpionState
		jsl stopScorpionSound
        rtl

updateScorpion_exploding anop
        lda scorpionSprite
        beq updateScorpion_explosionDone
        sec
        sbc #$4
        sta scorpionSprite
        rtl
        
updateScorpion_explosionDone anop
        stz scorpionState
        rtl
        
        
setScorpionSpeed entry
        cmp #SPRITE_SPEED_FAST
        beq setScorpionSpeed_fast
        
        lda #SCORPION_SLOW_SPRITE_LAST_OFFSET
        sta scorpionSpriteLastOffset
        
        lda #SCORPION_SLOW_SPRITE_UPDATE_DEC
        sta scorpionSpriteUpdateDec
        
        lda #SCORPION_SLOW_UPDATES_PER_TILE
        sta scorpionUpdatesPerTile
 
; This is funky.  This sets the instruction at this location to be an immediate and
; instruction.  That causes us to only move to the next byte every other frame.
        short i,m
        lda #$29
        sta updateScorpion_nextByteTest
        long i,m
        
        rtl
        
setScorpionSpeed_fast anop
        lda #SCORPION_FAST_SPRITE_LAST_OFFSET
        sta scorpionSpriteLastOffset
        
        lda #SCORPION_FAST_SPRITE_UPDATE_DEC
        sta scorpionSpriteUpdateDec

        lda #SCORPION_FAST_UPDATES_PER_TILE
        sta scorpionUpdatesPerTile

; This is funky.  This sets the instruction at this location to be an immediate or
; instruction.  That causes us to only move to the next byte on every frame.
       short i,m
       lda #$09
       sta updateScorpion_nextByteTest
       long i,m
       
       rtl
        
        
addScorpion entry
        lda scorpionState
        beq addScorpion_doit
        rtl
        
addScorpion_doit anop
		ldx playerNum
		lda scoreNum20000,x
		bne addScorpion_randomSpeed
addScorpion_slow anop
		lda #SPRITE_SPEED_SLOW
		bra addScorpion_setSpeed
addScorpion_randomSpeed anop
		jsl rand0_to_65534
; We test the higher bits because we have already decided to add this scorpion because the bottom
; bits are all zero.  Because we shift bits in our "random" code, the bottom bits are guaranteed
; to still be zero.  So, look at a pair of upper bits to test for 1/4 of the time slow, 3/4 of the
; time fast.  Similarly for the L/R decision later on.
		and #$0c00
		beq addScorpion_slow
		lda #SPRITE_SPEED_FAST
addScorpion_setSpeed anop
		jsl setScorpionSpeed
		
        jsl rand0_to_14
        asl a
        tay
        
        jsl rand0_to_65534
        and #$1000
        beq addScorpion_right
        
        lda #SCORPION_STATE_LEFT
        sta scorpionState
        
        ldx scorpionLeftTileOffset,y
        stx scorpionTileOffsets
        
        lda tileScreenOffset,x
        dec a
        sta scorpionScreenOffset
        
        lda tileRight,x
        sta scorpionTileOffsets+2
        
        tax
        lda tileRight,x
        sta scorpionTileOffsets+4
        
        bra addScorpion_common
        
addScorpion_right anop
        
        lda #SCORPION_STATE_RIGHT
        sta scorpionState
        
        ldx scorpionRightTileOffset,y
        stx scorpionTileOffsets
        
        lda tileLeft,x
        sta scorpionTileOffsets+2
        
        tax
        lda tileLeft,x
        sta scorpionTileOffsets+4
        
        tax
        lda tileScreenOffset,x
        dec a
        dec a
        sta scorpionScreenOffset

addScorpion_common anop
        lda scorpionUpdatesPerTile
        sta scorpionShiftInTile
        
        lda scorpionSpriteLastOffset
        sta scorpionSprite
		
		ldx scorpionTileOffsets
		jsl startScorpionSound
        
addScorpion_done anop
        rtl
        

; See isSpiderCollision for the requirements of this routine and
; for info about its limitation
isScorpionCollision entry
		ldx scorpionState
		beq isScorpionCollision_returnFalse
		cpx #SCORPION_STATE_EXPLODING
		bne isScorpionCollision_test
isScorpionCollision_returnFalse anop
		clc
		rtl
		
isScorpionCollision_test anop
		cmp scorpionTileOffsets
		beq isScorpionCollision_returnTrue
		cmp scorpionTileOffsets+2
		beq isScorpionCollision_returnTrue
		cmp scorpionTileOffsets+4
		bne isScorpionCollision_returnFalse
isScorpionCollision_returnTrue anop
		sec
		rtl
		

shootScorpion entry
        lda scorpionState
        beq shootScorpion_done
        cmp #SCORPION_STATE_EXPLODING
        beq shootScorpion_done
        
        lda #SCORPION_STATE_EXPLODING
        sta scorpionState
        
        lda #EXPLOSION_LAST_OFFSET
        sta scorpionSprite
        
        lda scorpionScreenOffset
        inc a
        inc a
        sta scorpionScreenOffset
		ldx scorpionTileOffsets+2
		jsl stopScorpionSound
		jsl playKillSound
		jmp scoreAddOneThousand
        
shootScorpion_done anop
        rtl


scorpionState        dc i2'SCORPION_STATE_NONE'
scorpionScreenOffset dc i2'0'
scorpionTileOffsets  dc i2'0'
                     dc i2'0'
                     dc i2'0'
scorpionShiftInTile  dc i2'0'
scorpionSprite       dc i2'0'

scorpionSpriteLastOffset    dc i2'SCORPION_SLOW_SPRITE_LAST_OFFSET'
scorpionSpriteUpdateDec     dc i2'SCORPION_SLOW_SPRITE_UPDATE_DEC'
scorpionUpdatesPerTile      dc i2'SCORPION_SLOW_UPDATES_PER_TILE'


SCORPION_SLOW_SPRITE_LAST_OFFSET gequ 15*4
SCORPION_FAST_SPRITE_LAST_OFFSET gequ 14*4
SCORPION_SLOW_SPRITE_UPDATE_DEC  gequ 4
SCORPION_FAST_SPRITE_UPDATE_DEC  gequ 8

scorpionLeftJumpTable dc i4'leftScorpion4'
                      dc i4'leftScorpion4s'
                      dc i4'leftScorpion4'
                      dc i4'leftScorpion4s'
                      dc i4'leftScorpion3'
                      dc i4'leftScorpion3s'
                      dc i4'leftScorpion3'
                      dc i4'leftScorpion3s'
                      dc i4'leftScorpion2'
                      dc i4'leftScorpion2s'
                      dc i4'leftScorpion2'
                      dc i4'leftScorpion2s'
                      dc i4'leftScorpion1'
                      dc i4'leftScorpion1s'
                      dc i4'leftScorpion1'
                      dc i4'leftScorpion1s'
                      

scorpionRightJumpTable dc i4'rightScorpion4'
                       dc i4'rightScorpion4s'
                       dc i4'rightScorpion4'
                       dc i4'rightScorpion4s'
                       dc i4'rightScorpion3'
                       dc i4'rightScorpion3s'
                       dc i4'rightScorpion3'
                       dc i4'rightScorpion3s'
                       dc i4'rightScorpion2'
                       dc i4'rightScorpion2s'
                       dc i4'rightScorpion2'
                       dc i4'rightScorpion2s'
                       dc i4'rightScorpion1'
                       dc i4'rightScorpion1s'
                       dc i4'rightScorpion1'
                       dc i4'rightScorpion1s'
                       
                       
scorpionLeftTileOffset  dc i2'((0*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((1*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((2*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((3*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((4*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((5*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((6*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((7*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((8*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((9*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((10*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((11*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((12*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((13*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        dc i2'((14*GAME_NUM_TILES_WIDE)+GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO'
                        
                        
scorpionRightTileOffset dc i2'0*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'1*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'2*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'3*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'4*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'5*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'6*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'7*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'8*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'9*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'10*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'11*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'12*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'13*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                        dc i2'14*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO'
                 

        end
