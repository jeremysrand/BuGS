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

drawScorpion entry
        lda scorpionState
        bne drawScorpion_cont
        rtl
        
drawScorpion_cont anop
        ldy scorpionScreenOffset
        ldx scorpionSprite
        jsl scorpionJump
        
        ldx scorpionTileOffsets
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawScorpion_skipTile1
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawScorpion_nonGame1
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        bra drawScorpion_skipTile1
        
drawScorpion_nonGame1 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles
        
drawScorpion_skipTile1 anop

        ldx scorpionTileOffsets+2
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawScorpion_skipTile2
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawScorpion_nonGame2
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        bra drawScorpion_skipTile2
        
drawScorpion_nonGame2 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles
        
drawScorpion_skipTile2 anop

        ldx scorpionTileOffsets+4
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawScorpion_done
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawScorpion_nonGame3
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        rtl
        
drawScorpion_nonGame3 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles
        
drawScorpion_done anop
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
        tya
        clc
        adc #TILE_BYTE_WIDTH
        tay
        
        lda explosionJumpTable,x
        sta jumpInst+1
        
        lda explosionJumpTable+2,x
        sta jumpInst+3
        
jumpInst jmp >leftScorpion1
        nop


updateScorpion entry
        lda scorpionState
        beq updateScorpion_done
        
        lda scorpionSprite
        beq updateScorpionLeft_resetSprite
        sec
        sbc #$4
        sta scorpionSprite
        
        bra updateScorpionLeft_nextAction
        
updateScorpionLeft_resetSprite anop
        lda #SCORPION_SPRITE_LAST_OFFSET
        sta scorpionSprite
        
updateScorpionLeft_nextAction anop
        lda scorpionShiftInTile
        beq updateScorpionLeft_nextTile
        dec a
        sta scorpionShiftInTile
        
        and #$1
        beq updateScorpion_done
        dec scorpionScreenOffset
        bra updateScorpion_done
        
updateScorpionLeft_nextTile anop
        dec scorpionScreenOffset
        lda #SCORPION_SLOW_UPDATES_PER_TILE
        sta scorpionShiftInTile
        
        ldx scorpionTileOffsets+2
        cpx #LHS_FIRST_TILE_OFFSET
        bge updateScorpion_offScreen
        
        stx scorpionTileOffsets+4
        ldx scorpionTileOffsets
        stx scorpionTileOffsets+2
        lda tiles+TILE_LEFT_OFFSET,x
        sta scorpionTileOffsets
        rtl
        
updateScorpion_offScreen anop
        stz scorpionState
        
updateScorpion_done anop
        rtl
        
        
addScorpion entry
        lda scorpionState
        bne addScorpion_done
        
        lda #SCORPION_STATE_LEFT
        sta scorpionState
        
        ldx #(24+25)*16
        stx scorpionTileOffsets
        lda tiles+TILE_SCREEN_OFFSET_OFFSET,x
        dec a
        sta scorpionScreenOffset
        
        lda tiles+TILE_RIGHT_OFFSET,x
        sta scorpionTileOffsets+2
        
        tax
        lda tiles+TILE_RIGHT_OFFSET,x
        sta scorpionTileOffsets+4
        
        lda #SCORPION_SLOW_UPDATES_PER_TILE
        sta scorpionShiftInTile
        
        lda #SCORPION_SPRITE_LAST_OFFSET
        sta scorpionSprite
        
addScorpion_done anop
        rtl
        

shootScorpion entry
        rtl


scorpionState        dc i2'SCORPION_STATE_NONE'
scorpionScreenOffset dc i2'0'
scorpionTileOffsets  dc i2'0'
                     dc i2'0'
                     dc i2'0'
scorpionShiftInTile  dc i2'0'
scorpionSprite       dc i2'0'


SCORPION_SPRITE_LAST_OFFSET gequ 15*4
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
                 

        end
