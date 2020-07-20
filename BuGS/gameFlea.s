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

fleaState_none equ 0
fleaState_falling equ 1
fleaState_exploding equ 2

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
        lda #$1
        sta tiles,x
        txa
        sta dirtyGameTiles,y
        iny
        iny
        
drawFlea_skipTile1 anop

        ldx fleaTileOffsets+2
        lda tiles,x
        bne drawFlea_skipTile2
        lda #$1
        sta tiles,x
        txa
        sta dirtyGameTiles,y
        iny
        iny
        
drawFlea_skipTile2 anop

        ldx fleaTileOffsets+4
        lda tiles,x
        bne drawFlea_skipTile3
        lda #$1
        sta tiles,x
        txa
        sta dirtyGameTiles,y
        iny
        iny
        
drawFlea_skipTile3 anop

        ldx fleaTileOffsets+6
        lda tiles,x
        bne drawFlea_skipTile4
        lda #$1
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
        cmp #fleaState_falling
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
        cmp #fleaState_falling
        beq updateFlea_cont2

; Handle explosion
        lda fleaSprite
        clc
        adc #$4
        sta fleaSprite
        cmp #$15
        bge updateFlea_explosionDone
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
        cmp #$c
        beq updateFlea_resetSprite
        clc
        adc #$4
        sta fleaSprite
        bra updateFlea_nextAction
        
updateFlea_resetSprite anop
        stz fleaSprite
        bra updateFlea_nextAction
        
updateFlea_nextTile anop
        lda fleaUpdatePerTile
        sta fleaHeightInTile
        
        ldx fleaTileOffsets
        stx fleaTileOffsets+4
        lda tiles+8,x
        cmp #$ffff
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
        lda #$10
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
        
        lda #fleaState_falling
        sta fleaState
        
        lda #$3
        sta fleaUpdatePerTile
        sta fleaHeightInTile
        
        lda #$140
        sta fleaSpeed
        
        stz fleaSpriteCounter
        stz fleaSprite
        
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
        sbc #$3c3
        sta fleaScreenOffset
        
addFlea_done anop
        rtl
        
shootFlea entry
        lda fleaState
        cmp #$1
        bne shootFlea_done
        
        lda fleaSpeed
        cmp #$140
        beq shootFlea_faster
        
        lda #$2
        sta fleaState
        
        stz fleaSprite

        rtl
        
shootFlea_faster anop
        asl a
        sta fleaSpeed
        
        lda #$1
        sta fleaUpdatePerTile
        
        lda fleaHeightInTile
        lsr a
        sta fleaHeightInTile
        bcc shootFlea_done
        
        lda fleaScreenOffset
        sbc #$a0
        sta fleaScreenOffset
        
shootFlea_done anop
        rtl
        
        
fleaState        dc i2'fleaState_none'
fleaScreenOffset dc i2'0'
fleaTileOffsets  dc i2'0'
                 dc i2'0'
                 dc i2'0'
                 dc i2'0'
fleaHeightInTile dc i2'0'
fleaSpriteCounter dc i2'0'
fleaSprite       dc i2'0'

fleaJumpTable    dc i4'flea1'
                 dc i4'flea2'
                 dc i4'flea3'
                 dc i4'flea4'
                 
fleaSpeed        dc i2'0'
fleaUpdatePerTile dc i2'0'

explosionJumpTable dc i4'explosion1'
                   dc i4'explosion2'
                   dc i4'explosion3'
                   dc i4'explosion4'
                   dc i4'explosion5'
                   dc i4'explosion6'

        end
