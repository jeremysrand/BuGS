;
;  gameSegments.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-30.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy gameSegments.macros
        keep gameSegments

gameSegments start
        using globalData
        
        
SEGMENT_MAX_NUM     equ 12
SEGMENT_MAX_OFFSET  equ SEGMENT_MAX_NUM*2-2

SEGMENT_STATE_NONE  equ 0
SEGMENT_STATE_HEAD  equ 1
SEGMENT_STATE_BODY  equ 2

SEGMENT_DIR_LEFT    equ 0
SEGMENT_DIR_RIGHT   equ 1

SEGMENT_FACING_LEFT         equ 0
SEGMENT_FACING_DOWN_LEFT    equ 32
SEGMENT_FACING_DOWN         equ 64
SEGMENT_FACING_DOWN_RIGHT   equ 96
SEGMENT_FACING_RIGHT        equ 128
        
        
drawSegments entry
        ldx #SEGMENT_MAX_OFFSET
drawSegments_nextSegment anop
        lda segmentStates,x
        beq drawSegments_skipSegment

        lda segmentFacing,x
        clc
        adc segmentSpriteOffset
        tay
        
        lda segmentStates,x
        cmp #SEGMENT_STATE_HEAD
        beq drawSegments_head
        jsl segmentBodyJump
        bra drawSegments_handleTiles
        
drawSegments_head anop
        jsl segmentHeadJump
        
drawSegments_handleTiles anop
        _dirtyGameTileWithX segmentTileOffsetsUL
        _dirtyGameTileWithX segmentTileOffsetsUR
        _dirtyGameTileWithX segmentTileOffsetsLL
        _dirtyGameTileWithX segmentTileOffsetsLR
        
drawSegments_skipSegment anop
        dex
        dex
        bmi drawSegments_done
        bra drawSegments_nextSegment
        
drawSegments_done anop
        rtl
        
        
segmentHeadJump entry
        lda segmentScreenShifts,x
        beq segmentHeadJump_noShift
        
        lda headShiftJumpTable,y
        sta segmentHeadJump_jumpInst+1
        lda headShiftJumpTable+2,y
        sta segmentHeadJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        bra segmentHeadJump_jumpInst
        
segmentHeadJump_noShift anop
        lda headJumpTable,y
        sta segmentHeadJump_jumpInst+1
        lda headJumpTable+2,y
        sta segmentHeadJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        
segmentHeadJump_jumpInst anop
        jmp >leftHead1
        

segmentBodyJump entry
        lda segmentScreenShifts,x
        beq segmentBodyJump_noShift
        
        lda bodyShiftJumpTable,y
        sta segmentBodyJump_jumpInst+1
        lda bodyShiftJumpTable+2,y
        sta segmentBodyJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        bra segmentBodyJump_jumpInst
        
segmentBodyJump_noShift anop
        lda bodyJumpTable,y
        sta segmentBodyJump_jumpInst+1
        lda bodyJumpTable+2,y
        sta segmentBodyJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        
segmentBodyJump_jumpInst anop
        jmp >leftHead1
        
        
updateSegments entry
        lda segmentSpriteShift
        eor #1
        sta segmentSpriteShift
        beq updateSegments_skipSpriteOffset

        lda segmentSpriteOffset
        beq updateSegments_resetSpriteOffset
        sec
        sbc #$4
        bra updateSegments_spriteOffsetCont
        
updateSegments_resetSpriteOffset anop
        lda #SEGMENT_SPRITE_LAST_OFFSET
updateSegments_spriteOffsetCont anop
        sta segmentSpriteOffset

updateSegments_skipSpriteOffset anop

; Write this code...
        rtl
        

addBodySegment entry
        lda numSegments
        asl a
        tax

        lda #SEGMENT_STATE_BODY
        sta segmentStates,x

        lda #SEGMENT_DIR_LEFT
        sta segmentDirections,x

        lda #SEGMENT_FACING_LEFT
        sta segmentFacing,x

        lda tileScreenOffset,x
        sec
        sbc #3
        sta segmentScreenOffsets,x

        stz segmentScreenShifts,x

        txa
        sta segmentTileOffsetsUL,x
        sta segmentTileOffsetsUR,x
        sta segmentTileOffsetsLL,x
        sta segmentTileOffsetsLR,x
        
        inc numSegments

        rtl
        
        
