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

FLEA_STATE_NONE         equ 0
FLEA_STATE_FALLING      equ 1
FLEA_STATE_EXPLODING    equ 2

FLEA_SCREEN_SPEED       equ 2*SCREEN_BYTES_PER_ROW
FLEA_SLOW_UPDATES_PER_TILE  equ 3
FLEA_FAST_UPDATES_PER_TILE  equ 1


drawFlea entry
        lda fleaState
        beq drawFlea_done
        
        ldy fleaScreenOffset
        ldx fleaSprite
        jsl fleaJump
        
        ldy numDirtyGameTiles
        
        ldx fleaTileOffsets
        lda tiles,x
        bne drawFlea_skipTile1
        lda #TILE_STATE_DIRTY
        sta tiles,x
        txa
        sta dirtyGameTiles,y
        iny
        iny
        
drawFlea_skipTile1 anop

        ldx fleaTileOffsets+2
        lda tiles,x
        bne drawFlea_skipTile2
        lda #TILE_STATE_DIRTY
        sta tiles,x
        txa
        sta dirtyGameTiles,y
        iny
        iny
        
drawFlea_skipTile2 anop

        ldx fleaTileOffsets+4
        lda tiles,x
        bne drawFlea_skipTile3
        lda #TILE_STATE_DIRTY
        sta tiles,x
        txa
        sta dirtyGameTiles,y
        iny
        iny
        
drawFlea_skipTile3 anop

        ldx fleaTileOffsets+6
        lda tiles,x
        bne drawFlea_skipTile4
        lda #TILE_STATE_DIRTY
        sta tiles,x
        txa
        sta dirtyGameTiles,y
        iny
        iny
        
drawFlea_skipTile4 anop
        sty numDirtyGameTiles
        
drawFlea_done anop
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
        bne updateFlea_cont

updateFlea_cont anop
        cmp #FLEA_STATE_FALLING
        beq updateFlea_cont2

; Handle explosion
        lda fleaSprite
        beq updateFlea_explosionDone
        sbc #$4
        sta fleaSprite
        rtl
        
updateFlea_explosionDone anop
        stz fleaState
        rtl
        
updateFlea_cont2 anop
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
        lda tiles+8,x
        cmp #INVALID_TILE_NUM
        beq updateFlea_bottom
        sta fleaTileOffsets
        
        ldx fleaTileOffsets+2
        stx fleaTileOffsets+6
        lda tiles+8,x
        sta fleaTileOffsets+2
        
        ldx fleaTileOffsets+4
        lda tiles+4,x
        bne updateFlea_nextAction
        
        jsl rand65535
        and #$7
        bne updateFlea_nextAction
        lda #TILE_MUSHROOM4
        sta tiles+4,x
        
        bra updateFlea_nextAction
        
updateFlea_bottom anop
        stz fleaState
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
        
        lda #FLEA_STATE_FALLING
        sta fleaState
        
        lda #FLEA_SLOW_UPDATES_PER_TILE
        sta fleaUpdatePerTile
        sta fleaHeightInTile
        
        lda #FLEA_SCREEN_SPEED
        sta fleaSpeed
        
        stz fleaSpriteCounter
        lda #FLEA_SPRITE_LAST_OFFSET
        sta fleaSprite
        
        jsl rand25
        asl a
        asl a
        asl a
        asl a
        sta fleaTileOffsets
        sta fleaTileOffsets+4
        
        tax
        lda tiles+10,x
        sta fleaTileOffsets+2
        sta fleaTileOffsets+6
        
        lda tiles+2,x
        sec
        sbc #6*SCREEN_BYTES_PER_ROW+3
        sta fleaScreenOffset
        
addFlea_done anop
        rtl
        
shootFlea entry
        lda fleaState
        cmp #FLEA_STATE_FALLING
        bne shootFlea_done
        
        lda fleaSpeed
        cmp #FLEA_SCREEN_SPEED
        beq shootFlea_faster
        
        lda #FLEA_STATE_EXPLODING
        sta fleaState
        
        lda #EXPLOSION_LAST_OFFSET
        sta fleaSprite

        rtl
        
shootFlea_faster anop
        asl a
        sta fleaSpeed
        
        lda #FLEA_FAST_UPDATES_PER_TILE
        sta fleaUpdatePerTile
        
        lda fleaHeightInTile
        lsr a
        sta fleaHeightInTile
        bcc shootFlea_done
        
        lda fleaScreenOffset
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
                 
fleaSpeed        dc i2'0'
fleaUpdatePerTile dc i2'0'

        end
