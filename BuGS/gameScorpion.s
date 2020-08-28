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


SCORPION_STATE_NONE      equ 0
SCORPION_STATE_LEFT      equ 1
SCORPION_STATE_RIGHT     equ 2
SCORPION_STATE_EXPLODING equ 3

SCORPION_SLOW_UPDATES_PER_TILE  equ TILE_PIXEL_WIDTH-1
SCORPION_FAST_UPDATES_PER_TILE  equ TILE_PIXEL_WIDTH/2-1

; A scorpion will only be generated in the top N rows.  This defines that number.
SCORPION_NUM_POSSIBLE_ROWS      equ 15


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
        lda scorpionState
        bne updateScorpion_cont
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
        beq updateScorpion_done
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
        lda tiles+TILE_LEFT_OFFSET,x
        sta scorpionTileOffsets
        bra updateScorpion_maybePoison
        
updateScorpionRight_notOffScreen anop
        stx scorpionTileOffsets+4
        ldx scorpionTileOffsets
        stx scorpionTileOffsets+2
        lda tiles+TILE_RIGHT_OFFSET,x
        sta scorpionTileOffsets
        
updateScorpion_maybePoison anop
        lda tiles+TILE_TYPE_OFFSET,x
        beq updateScorpion_done
        cmp #TILE_MUSHROOM4+1
        bge updateScorpion_done

        ora #TILE_POISON_A_MUSHROOM
        sta tiles+TILE_TYPE_OFFSET,x
updateScorpion_done anop
        rtl
        
updateScorpion_offScreen anop
        stz scorpionState
; Uncomment the following line to continuously add scorpions
;        jsl addScorpion
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
; TODO - Call this code with each level to set the scorpion speed
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
        jsl rand0_to_14
        asl a
        tay
        
        jsl rand0_to_65534
        and #1
        beq addScorpion_right
        
        lda #SCORPION_STATE_LEFT
        sta scorpionState
        
        ldx scorpionLeftTileOffset,y
        stx scorpionTileOffsets
        
        lda tiles+TILE_SCREEN_OFFSET_OFFSET,x
        dec a
        sta scorpionScreenOffset
        
        lda tiles+TILE_RIGHT_OFFSET,x
        sta scorpionTileOffsets+2
        
        tax
        lda tiles+TILE_RIGHT_OFFSET,x
        sta scorpionTileOffsets+4
        
        bra addScorpion_common
        
addScorpion_right anop
        
        lda #SCORPION_STATE_RIGHT
        sta scorpionState
        
        ldx scorpionRightTileOffset,y
        stx scorpionTileOffsets
        
        lda tiles+TILE_LEFT_OFFSET,x
        sta scorpionTileOffsets+2
        
        tax
        lda tiles+TILE_LEFT_OFFSET,x
        sta scorpionTileOffsets+4
        
        tax
        lda tiles+TILE_SCREEN_OFFSET_OFFSET,x
        dec a
        dec a
        sta scorpionScreenOffset

addScorpion_common anop
        lda scorpionUpdatesPerTile
        sta scorpionShiftInTile
        
        lda scorpionSpriteLastOffset
        sta scorpionSprite
        
addScorpion_done anop
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
; TODO - Increment the score
        
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