addHeadSegment entry
        lda numSegments
        asl a
        tax
        
        lda #SEGMENT_STATE_HEAD
        sta segmentStates,x
        
        lda #SEGMENT_DIR_LEFT
        sta segmentDirections,x
        
        lda #SEGMENT_FACING_LEFT
        sta segmentFacing,x
        
        lda tileScreenOffset,x
        sec
        sbc #3
        sta segmentScreenOffsets,x
        
        stz segmentScreenShifts,x
        
        txa
        sta segmentTileOffsetsUL,x
        sta segmentTileOffsetsUR,x
        sta segmentTileOffsetsLL,x
        sta segmentTileOffsetsLR,x
        
        inc numSegments
        
        rtl
        

shootSegment entry
; Write this code...
        rtl


numSegments     dc i2'0'

segmentStates           dc 12i2'SEGMENT_STATE_NONE'
segmentDirections       dc 12i2'SEGMENT_DIR_RIGHT'
segmentFacing           dc 12i2'SEGMENT_FACING_DOWN'
segmentScreenOffsets    dc 12i2'0'
segmentScreenShifts     dc 12i2'0'
segmentTileOffsetsUL    dc 12i2'0'
segmentTileOffsetsUR    dc 12i2'0'
segmentTileOffsetsLL    dc 12i2'0'
segmentTileOffsetsLR    dc 12i2'0'

SEGMENT_SPRITE_LAST_OFFSET  gequ 7*4
segmentSpriteOffset dc i2'SEGMENT_SPRITE_LAST_OFFSET'
segmentSpriteShift  dc i2'0'


headJumpTable anop
; leftHeadJumpTable
                    dc i4'leftHead5'
                    dc i4'leftHead4'
                    dc i4'leftHead1'
                    dc i4'leftHead2'
                    dc i4'leftHead3'
                    dc i4'leftHead2'
                    dc i4'leftHead1'
                    dc i4'leftHead4'

; leftDownHeadJumpTable
                    dc i4'leftDownHead1'
                    dc i4'leftDownHead2'
                    dc i4'leftDownHead1'
                    dc i4'leftDownHead2'
                    dc i4'leftDownHead1'
                    dc i4'leftDownHead2'
                    dc i4'leftDownHead1'
                    dc i4'leftDownHead2'


; downHeadJumpTable
                    dc i4'downHead3'
                    dc i4'downHead3'
                    dc i4'downHead1'
                    dc i4'downHead1'
                    dc i4'downHead2'
                    dc i4'downHead2'
                    dc i4'downHead1'
                    dc i4'downHead1'


; rightDownHeadJumpTable
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'       ; Problem, spills into next tile...
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'       ; Problem, spills into next tile...
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'       ; Problem, spills into next tile...
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'       ; Problem, spills into next tile...


; rightHeadJumpTable
                    dc i4'rightHead5'
                    dc i4'rightHead4'
                    dc i4'rightHead1'
                    dc i4'rightHead2'
                    dc i4'rightHead3'
                    dc i4'rightHead2'
                    dc i4'rightHead1'
                    dc i4'rightHead4'
                    
                    
headShiftJumpTable  anop
; leftHeadShiftJumpTable
                    dc i4'leftHead5s'
                    dc i4'leftHead4s'
                    dc i4'leftHead1s'
                    dc i4'leftHead2s'
                    dc i4'leftHead3s'
                    dc i4'leftHead2s'
                    dc i4'leftHead1s'
                    dc i4'leftHead4s'


; leftDownShiftHeadJumpTable
                    dc i4'leftDownHead1s'
                    dc i4'leftDownHead2s'       ; Problem, spills into next tile...
                    dc i4'leftDownHead1s'
                    dc i4'leftDownHead2s'       ; Problem, spills into next tile...
                    dc i4'leftDownHead1s'
                    dc i4'leftDownHead2s'       ; Problem, spills into next tile...
                    dc i4'leftDownHead1s'
                    dc i4'leftDownHead2s'       ; Problem, spills into next tile...


