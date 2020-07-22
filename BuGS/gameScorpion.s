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


scorpionState_none      equ 0
scorpionState_left      equ 1
scorpionState_right     equ 2
scorpionState_exploding equ 3


drawScorpion entry
        lda scorpionState
        bne drawScorpion_cont
        rtl
        
drawScorpion_cont anop
        ldy scorpionScreenOffset
        ldx scorpionSprite
        jsl scorpionJump
        
        ldx scorpionTileOffsets
        lda tiles,x
        bne drawScorpion_skipTile1
        lda #$1
        sta tiles,x
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
        lda tiles,x
        bne drawScorpion_skipTile2
        lda #$1
        sta tiles,x
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
        lda tiles,x
        bne drawScorpion_done
        lda #$1
        sta tiles,x
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
        cmp #scorpionState_left
        bne scorpionJump_next
        
        lda scorpionLeftJumpTable,x
        sta jumpInst+1
        
        lda scorpionLeftJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
scorpionJump_next anop
        cmp #scorpionState_right
        bne scorpionJump_explosion
        
        lda scorpionRightJumpTable,x
        sta jumpInst+1
        
        lda scorpionRightJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
scorpionJump_explosion anop
        tya
        clc
        adc #$4
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
        cmp #$3c
        beq updateScorpionLeft_resetSprite
        clc
        adc #$4
        sta scorpionSprite
        
        bra updateScorpionLeft_nextAction
        
updateScorpionLeft_resetSprite anop
        stz scorpionSprite
        
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
        lda #$7
        sta scorpionShiftInTile
        
        ldx scorpionTileOffsets+2
        cpx #LHS_FIRST_TILE_OFFSET
        bge updateScorpion_offScreen
        
        stx scorpionTileOffsets+4
        ldx scorpionTileOffsets
        stx scorpionTileOffsets+2
        lda tiles+10,x
        sta scorpionTileOffsets
        rtl
        
updateScorpion_offScreen anop
        stz scorpionState
        
updateScorpion_done anop
        rtl
        
        
addScorpion entry
        lda scorpionState
        bne addScorpion_done
        
        lda #scorpionState_left
        sta scorpionState
        
        ldx #24*16
        stx scorpionTileOffsets
        lda tiles+2,x
        dec a
        sta scorpionScreenOffset
        
        lda tiles+12,x
        sta scorpionTileOffsets+2
        
        tax
        lda tiles+12,x
        sta scorpionTileOffsets+4
        
        lda #$7
        sta scorpionShiftInTile
        
addScorpion_done anop
        rtl
        

shootScorpion entry
        rtl


scorpionState        dc i2'scorpionState_none'
scorpionScreenOffset dc i2'0'
scorpionTileOffsets  dc i2'0'
                     dc i2'0'
                     dc i2'0'
scorpionShiftInTile  dc i2'0'
scorpionSprite       dc i2'0'

scorpionLeftJumpTable dc i4'leftScorpion1s'
                      dc i4'leftScorpion1'
                      dc i4'leftScorpion1s'
                      dc i4'leftScorpion1'
                      dc i4'leftScorpion2s'
                      dc i4'leftScorpion2'
                      dc i4'leftScorpion2s'
                      dc i4'leftScorpion2'
                      dc i4'leftScorpion3s'
                      dc i4'leftScorpion3'
                      dc i4'leftScorpion3s'
                      dc i4'leftScorpion3'
                      dc i4'leftScorpion4s'
                      dc i4'leftScorpion4'
                      dc i4'leftScorpion4s'
                      dc i4'leftScorpion4'

scorpionRightJumpTable dc i4'rightScorpion1s'
                       dc i4'rightScorpion1'
                       dc i4'rightScorpion1s'
                       dc i4'rightScorpion1'
                       dc i4'rightScorpion2s'
                       dc i4'rightScorpion2'
                       dc i4'rightScorpion2s'
                       dc i4'rightScorpion2'
                       dc i4'rightScorpion3s'
                       dc i4'rightScorpion3'
                       dc i4'rightScorpion3s'
                       dc i4'rightScorpion3'
                       dc i4'rightScorpion4s'
                       dc i4'rightScorpion4'
                       dc i4'rightScorpion4s'
                       dc i4'rightScorpion4'
                 

        end
