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

SEGMENT_STATE_NONE          equ 0
SEGMENT_STATE_HEAD          equ 1
SEGMENT_STATE_POISONED_HEAD equ 2
SEGMENT_STATE_BODY          equ 3

SEGMENT_DIR_LEFT    equ 0
SEGMENT_DIR_RIGHT   equ 1

SEGMENT_DIR_DOWN    equ 0
SEGMENT_DIR_UP      equ 1

; You would think I would need "facing up" variants here also.  When the centipede gets to the bottom of
; the screen, it starts traveling up again and when it turns, you would think it would face up.  Turns out
; the real arcade system uses "facing down" sprites even when the centipede is moving up.  So, I guess I
; will too.  I suspect that the players tend not to notice because by the time the centipede is traveling
; up, they are pretty occupied by the fact that they are now surrounded by segments.
SEGMENT_FACING_LEFT         equ 0
SEGMENT_FACING_DOWN_LEFT    equ 32
SEGMENT_FACING_DOWN         equ 64
SEGMENT_FACING_DOWN_RIGHT   equ 96
SEGMENT_FACING_RIGHT        equ 128
        
        
drawSegments entry
        ldx #SEGMENT_MAX_OFFSET
drawSegments_nextSegment anop
        lda segmentStates,x
        bne drawSegments_cont
        jmp drawSegments_skipSegment

drawSegments_cont anop
        phx
        lda segmentStates,x
        cmp #SEGMENT_STATE_BODY
        bne drawSegments_head
        jsl segmentBodyJump
        bra drawSegments_handleTiles
        
drawSegments_head anop
        jsl segmentHeadJump
        
; By the time we come back from segment*Jump, the X register no longer has the original 0-22
; offset.  Instead, we have a position offset which goes from 0-190.  But that is good because
; we need to use that offset to update our dirty tiles.
        
drawSegments_handleTiles anop
; We do have to handle non-game tiles.  When centipede reaches the bottom, new segements are
; added randomly in from the side.  That segment needs to be clipped so we need to use non-game
; tiles to do that clipping for us.
        _dirtyGameOrNonGameTileX segmentTileOffsetsUL
        _dirtyGameOrNonGameTileX segmentTileOffsetsUR
        _dirtyGameOrNonGameTileX segmentTileOffsetsLL
        _dirtyGameOrNonGameTileX segmentTileOffsetsLR
        
; Get our original 0-22 offset we are iterating through that we pushed earlier because we know
; it was going to get trashed.
        plx
drawSegments_skipSegment anop
        dex
        dex
        bmi drawSegments_done
        jmp drawSegments_nextSegment
        
drawSegments_done anop
        rtl
        
        
segmentHeadJump entry
        lda segmentPosOffset,x
        tax
        
        lda segmentFacing,x
        clc
        adc segmentSpriteOffset
        tay
        
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
        nop
        
segmentBodyJump entry
        lda segmentPosOffset,x
        tax
        
        lda segmentFacing,x
        clc
        adc segmentSpriteOffset
        tay
        
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
        nop
        
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
        lda #SEGMENT_MAX_NUM-1
        sec
        sbc numSegments
        asl a
        tax

        lda #SEGMENT_STATE_BODY
        sta segmentStates,x
        
        txa
        asl a
        asl a
        asl a
        sta segmentPosOffset,x
        tay

        lda #SEGMENT_DIR_RIGHT
        sta segmentHorizontalDir,y
        
        lda #SEGMENT_DIR_DOWN
        sta segmentVerticalDir,y

        lda #SEGMENT_FACING_RIGHT
        sta segmentFacing,y

        lda tileScreenOffset,x
        sec
        sbc #3
        sta segmentScreenOffsets,y

        lda #0
        sta segmentScreenShifts,y

        txa
        sta segmentTileOffsetsUL,y
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsLL,y
        sta segmentTileOffsetsLR,y
        
        inc numSegments

        rtl
        
        
addHeadSegment entry
        lda #SEGMENT_MAX_NUM-1
        sec
        sbc numSegments
        asl a
        tax
        
        lda #SEGMENT_STATE_HEAD
        sta segmentStates,x
        
        txa
        asl a
        asl a
        asl a
        sta segmentPosOffset,x
        tay
        
        lda #SEGMENT_DIR_RIGHT
        sta segmentHorizontalDir,y
        
        lda #SEGMENT_DIR_DOWN
        sta segmentVerticalDir,y
        
        lda #SEGMENT_FACING_RIGHT
        sta segmentFacing,y
        
        lda tileScreenOffset,x
        sec
        sbc #3
        sta segmentScreenOffsets,y
        
        lda #0
        sta segmentScreenShifts,y
        
        txa
        sta segmentTileOffsetsUL,y
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsLL,y
        sta segmentTileOffsetsLR,y
        
        inc numSegments
        
        rtl
        

shootSegment entry
; Write this code...
        rtl


numSegments     dc i2'0'

; The method used to track a segments position and other details on the screen are a bit
; funky.  In order to have body segments follow a head segment, we keep information from
; the position of the head segment.  The segmentPosOffset gives an offset into the other
; larger arrays (97 words) which describes the position of the segment.  When a head is
; updated, the segmentPosOffset is decremented.  That way, the previous positions are
; still there and body segments after that can reference it.
;
; We need at least 96 of them because a slow moving head segment goes through 8 positions
; before it can be re-used by the next body segment.  If there are 12 segments max, we
; need (8*12) positions to ensure all segments can know where there position was and will
; be next.
;
; But I bump that count up to 97.  When the segmentPosOffset is 0, the next one to use is
; the last.  It is nice to assume that the previous position information is at (index + 2).
; That works all the time except when segmentPosOffset was 0 and now wraps around to 190
; or ((96 - 1) * 2).  When that happens, we copy the info from 0 to 192 or (96 *2).  That
; way the code can safely assume that the old position information is in fact always at.
; (index + 2).
segmentStates           dc 12i2'SEGMENT_STATE_NONE'
segmentPosOffset        dc 12i2'0'
segmentHorizontalDir    dc 97i2'SEGMENT_DIR_RIGHT'
segmentVerticalDir      dc 97i2'SEGMENT_DIR_DOWN'
segmentFacing           dc 97i2'SEGMENT_FACING_DOWN'
segmentScreenOffsets    dc 97i2'0'
segmentScreenShifts     dc 97i2'0'
segmentTileOffsetsUL    dc 97i2'0'
segmentTileOffsetsUR    dc 97i2'0'
segmentTileOffsetsLL    dc 97i2'0'
segmentTileOffsetsLR    dc 97i2'0'

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
