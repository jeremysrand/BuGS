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
SPIDER_STATE_SCORE              equ 2
SPIDER_STATE_LEFT_DIAG_DOWN     equ 3
SPIDER_STATE_LEFT_DIAG_UP       equ 4
SPIDER_STATE_LEFT_DOWN          equ 5
SPIDER_STATE_LEFT_UP            equ 6
SPIDER_STATE_RIGHT_DIAG_DOWN    equ 7
SPIDER_STATE_RIGHT_DIAG_UP      equ 8
SPIDER_STATE_RIGHT_DOWN         equ 9
SPIDER_STATE_RIGHT_UP           equ 10


; A spider only travels in the bottom N rows.  This defines that number.
SPIDER_NUM_POSSIBLE_ROWS    equ 10
SPIDER_TOP_ROW              equ GAME_NUM_TILES_TALL-SPIDER_NUM_POSSIBLE_ROWS
SPIDER_TOP_ROW_OFFSET       equ SPIDER_TOP_ROW*GAME_NUM_TILES_WIDE*SIZEOF_TILE_INFO
SPIDER_LHS_TILE_OFFSET      equ SPIDER_TOP_ROW_OFFSET
SPIDER_RHS_TILE_OFFSET      equ SPIDER_TOP_ROW_OFFSET+(GAME_NUM_TILES_WIDE-1)*SIZEOF_TILE_INFO

; The spider starts 2 pixel rows above the top row offset so it can slide in on the edge of
; the screen on a diagonal and hit the centre of the tiles with the middle of its body.
SPIDER_STARTING_SHIFT_SLOW          equ 2
SPIDER_STARTING_SHIFT_FAST          equ 1
SPIDER_LHS_STARTING_SCREEN_OFFSET   equ SCREEN_BYTES_PER_ROW*SPIDER_STARTING_SHIFT_SLOW+6
SPIDER_RHS_STARTING_SCREEN_OFFSET   equ SCREEN_BYTES_PER_ROW*SPIDER_STARTING_SHIFT_SLOW+4

; Every four frames, change the spider sprite
SPIDER_SPRITE_REFRESH_COUNT     equ 4

SPIDER_SCORE_NUM_FRAMES         equ 120

SPIDER_SCORE_300                equ 0
SPIDER_SCORE_600                equ 4
SPIDER_SCORE_900                equ 8

SPIDER_VERT_SPEED_SLOW          equ SCREEN_BYTES_PER_ROW
SPIDER_VERT_SPEED_FAST          equ SCREEN_BYTES_PER_ROW*2

SPIDER_MAX_SHIFT_IN_TILE_SLOW   equ TILE_PIXEL_HEIGHT
SPIDER_MAX_SHIFT_IN_TILE_FAST   equ TILE_PIXEL_HEIGHT/2

SPIDER_LEFT_SCREEN_SHIFT_SLOW   equ 1
SPIDER_LEFT_SCREEN_SHIFT_FAST   equ 0
SPIDER_RIGHT_SCREEN_SHIFT_SLOW   equ 0
SPIDER_RIGHT_SCREEN_SHIFT_FAST   equ 1


drawSpider entry
        lda spiderState
        bne drawSpider_cont
        rtl
        
drawSpider_cont anop
        ldy spiderScreenOffset
        ldx spiderSprite
        jsl spiderJump
        
        _dirtyGameOrNonGameTile spiderTileOffsets
        _dirtyGameOrNonGameTile spiderTileOffsets+2
        _dirtyGameOrNonGameTile spiderTileOffsets+4
        _dirtyGameOrNonGameTile spiderTileOffsets+6
        _dirtyGameOrNonGameTile spiderTileOffsets+8
        _dirtyGameOrNonGameTile spiderTileOffsets+10
        
        rtl
        
spiderJump entry
        cmp #SPIDER_STATE_EXPLODING
        beq spiderJump_exploding
        
        cmp #SPIDER_STATE_SCORE
        beq spiderJump_score
        
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
        
spiderJump_score anop
        lda spiderScoreJumpTable,x
        sta jumpInst+1
        
        lda spiderScoreJumpTable+2,x
        sta jumpInst+3
        bra jumpInst
        
spiderJump_exploding anop
        iny
        lda explosionJumpTable,x
        sta jumpInst+1
        
        lda explosionJumpTable+2,x
        sta jumpInst+3
        
