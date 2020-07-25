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
SPIDER_STATE_EXPLODING          equ 1
SPIDER_STATE_LEFT_DIAG_DOWN     equ 2
SPIDER_STATE_LEFT_DIAG_UP       equ 3
SPIDER_STATE_LEFT_DOWN          equ 4
SPIDER_STATE_LEFT_UP            equ 5
SPIDER_STATE_RIGHT_DIAG_DOWN    equ 6
SPIDER_STATE_RIGHT_DIAG_UP      equ 7
SPIDER_STATE_RIGHT_DOWN         equ 8
SPIDER_STATE_RIGHT_UP           equ 9


; A spider only travels in the bottom N rows.  This defines that number.
SPIDER_NUM_POSSIBLE_ROWS    equ 10
SPIDER_TOP_ROW              equ GAME_NUM_TILES_TALL-SPIDER_NUM_POSSIBLE_ROWS
SPIDER_TOP_ROW_OFFSET       equ SPIDER_TOP_ROW*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO
SPIDER_LHS_TILE_OFFSET      equ SPIDER_TOP_ROW_OFFSET
SPIDER_RHS_TILE_OFFSET      equ SPIDER_TOP_ROW_OFFSET+(GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO

; The spider starts 2 pixel rows above the top row offset so it can slide in on the edge of
; the screen on a diagonal and hit the centre of the tiles with the middle of its body.
SPIDER_STARTING_SHIFT               equ 2
SPIDER_LHS_STARTING_SCREEN_OFFSET   equ SCREEN_BYTES_PER_ROW*SPIDER_STARTING_SHIFT+6

SPIDER_SPRITE_REFRESH_COUNT     equ 4


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
        ldx spiderTileOffsets+10
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
        bne spiderJump_shift
        
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
        lda spiderState
        bne updateSpider_cont
        rtl
        
updateSpider_cont anop

        dec a
        beq updateSpider_exploding
        
        tay
        
        lda spiderSpriteRefresh
        beq updateSpider_spriteRefresh
        dec a
        sta spiderSpriteRefresh
        bra updateSpider_testState
        
updateSpider_spriteRefresh anop
        lda #SPIDER_SPRITE_REFRESH_COUNT
        sta spiderSpriteRefresh
        lda spiderSprite
        beq updateSpider_resetSprite
        sec
        sbc #$4
        sta spiderSprite
        bra updateSpider_testState
        
updateSpider_resetSprite anop
        lda #SPIDER_SPRITE_LAST_OFFSET
        sta spiderSprite
        
updateSpider_testState anop
        tya
        dec a
        beq updateSpider_leftDiagDown
        
        dec a
        beq updateSpider_leftDiagUp
        
        dec a
        beq updateSpider_leftDown
        
        dec a
        beq updateSpider_leftUp
        
        dec a
        beq updateSpider_rightDiagDown
        
        dec a
        beq updateSpider_rightDiagUp
        
        dec a
        beq updateSpider_rightDown
        
        bra updateSpider_rightUp

updateSpider_exploding anop
        lda spiderSprite
        beq updateSpider_explosionDone
        sec
        sbc #$4
        sta spiderSprite
        rtl
                
updateSpider_explosionDone anop
        stz spiderState
        rtl


updateSpider_leftDiagDown anop
updateSpider_leftDiagUp anop
updateSpider_leftDown anop
updateSpider_leftUp anop
updateSpider_rightDiagUp anop
updateSpider_rightDown anop
updateSpider_rightUp anop
; Write this code
        rtl

updateSpider_rightDiagDown anop
        jsl waitForKey
        lda spiderScreenOffset
        clc
        adc #SCREEN_BYTES_PER_ROW
        sta spiderScreenOffset
        
        lda spiderScreenShift
        eor #1
        sta spiderScreenShift
        bne updateSpider_rightDiagDown_skipInc
        inc spiderScreenOffset
        
updateSpider_rightDiagDown_skipInc anop
        
        lda spiderShiftInTile
        dec a
        sta spiderShiftInTile
        beq updateSpider_tilesRight
        
        cmp #5
        beq updateSpider_tilesDown
        rtl
        
updateSpider_tilesRight anop
        ldx spiderTileOffsets+4
        cmp #RHS_FIRST_TILE_OFFSET
        bge updateSpider_offScreen
        stx spiderTileOffsets+8
        
        ldx spiderTileOffsets+6
        stx spiderTileOffsets+10
        
        ldx spiderTileOffsets+2
        stx spiderTileOffsets+6
        lda tiles+TILE_RIGHT_OFFSET,x
        sta spiderTileOffsets+2
        
        ldx spiderTileOffsets
        stx spiderTileOffsets+4
        lda tiles+TILE_RIGHT_OFFSET,x
        sta spiderTileOffsets
        
        rtl
        
updateSpider_tilesDown anop
        ldx spiderTileOffsets
        stx spiderTileOffsets+2
        lda tiles+TILE_BELOW_OFFSET,x
        cmp #INVALID_TILE_NUM
        beq updateSpider_offScreen
        sta spiderTileOffsets
        
        ldx spiderTileOffsets+4
        stx spiderTileOffsets+6
        lda tiles+TILE_BELOW_OFFSET,x
        sta spiderTileOffsets+4
        
        ldx spiderTileOffsets+8
        stx spiderTileOffsets+10
        lda tiles+TILE_BELOW_OFFSET,x
        sta spiderTileOffsets+8
        
        rtl
        
updateSpider_offScreen anop
        stz spiderState
        rtl
        
        
addSpider entry
        lda spiderState
        bne addSpider_done
        
        lda #SPIDER_STATE_RIGHT_DIAG_DOWN
        sta spiderState
        
        stz spiderScreenShift
        
        ldx #SPIDER_LHS_TILE_OFFSET
        stx spiderTileOffsets
        
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+2
        
        lda tiles+TILE_LEFT_OFFSET,x
        sta spiderTileOffsets+4
        
        tax
        lda tiles+TILE_SCREEN_OFFSET_OFFSET,x
        sec
        sbc #SPIDER_LHS_STARTING_SCREEN_OFFSET
        sta spiderScreenOffset
        
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+6
        
        lda tiles+TILE_LEFT_OFFSET,x
        sta spiderTileOffsets+8
        
        tax
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+10
        
        lda #7
        sta spiderShiftInTile
        
        lda #SPIDER_SPRITE_LAST_OFFSET
        sta spiderSprite
        
        lda #SPIDER_SPRITE_REFRESH_COUNT
        sta spiderSpriteRefresh
        
addSpider_done anop
        rtl
        
        
shootSpider entry
; Write this code
        rtl
        
        
spiderState         dc i2'SPIDER_STATE_NONE'
spiderSprite        dc i2'0'
spiderSpriteRefresh dc i2'0'
spiderScreenOffset  dc i2'0'
spiderScreenShift   dc i2'0'
spiderShiftInTile   dc i2'0'


;  10  6  2
;   8  4  0
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