; downHeadJumpTable
                    dc i4'downHead3'
                    dc i4'downHead3'
                    dc i4'downHead1'
                    dc i4'downHead1'
                    dc i4'downHead2'
                    dc i4'downHead2'
                    dc i4'downHead1'
                    dc i4'downHead1'


; rightDownShiftHeadJumpTable
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'


; rightHeadShiftJumpTable
                    dc i4'rightHead5s'
                    dc i4'rightHead4s'
                    dc i4'rightHead1s'
                    dc i4'rightHead2s'
                    dc i4'rightHead3s'
                    dc i4'rightHead2s'
                    dc i4'rightHead1s'
                    dc i4'rightHead4s'


bodyJumpTable   anop
; leftBodyJumpTable
                    dc i4'leftBody5'
                    dc i4'leftBody4'
                    dc i4'leftBody1'
                    dc i4'leftBody2'
                    dc i4'leftBody3'
                    dc i4'leftBody2'
                    dc i4'leftBody1'
                    dc i4'leftBody4'


; leftDownBodyJumpTable
                    dc i4'leftDownBody1'
                    dc i4'leftDownBody2'
                    dc i4'leftDownBody1'
                    dc i4'leftDownBody2'
                    dc i4'leftDownBody1'
                    dc i4'leftDownBody2'
                    dc i4'leftDownBody1'
                    dc i4'leftDownBody2'


; downBodyJumpTable
                    dc i4'downBody3'
                    dc i4'downBody3'
                    dc i4'downBody1'
                    dc i4'downBody1'
                    dc i4'downBody2'
                    dc i4'downBody2'
                    dc i4'downBody1'
                    dc i4'downBody1'


; rightDownBodyJumpTable
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'       ; Problem, spills into next tile...
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'       ; Problem, spills into next tile...
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'       ; Problem, spills into next tile...
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'       ; Problem, spills into next tile...


; rightBodyJumpTable
                    dc i4'rightBody5'
                    dc i4'rightBody4'
                    dc i4'rightBody1'
                    dc i4'rightBody2'
                    dc i4'rightBody3'
                    dc i4'rightBody2'
                    dc i4'rightBody1'
                    dc i4'rightBody4'
                    
                    
bodyShiftJumpTable anop
; leftBodyShiftJumpTable
                    dc i4'leftBody5s'
                    dc i4'leftBody4s'
                    dc i4'leftBody1s'
                    dc i4'leftBody2s'
                    dc i4'leftBody3s'
                    dc i4'leftBody2s'
                    dc i4'leftBody1s'
                    dc i4'leftBody4s'


; leftDownShiftBodyJumpTable
                    dc i4'leftDownBody1s'
                    dc i4'leftDownBody2s'       ; Problem, spills into next tile...
                    dc i4'leftDownBody1s'
                    dc i4'leftDownBody2s'       ; Problem, spills into next tile...
                    dc i4'leftDownBody1s'
                    dc i4'leftDownBody2s'       ; Problem, spills into next tile...
                    dc i4'leftDownBody1s'
                    dc i4'leftDownBody2s'       ; Problem, spills into next tile...
        
        
; downBodyJumpTable
                    dc i4'downBody3'
                    dc i4'downBody3'
                    dc i4'downBody1'
                    dc i4'downBody1'
                    dc i4'downBody2'
                    dc i4'downBody2'
                    dc i4'downBody1'
                    dc i4'downBody1'


; rightDownShiftBodyJumpTable
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'


; rightBodyShiftJumpTable
                    dc i4'rightBody5s'
                    dc i4'rightBody4s'
                    dc i4'rightBody1s'
                    dc i4'rightBody2s'
                    dc i4'rightBody3s'
                    dc i4'rightBody2s'
                    dc i4'rightBody1s'
                    dc i4'rightBody4s'

 
        end