jumpInst jmp >spider1
        nop
        
        
updateSpider entry
        ldx spiderState
        cpx #SPIDER_STATE_LEFT_DIAG_DOWN
        blt updateSpider_testState
        
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
        txa
        asl a
        tax
        jmp (spiderUpdateJumpTable,x)

updateSpider_exploding anop
        lda spiderSprite
        beq updateSpider_explosionDone
        sec
        sbc #$4
        sta spiderSprite
        rtl
                
updateSpider_explosionDone anop
        lda #SPIDER_STATE_SCORE
        sta spiderState
        
        lda #SPIDER_SCORE_NUM_FRAMES
        sta spiderScoreFrames
        
        lda spiderScoreType
        sta spiderSprite
        
        rtl
                
updateSpider_score anop
        lda spiderScoreFrames
        beq updateSpider_scoreDone
        dec a
        sta spiderScoreFrames
        rtl
        
updateSpider_scoreDone anop
        stz spiderState
        rtl

updateSpider_leftDown anop
updateSpider_rightDown anop
        lda spiderScreenOffset
        clc
        adc spiderVertSpeed
        sta spiderScreenOffset
        
        lda spiderShiftInTile
        dec a
        sta spiderShiftInTile
        bne updateSpider_done
        jmp updateSpider_tilesDown

updateSpider_leftUp anop
updateSpider_rightUp anop
        lda spiderScreenOffset
        sec
        sbc spiderVertSpeed
        sta spiderScreenOffset

        lda spiderShiftInTile
        dec a
        sta spiderShiftInTile
        bne updateSpider_done
        jmp updateSpider_tilesUp

updateSpider_rightDiagDown anop
        lda spiderScreenOffset
        clc
        adc spiderVertSpeed
        sta spiderScreenOffset
        
        lda spiderScreenShift
updateSpider_rightDiagDown_eor anop
        eor #1
        sta spiderScreenShift
        cmp spiderRightStartingScreenShift
        bne updateSpider_rightDiagDown_skipInc
        inc spiderScreenOffset
        
updateSpider_rightDiagDown_skipInc anop
        lda spiderShiftInTile
        dec a
        sta spiderShiftInTile
        bne updateSpider_rightDiagDown_cont
        jmp updateSpider_tilesDown
        
updateSpider_rightDiagDown_cont anop
        cmp spiderStartingShift
        bne updateSpider_done
        jmp updateSpider_tilesRight
        
updateSpider_leftDiagDown anop
        lda spiderScreenOffset
        clc
        adc spiderVertSpeed
        sta spiderScreenOffset
        
        lda spiderScreenShift
updateSpider_leftDiagDown_eor anop
        eor #1
        sta spiderScreenShift
        cmp spiderLeftStartingScreenShift
        bne updateSpider_leftDiagDown_skipInc
        dec spiderScreenOffset
        
updateSpider_leftDiagDown_skipInc anop
        lda spiderShiftInTile
        dec a
        sta spiderShiftInTile
        bne updateSpider_leftDiagDown_cont
        jmp updateSpider_tilesDown
        
updateSpider_leftDiagDown_cont anop
        cmp spiderStartingShift
        bne updateSpider_done
        jmp updateSpider_tilesLeft

updateSpider_done anop
        rtl
        
updateSpider_leftDiagUp anop
        lda spiderScreenOffset
        sec
        sbc spiderVertSpeed
        sta spiderScreenOffset
        
        lda spiderScreenShift
updateSpider_leftDiagUp_eor anop
        eor #1
        sta spiderScreenShift
        cmp spiderLeftStartingScreenShift
        bne updateSpider_lefttDiagUp_skipInc
        dec spiderScreenOffset
        
updateSpider_lefttDiagUp_skipInc anop
        lda spiderShiftInTile
        dec a
        sta spiderShiftInTile
        bne updateSpider_lefttDiagUp_cont
        jmp updateSpider_tilesUp
        
updateSpider_lefttDiagUp_cont anop
        cmp spiderStartingShift
        bne updateSpider_done
        jmp updateSpider_tilesLeft
        rtl
        
updateSpider_rightDiagUp anop
        lda spiderScreenOffset
        sec
        sbc spiderVertSpeed
        sta spiderScreenOffset
        
        lda spiderScreenShift
