;
;  gameSpider.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-23.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;
        
        case on
        mcopy gameSpider.macros
        keep gameSpider

gameSpider start
        using globalData

SPIDER_STATE_NONE               equ 0
SPIDER_STATE_LEFT_DIAG_DOWN     equ 1
SPIDER_STATE_LEFT_DIAG_UP       equ 2
SPIDER_STATE_LEFT_DOWN          equ 3
SPIDER_STATE_LEFT_UP            equ 4
SPIDER_STATE_RIGHT_DIAG_DOWN    equ 5
SPIDER_STATE_RIGHT_DIAG_UP      equ 6
SPIDER_STATE_RIGHT_DOWN         equ 7
SPIDER_STATE_RIGHT_UP           equ 8
SPIDER_STATE_EXPLODING          equ 9

drawSpider entry
        lda spiderState
        bne drawSpider_cont
        rtl
        
drawSpider_cont anop
        ldy spiderScreenOffset
        ldx spiderSprite
        jsl spiderJump
        
        ldx spiderTileOffsets
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawSpider_skipTile1
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawSpider_nonGame1
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        bra drawSpider_skipTile1
        
drawSpider_nonGame1 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles
        
drawSpider_skipTile1 anop
        ldx spiderTileOffsets+2
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawSpider_skipTile2
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawSpider_nonGame2
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        bra drawSpider_skipTile2
        
drawSpider_nonGame2 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles

drawSpider_skipTile2 anop
        ldx spiderTileOffsets+4
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawSpider_skipTile3
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawSpider_nonGame3
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        bra drawSpider_skipTile3
        
drawSpider_nonGame3 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles
    
drawSpider_skipTile3 anop
        ldx spiderTileOffsets+6
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawSpider_skipTile4
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawSpider_nonGame4
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        bra drawSpider_skipTile4
        
drawSpider_nonGame4 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles

drawSpider_skipTile4 anop
        ldx spiderTileOffsets+8
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawSpider_skipTile5
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawSpider_nonGame5
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        bra drawSpider_skipTile5
        
drawSpider_nonGame5 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles
    
drawSpider_skipTile5 anop
        ldx spiderTileOffsets+2
        lda tiles+TILE_DIRTY_OFFSET,x
        bne drawSpider_done
        lda #TILE_STATE_DIRTY
        sta tiles+TILE_DIRTY_OFFSET,x
        txa
        cmp #RHS_FIRST_TILE_OFFSET
        bge drawSpider_nonGame6
        
        ldy numDirtyGameTiles
        sta dirtyGameTiles,y
        iny
        iny
        sty numDirtyGameTiles
        rtl
        
drawSpider_nonGame6 anop
        ldy numDirtyNonGameTiles
        sta dirtyNonGameTiles,y
        iny
        iny
        sty numDirtyNonGameTiles
    
drawSpider_done anop
        rtl
        
spiderJump entry
        cmp #SPIDER_STATE_EXPLODING
        beq spiderJump_exploding
        
        lda spiderScreenShift
        beq spiderJump_shift
        
        lda spiderJumpTable,x
        sta jumpInst+1
        
        lda spiderJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
spiderJump_shift anop
        lda spiderShiftJumpTable,x
        sta jumpInst+1

        lda spiderShiftJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
spiderJump_exploding anop
        tya
        clc
        adc #TILE_BYTE_WIDTH
        tay
        
        lda explosionJumpTable,x
        sta jumpInst+1
        
        lda explosionJumpTable+2,x
        sta jumpInst+3
        
jumpInst jmp >spider1
        nop
        
        
updateSpider entry
; Write this code
        rtl
        
        
addSpider entry
        lda spiderState
        bne addSpider_done
        
        lda #SPIDER_STATE_RIGHT_DOWN
        sta spiderState
        
        stz spiderScreenShift
        
; Write this code
        
addSpider_done anop
        rtl
        
        
shootSpider entry
; Write this code
        rtl
        
        
spiderState         dc i2'SPIDER_STATE_NONE'
spiderSprite        dc i2'0'
spiderScreenOffset  dc i2'0'
spiderScreenShift   dc i2'0'
spiderShiftInTile   dc i2'0'

spiderTileOffsets   dc i2'0'
                    dc i2'0'
                    dc i2'0'
                    dc i2'0'
                    dc i2'0'
                    dc i2'0'

SPIDER_SPRITE_LAST_OFFSET   gequ 7*4
spiderJumpTable dc i4'spider7'
                dc i4'spider6'
                dc i4'spider2'
                dc i4'spider3'
                dc i4'spider4'
                dc i4'spider3'
                dc i4'spider2'
                dc i4'spider1'
                

spiderShiftJumpTable dc i4'spider7s'
                     dc i4'spider6s'
                     dc i4'spider2s'
                     dc i4'spider3s'
                     dc i4'spider4s'
                     dc i4'spider3s'
                     dc i4'spider2s'
                     dc i4'spider1s'
                
        end