updateSpider_rightDiagUp_eor anop
        eor #1
        sta spiderScreenShift
        cmp spiderRightStartingScreenShift
        bne updateSpider_rightDiagUp_skipInc
        inc spiderScreenOffset
        
updateSpider_rightDiagUp_skipInc anop
        lda spiderShiftInTile
        dec a
        sta spiderShiftInTile
        bne updateSpider_rightDiagUp_cont
        jmp updateSpider_tilesUp
        
updateSpider_rightDiagUp_cont anop
        cmp spiderStartingShift
        bne updateSpider_done
        jmp updateSpider_tilesRight
        rtl
        
updateSpider_tilesRight anop
        ldx spiderTileOffsets+4
        cpx #RHS_FIRST_TILE_OFFSET
        blt updateSpider_tilesRight_cont
        cpx #LHS_FIRST_TILE_OFFSET
        bge updateSpider_tilesRight_cont
        jmp updateSpider_offScreen
updateSpider_tilesRight_cont anop
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

updateSpider_tilesLeft anop
        ldx spiderTileOffsets+4
        cpx #LHS_FIRST_TILE_OFFSET
        blt updateSpider_tilesLeft_cont
        jmp updateSpider_offScreen
updateSpider_tilesLeft_cont anop
        stx spiderTileOffsets
        
        ldx spiderTileOffsets+6
        stx spiderTileOffsets+2
        
        ldx spiderTileOffsets+10
        stx spiderTileOffsets+6
        lda tiles+TILE_LEFT_OFFSET,x
        sta spiderTileOffsets+10
        
        ldx spiderTileOffsets+8
        stx spiderTileOffsets+4
        lda tiles+TILE_LEFT_OFFSET,x
        sta spiderTileOffsets+8
        
        rtl
        
updateSpider_tilesUp anop
        lda spiderMaxShiftInTile
        sta spiderShiftInTile
        
        lda spiderCurrentRow
        dec a
        sta spiderCurrentRow
        cmp spiderTargetRow
        beq updateSpider_upChangeDir
        
        ldx spiderTileOffsets+2
        stx spiderTileOffsets
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+2
        
        ldx spiderTileOffsets+6
        stx spiderTileOffsets+4
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+6

; As per the below, clear any mushroom if present
        cpx #RHS_FIRST_TILE_OFFSET
        bge updateSpider_tilesUpCont
        lda tiles+TILE_TYPE_OFFSET,x
        beq updateSpider_tilesUpCont
        lda #TILE_EMPTY
        sta tiles+TILE_TYPE_OFFSET,x
        
updateSpider_tilesUpCont anop
        ldx spiderTileOffsets+10
        stx spiderTileOffsets+8
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+10
        rtl
        
updateSpider_upChangeDir anop
        lda #GAME_NUM_TILES_TALL-1
        sec
        sbc spiderTargetRow
        jsl randN
        inc a
        clc
        adc spiderTargetRow
        sta spiderTargetRow
        
        jsl rand0_to_65534
        and #1
        beq updateSpider_upChangeDirDiag
        lda spiderState
        cmp #SPIDER_STATE_RIGHT_DIAG_DOWN
        bge updateSpider_upChangeDirDownRight
        lda #SPIDER_STATE_LEFT_DOWN
        sta spiderState
        rtl
updateSpider_upChangeDirDownRight anop
        lda #SPIDER_STATE_RIGHT_DOWN
        sta spiderState
        rtl
        
updateSpider_upChangeDirDiag anop
        lda spiderState
        cmp #SPIDER_STATE_RIGHT_DIAG_DOWN
        bge updateSpider_upChangeDirDiagRight
        lda #SPIDER_STATE_LEFT_DIAG_DOWN
        sta spiderState
        rtl
updateSpider_upChangeDirDiagRight anop
        lda #SPIDER_STATE_RIGHT_DIAG_DOWN
        sta spiderState
        rtl
        
updateSpider_tilesDown anop
        lda spiderMaxShiftInTile
        sta spiderShiftInTile

        lda spiderCurrentRow
        inc a
        sta spiderCurrentRow
        cmp spiderTargetRow
        beq updateSpider_downChangeDir

        ldx spiderTileOffsets
        stx spiderTileOffsets+2
        lda tiles+TILE_BELOW_OFFSET,x
        sta spiderTileOffsets
        
        ldx spiderTileOffsets+4
        stx spiderTileOffsets+6
        lda tiles+TILE_BELOW_OFFSET,x
        sta spiderTileOffsets+4
        
; If the middle tile is a game time and it isn't empty, then
; empty it.  Spiders "consume" mushrooms as they pass over them.
        cpx #RHS_FIRST_TILE_OFFSET
        bge updateSpider_tilesDownCont
        lda tiles+TILE_TYPE_OFFSET,x
        beq updateSpider_tilesDownCont
        lda #TILE_EMPTY
        sta tiles+TILE_TYPE_OFFSET,x
        
updateSpider_tilesDownCont anop
        ldx spiderTileOffsets+8
        stx spiderTileOffsets+10
        lda tiles+TILE_BELOW_OFFSET,x
        sta spiderTileOffsets+8
        rtl
        
updateSpider_downChangeDir anop
        lda spiderTargetRow
        sec
        sbc #SPIDER_TOP_ROW
        jsl randN
        inc a
        clc
        adc #SPIDER_TOP_ROW-1
        sta spiderTargetRow
        
        jsl rand0_to_65534
        and #1
        beq updateSpider_downChangeDirDiag
        lda spiderState
        cmp #SPIDER_STATE_RIGHT_DIAG_DOWN
        bge updateSpider_downChangeDirUpRight
        lda #SPIDER_STATE_LEFT_UP
        sta spiderState
        rtl
updateSpider_downChangeDirUpRight anop
        lda #SPIDER_STATE_RIGHT_UP
        sta spiderState
        rtl
        
updateSpider_downChangeDirDiag anop
        lda spiderState
        cmp #SPIDER_STATE_RIGHT_DIAG_DOWN
        bge updateSpider_downChangeDirDiagRight
        lda #SPIDER_STATE_LEFT_DIAG_UP
        sta spiderState
        rtl
updateSpider_downChangeDirDiagRight anop
        lda #SPIDER_STATE_RIGHT_DIAG_UP
        sta spiderState
        rtl
        
updateSpider_offScreen anop
        stz spiderState
; Uncomment the following line to continuously add
;        jsl addSpider
        rtl
        
        
addSpider entry
        lda spiderState
        beq addSpider_doit
        rtl
        
addSpider_doit anop
        lda spiderStartingShift
        sta spiderShiftInTile
        
        lda #SPIDER_SPRITE_LAST_OFFSET
        sta spiderSprite
        
        lda #SPIDER_SPRITE_REFRESH_COUNT
        sta spiderSpriteRefresh
        
        lda #SPIDER_TOP_ROW-1
        sta spiderCurrentRow
        
        lda #SPIDER_NUM_POSSIBLE_ROWS-1
        jsl randN
        adc #SPIDER_TOP_ROW+1
        sta spiderTargetRow
        
        jsl rand0_to_65534
        and #1
        beq addSpider_right

addSpider_left anop
        lda #SPIDER_STATE_LEFT_DIAG_DOWN
        sta spiderState
        
        lda spiderLeftStartingScreenShift
        sta spiderScreenShift
        
        ldx #SPIDER_RHS_TILE_OFFSET
        stx spiderTileOffsets+8
        
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+10
        
        lda tiles+TILE_RIGHT_OFFSET,x
        sta spiderTileOffsets+4
        
        tax
        lda tiles+TILE_SCREEN_OFFSET_OFFSET,x
        sec
        sbc #SPIDER_RHS_STARTING_SCREEN_OFFSET
        sta spiderScreenOffset
        
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+6
        
        lda tiles+TILE_RIGHT_OFFSET,x
        sta spiderTileOffsets
        
        tax
        lda tiles+TILE_ABOVE_OFFSET,x
        sta spiderTileOffsets+2
        
        rtl
        
addSpider_right anop
        lda #SPIDER_STATE_RIGHT_DIAG_DOWN
        sta spiderState
        
        lda spiderRightStartingScreenShift
        sta spiderScreenShift
        
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
        
        rtl
        
        
setSpiderSpeed entry
        cmp #SPRITE_SPEED_FAST
        beq setSpiderSpeed_fast
        
        lda #SPIDER_VERT_SPEED_SLOW
        sta spiderVertSpeed
        
        lda #SPIDER_MAX_SHIFT_IN_TILE_SLOW
        sta spiderMaxShiftInTile
        
        lda #SPIDER_STARTING_SHIFT_SLOW
        sta spiderStartingShift
        
        lda #SPIDER_LEFT_SCREEN_SHIFT_SLOW
        sta spiderLeftStartingScreenShift
        
        lda #SPIDER_RIGHT_SCREEN_SHIFT_SLOW
        sta spiderRightStartingScreenShift
        
; This is funky.  This sets the instruction at these location to be an immediate eor
; instruction.  That causes us to only move to the next byte every other frame.
        short i,m
        lda #$49
        sta updateSpider_rightDiagDown_eor
        sta updateSpider_rightDiagUp_eor
        sta updateSpider_leftDiagDown_eor
        sta updateSpider_leftDiagUp_eor
        long i,m
        
        rtl
        
setSpiderSpeed_fast anop
        lda #SPIDER_VERT_SPEED_FAST
        sta spiderVertSpeed
        
        lda #SPIDER_MAX_SHIFT_IN_TILE_FAST
        sta spiderMaxShiftInTile
        
        lda #SPIDER_STARTING_SHIFT_FAST
        sta spiderStartingShift
        
        lda #SPIDER_LEFT_SCREEN_SHIFT_FAST
        sta spiderLeftStartingScreenShift
        
        lda #SPIDER_RIGHT_SCREEN_SHIFT_FAST
        sta spiderRightStartingScreenShift
        
; This is funky.  This sets the instruction at these location to be an immediate or
; instruction for the right and and immediate and instruction for the left.  That causes
; us to only move to the next byte on every frame.
        short i,m
        lda #$09
        sta updateSpider_rightDiagDown_eor
        sta updateSpider_rightDiagUp_eor
        lda #$29
        sta updateSpider_leftDiagDown_eor
        sta updateSpider_leftDiagUp_eor
        long i,m
        
        rtl
        
        
shootSpider entry
        lda spiderState
        cmp #SPIDER_STATE_LEFT_DIAG_DOWN
        blt shootSpider_done
        
        lda #SPIDER_STATE_EXPLODING
        sta spiderState
        
        lda #EXPLOSION_LAST_OFFSET
        sta spiderSprite
        
        lda spiderScreenOffset
        inc a
        sta spiderScreenOffset
        
; TODO - Increase the score and set the spiderScoreType to 0, 4 or 8 for
; 300, 600 or 900 points depending on the distance from the player.
        lda #SPIDER_SCORE_900
        sta spiderScoreType
        
shootSpider_done anop
        rtl
        
        
spiderState         dc i2'SPIDER_STATE_NONE'
spiderSprite        dc i2'0'
spiderSpriteRefresh dc i2'0'
spiderScreenOffset  dc i2'0'
spiderScreenShift   dc i2'0'
spiderShiftInTile   dc i2'0'

spiderCurrentRow    dc i2'0'
spiderTargetRow     dc i2'0'

spiderScoreType     dc i2'0'
spiderScoreFrames   dc i2'0'

spiderVertSpeed                 dc i2'SPIDER_VERT_SPEED_SLOW'
spiderMaxShiftInTile            dc i2'SPIDER_MAX_SHIFT_IN_TILE_SLOW'
spiderStartingShift             dc i2'SPIDER_STARTING_SHIFT_SLOW'
spiderLeftStartingScreenShift   dc i2'SPIDER_LEFT_SCREEN_SHIFT_SLOW'
spiderRightStartingScreenShift  dc i2'SPIDER_RIGHT_SCREEN_SHIFT_SLOW'


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
                     
                     
spiderUpdateJumpTable dc i2'updateSpider_done'
                      dc i2'updateSpider_exploding'
                      dc i2'updateSpider_score'
                      dc i2'updateSpider_leftDiagDown'
                      dc i2'updateSpider_leftDiagUp'
                      dc i2'updateSpider_leftDown'
                      dc i2'updateSpider_leftUp'
                      dc i2'updateSpider_rightDiagDown'
                      dc i2'updateSpider_rightDiagUp'
                      dc i2'updateSpider_rightDown'
                      dc i2'updateSpider_rightUp'
                      
                      
spiderScoreJumpTable  dc i4'score300'
                      dc i4'score600'
                      dc i4'score900'
                      
                
        end
