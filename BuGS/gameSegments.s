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
SEGMENT_STATE_EXPLODING     equ 1
SEGMENT_STATE_HEAD          equ 2
SEGMENT_STATE_POISONED_HEAD equ 3
SEGMENT_STATE_BODY          equ 4

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

SEGMENT_MAX_POSITION_OFFSET     equ TILE_PIXEL_WIDTH*SEGMENT_MAX_NUM*2-2

; The code uses segmentPixelOffset and the segment speed to figure out whether to draw the shifted sprite
; or the regular sprite.  By AND-ing with the speed, if the result is 0, then we want a non-shifted sprite.
; If the result is non-zero, we want a shifted sprite.  Then, we just need a per segment speed instead of a
; per position offset screen shift.  Similarly, the same result can be used to figure out whether we need
; to increment/decrement the screen offset when updating segment position.
SEGMENT_SPEED_FAST      equ 0
SEGMENT_SPEED_SLOW      equ 1
        
        
drawSegments entry
        ldx #SEGMENT_MAX_OFFSET
drawSegments_nextSegment anop
        lda segmentStates,x
        bne drawSegments_cont
        jmp drawSegments_skipSegment

drawSegments_cont anop
        phx
		cmp #SEGMENT_STATE_EXPLODING
		beq drawSegments_exploding
        cmp #SEGMENT_STATE_BODY
        bne drawSegments_head
        jsl segmentBodyJump
        bra drawSegments_handleTiles
		
drawSegments_exploding anop
		jsl segmentExplodingJump
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
      
segmentExplodingJump entry
		lda segmentPosOffset,x
		tax
		ldy segmentFacing,x
		lda explosionJumpTable,y
		sta segmentExplodingJump_jumpInst+1
		lda explosionJumpTable+2,y
		sta segmentExplodingJump_jumpInst+3
		ldy segmentScreenOffsets,x
		
segmentExplodingJump_jumpInst anop
		jmp >leftHead1
		nop
        
segmentHeadJump entry
        lda segmentPixelOffset
        and segmentSpeed,x
        tay
        
        lda segmentPosOffset,x
        tax
        
        lda segmentFacing,x
        clc
        adc segmentSpriteOffset
        
        cpy #0
        beq segmentHeadJump_noShift
        
        tay
        lda headShiftJumpTable,y
        sta segmentHeadJump_jumpInst+1
        lda headShiftJumpTable+2,y
        sta segmentHeadJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        bra segmentHeadJump_jumpInst
        
segmentHeadJump_noShift anop
        tay
        lda headJumpTable,y
        sta segmentHeadJump_jumpInst+1
        lda headJumpTable+2,y
        sta segmentHeadJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        
segmentHeadJump_jumpInst anop
        jmp >leftHead1
        nop
        
segmentBodyJump entry
        lda segmentPixelOffset
        and segmentSpeed,x
        tay
        
        lda segmentPosOffset,x
        tax
        
        lda segmentFacing,x
        clc
        adc segmentSpriteOffset
        
        cpy #0
        beq segmentBodyJump_noShift
        
        tay
        lda bodyShiftJumpTable,y
        sta segmentBodyJump_jumpInst+1
        lda bodyShiftJumpTable+2,y
        sta segmentBodyJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        bra segmentBodyJump_jumpInst
        
segmentBodyJump_noShift anop
        tay
        lda bodyJumpTable,y
        sta segmentBodyJump_jumpInst+1
        lda bodyJumpTable+2,y
        sta segmentBodyJump_jumpInst+3
        
        ldy segmentScreenOffsets,x
        
segmentBodyJump_jumpInst anop
        jmp >leftHead1
        nop
        
updateSegments entry
; Clear the segment mask to start.
		stz segmentTileMask+0
		stz segmentTileMask+2
		stz segmentTileMask+4
		stz segmentTileMask+6
		stz segmentTileMask+8
		stz segmentTileMask+10
		stz segmentTileMask+12
		stz segmentTileMask+14
		stz segmentTileMask+16
		stz segmentTileMask+18
		stz segmentTileMask+20
		stz segmentTileMask+22
		stz segmentTileMask+24
		stz segmentTileMask+26
		stz segmentTileMask+28
		stz segmentTileMask+30
		stz segmentTileMask+32
		stz segmentTileMask+34
		stz segmentTileMask+36
		stz segmentTileMask+38
		stz segmentTileMask+40
		stz segmentTileMask+42
		stz segmentTileMask+44
		stz segmentTileMask+46
		stz segmentTileMask+48
		stz segmentTileMask+50
		stz segmentTileMask+52
		stz segmentTileMask+54
		stz segmentTileMask+56
		stz segmentTileMask+58
		stz segmentTileMask+60
		stz segmentTileMask+62
		stz segmentTileMask+64
		stz segmentTileMask+66
		stz segmentTileMask+78
		stz segmentTileMask+70
		stz segmentTileMask+72
		stz segmentTileMask+74
		stz segmentTileMask+76
		stz segmentTileMask+78

        lda segmentPixelOffset
        inc a
        and #TILE_PIXEL_WIDTH-1
        sta segmentPixelOffset
        and #1
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
		lda #SEGMENT_MAX_OFFSET+2
		sta segmentEmptyOffset
        ldx #SEGMENT_MAX_OFFSET
updateSegments_nextSegment anop
        lda segmentStates,x
        bne updateSegments_cont
		stx segmentEmptyOffset
		lda segmentPosOffset,x
		beq updateSegments_emptyWrapPos
		dec a
		dec a
		sta segmentPosOffset,x
        jmp updateSegments_skipSegment
updateSegments_emptyWrapPos anop
		lda #SEGMENT_MAX_POSITION_OFFSET
		sta segmentPosOffset,x
		jmp updateSegments_skipSegment
updateSegments_cont anop
        cmp #SEGMENT_STATE_BODY
        bne updateSegments_headOrExploding
        
        lda segmentPosOffset,x
        beq updateSegments_bodyWrapPos
        dec a
        dec a
        sta segmentPosOffset,x
        bra updateSegments_bodyMarkTile
updateSegments_bodyWrapPos anop
        lda #SEGMENT_MAX_POSITION_OFFSET
        sta segmentPosOffset,x
updateSegments_bodyMarkTile anop
		phx
		tay
		ldx segmentCurrentTile,y
		ldy tileBitOffset,x
		lda tileBitMask,x
		ora segmentTileMask,y
		sta segmentTileMask,y
		plx
        jmp updateSegments_skipSegment

updateSegments_headOrExploding anop
        lda segmentPosOffset,x
        beq updateSegments_headWrapPos
        dec a
        dec a
        sta segmentPosOffset,x
        tay
        jmp updateSegments_headNoWrap
        
updateSegments_headWrapPos anop
        lda #SEGMENT_MAX_POSITION_OFFSET
        sta segmentPosOffset,x
        tay
; Copy the 0th position entry to the SEGMENT_POSITION_OFFSET_SPARE(th) entry.
; That way, Y points to the new entry for the head and Y+2 always points to
; the previous entry, even on a wrap around.
        lda segmentHorizontalDir
        sta segmentHorizontalDir+SEGMENT_MAX_POSITION_OFFSET
        lda segmentVerticalDir
        sta segmentVerticalDir+SEGMENT_MAX_POSITION_OFFSET
        lda segmentScreenOffsets
        sta segmentScreenOffsets+SEGMENT_MAX_POSITION_OFFSET
        lda segmentTileOffsetsUL
        sta segmentTileOffsetsUL+SEGMENT_MAX_POSITION_OFFSET
        lda segmentTileOffsetsUR
        sta segmentTileOffsetsUR+SEGMENT_MAX_POSITION_OFFSET
        lda segmentTileOffsetsLL
        sta segmentTileOffsetsLL+SEGMENT_MAX_POSITION_OFFSET
        lda segmentTileOffsetsLR
        sta segmentTileOffsetsLR+SEGMENT_MAX_POSITION_OFFSET
		lda segmentCurrentTile
		sta segmentCurrentTile+SEGMENT_MAX_POSITION_OFFSET
        
; We could be in exploding state and if so, we want to skip the rest of the
; code for update head segments.
		lda segmentStates,x
		cmp #SEGMENT_STATE_EXPLODING
		bne updateSegments_notExplodingWrap
		jsr updateSegmentExplodingWrap
		bra updateSegments_skipSegment
updateSegments_notExplodingWrap anop
; Important - Do facing last because we use that to index into the jump
; table for update.
        lda segmentFacing
        sta segmentFacing+SEGMENT_MAX_POSITION_OFFSET
        bra updateSegments_headCont
        
updateSegments_headNoWrap anop
; Assume no change in any of the data for now and just copy it into place.
        lda segmentHorizontalDir+2,y
        sta segmentHorizontalDir,y
        lda segmentVerticalDir+2,y
        sta segmentVerticalDir,y
        lda segmentScreenOffsets+2,y
        sta segmentScreenOffsets,y
        lda segmentTileOffsetsUL+2,y
        sta segmentTileOffsetsUL,y
        lda segmentTileOffsetsUR+2,y
        sta segmentTileOffsetsUR,y
        lda segmentTileOffsetsLL+2,y
        sta segmentTileOffsetsLL,y
        lda segmentTileOffsetsLR+2,y
        sta segmentTileOffsetsLR,y
		lda segmentCurrentTile+2,y
		sta segmentCurrentTile,y
		
; We could be in exploding state and if so, we want to skip the rest of the
; code for update head segments.
		lda segmentStates,x
		cmp #SEGMENT_STATE_EXPLODING
		bne updateSegments_notExplodingNoWrap
		jsr updateSegmentExplodingNoWrap
		bra updateSegments_skipSegment
updateSegments_notExplodingNoWrap anop
; Important - Do facing last because we use that to index into the jump
; table for update.
        lda segmentFacing+2,y
        sta segmentFacing,y
        
updateSegments_headCont anop
; This is funky.  Each "facing" value is in increments of 32 to make figuring out where
; the sprite callback is easy but it makes this update callback harder.  We divide by
; 16 to get values incrementing by 2's.  Then, we or in the speed.  The speed is 0 or 1
; so now we have values incrementing by 1 each with a unique pair of facing and speed.
; Then we multiply by two again so we have unique values incrementing by 2 and that is
; used as an index into the jump table.  That way, we jump to a subroutine which is
; unique for each facing/speed pair.
        lsr a
        lsr a
        lsr a
        lsr a
        ora segmentSpeed,x
        asl a
        stx segmentBeingUpdated
        tax
        jsr (segmentUpdateJumpTable,x)
		ldx segmentCurrentTile,y
		ldy tileBitOffset,x
		lda tileBitMask,x
		ora segmentTileMask,y
		sta segmentTileMask,y
		ldx segmentBeingUpdated
updateSegments_skipSegment anop
        dex
        dex
        bmi updateSegments_maybeAdd
        jmp updateSegments_nextSegment
updateSegments_maybeAdd anop
		lda segmentsAddEnabled
		bne updateSegments_done
		lda segmentEmptyOffset
		cmp #SEGMENT_MAX_OFFSET+2
		bge updateSegments_done
		lda numSegments
		beq updateSegments_done
		cmp #SEGMENT_MAX_NUM
		bge updateSegments_done
		lda segmentPixelOffset
		and #3
		cmp #1
		bne updateSegments_done
		jsl rand0_to_65534
		and #31
		bne updateSegments_done
		jmp updateSegmentAddSegment
updateSegments_done anop
        rtl

updateSegmentAddSegment entry
		inc numSegments
		ldx segmentEmptyOffset
		
		lda #SEGMENT_STATE_HEAD
		sta segmentStates,x
		
		lda #SEGMENT_SPEED_FAST
		sta segmentSpeed,x
		
		ldy segmentPosOffset,x
		
		lda #SEGMENT_DIR_DOWN
		sta segmentVerticalDir,y
		
		jsl rand0_to_65534
		and #$0080
		beq updateSegmentAddSegment_leftSide
		
		lda #SEGMENT_DIR_LEFT
		sta segmentHorizontalDir,y
		
		lda #SEGMENT_FACING_LEFT
		sta segmentFacing,y
		
		ldx #((GAME_NUM_TILES_WIDE*(GAME_NUM_TILES_TALL-6))-1)*SIZEOF_TILE_INFO
		
		lda tileScreenOffset,x
		sta segmentScreenOffsets,y
		
		txa
		sta segmentTileOffsetsUL,y
		sta segmentTileOffsetsLL,y
		sta segmentCurrentTile,y
		lda tileRight,x
		sta segmentTileOffsetsUR,y
		sta segmentTileOffsetsLR,y
		rtl
		
updateSegmentAddSegment_leftSide anop
		lda #SEGMENT_DIR_RIGHT
		sta segmentHorizontalDir,y

		lda #SEGMENT_FACING_RIGHT
		sta segmentFacing,y

		ldx #(GAME_NUM_TILES_WIDE*(GAME_NUM_TILES_TALL-7))*SIZEOF_TILE_INFO
		lda tileScreenOffset,x
		sec
		sbc #6
		sta segmentScreenOffsets,y
		
		txa
		sta segmentTileOffsetsUR,y
		sta segmentTileOffsetsLR,y
		sta segmentCurrentTile,y
		lda tileLeft,x
		sta segmentTileOffsetsUL,y
		sta segmentTileOffsetsLL,y
		rtl
		
updateSegmentExplodingNoWrap entry
		lda segmentFacing+2,y
		bra updateSegmentExploding_common
		
updateSegmentExplodingWrap	entry
		lda segmentFacing
updateSegmentExploding_common anop
		beq updateSegmentExploding_done
		sec
		sbc #$4
		sta segmentFacing,y
		rts
		
updateSegmentExploding_done anop
		lda #SEGMENT_STATE_NONE
		sta segmentStates,x
		rts
        

updateSegmentLeftFast entry
        tyx
        dec segmentScreenOffsets,x

        lda segmentPixelOffset
        and #3
        bne updateSegmentLeftFast_nextOffset
        lda segmentTileOffsetsUL,y
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
		rts
        
updateSegmentLeftFast_nextOffset anop
        cmp #1
        bne updateSegmentLeftFast_nextOffset2
        
        lda segmentTileOffsetsUL,y
        tax
        lda tileLeft,x
        sta segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
		sta segmentCurrentTile,y
		rts

updateSegmentLeftFast_nextOffset2 anop
        cmp #3
        beq updateSegmentLeftFast_checkDir
		rts

updateSegmentLeftFast_checkDir anop
        ldx segmentBeingUpdated
        lda segmentStates,x
        cmp #SEGMENT_STATE_POISONED_HEAD
        beq updateSegmentLeftFast_changeDir
        ldx segmentTileOffsetsUL,y
		cpx #LHS_FIRST_TILE_OFFSET
		bge updateSegmentLeftFast_changeDir
		lda tileType,x
		bne updateSegmentLeftFast_checkPoison
        lda tileLeft,x
        cmp #LHS_FIRST_TILE_OFFSET
        bge updateSegmentLeftFast_changeDir
        tax
        lda tileType,x
        bne updateSegmentLeftFast_checkPoison
		phy
		txy
        ldx tileBitOffset,y
		lda tileBitMask,y
		ply
		and segmentTileMask,x
		bne updateSegmentLeftFast_changeDir
		rts
updateSegmentLeftFast_checkPoison anop
        cmp #TILE_POISON_MUSHROOM1
        blt updateSegmentLeftFast_changeDir
        ldx segmentBeingUpdated
        lda #SEGMENT_STATE_POISONED_HEAD
        sta segmentStates,x
        
updateSegmentLeftFast_changeDir anop
        lda #SEGMENT_FACING_DOWN_LEFT
        sta segmentFacing,y
        lda #SEGMENT_DIR_RIGHT
        sta segmentHorizontalDir,y
        lda segmentVerticalDir,y
        beq updateSegmentLeftFast_dirDown

        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-5*GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        bge updateSegmentLeftFast_doUp
        lda #SEGMENT_DIR_DOWN
        sta segmentVerticalDir,y
        bra updateSegmentLeftFast_doDown

updateSegmentLeftFast_doUp anop
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW*2
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsLR,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUR,y
        
        lda segmentTileOffsetsLL,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUL,y
		sta segmentCurrentTile,y
        rts
        
updateSegmentLeftFast_dirDown anop
        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        blt updateSegmentLeftFast_doDown
; If the head segment was poisoned, it is no longer poisoned once the head is going up again.
		lda #SEGMENT_DIR_UP
		sta segmentVerticalDir,y
        ldx segmentBeingUpdated
		lda segmentStates,x
		cmp #SEGMENT_STATE_HEAD
		beq updateSegmentLeftFast_notPoisoned
        lda #SEGMENT_STATE_HEAD
        sta segmentStates,x
        bra updateSegmentLeftFast_doUp
updateSegmentLeftFast_notPoisoned anop
		stz segmentsAddEnabled
		bra updateSegmentLeftFast_doUp
        
updateSegmentLeftFast_doDown anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW*2
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsUR,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLR,y
        
        lda segmentTileOffsetsUL,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLL,y
		sta segmentCurrentTile,y
        rts

        
updateSegmentLeftSlow entry
        lda #1
        and segmentPixelOffset
        beq updateSegmentLeftSlow_skipDec
        tyx
        dec segmentScreenOffsets,x

updateSegmentLeftSlow_skipDec anop
        lda segmentPixelOffset
        bne updateSegmentLeftSlow_nextOffset
        lda segmentTileOffsetsUL,y
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
		lda numSegments
		cmp #1
		beq updateSegmentsLeftSlow_lastSegment
        rts
updateSegmentsLeftSlow_lastSegment anop
		ldx segmentBeingUpdated
		lda #SEGMENT_SPEED_FAST
		sta segmentSpeed,x
		rts
        
updateSegmentLeftSlow_nextOffset anop
        cmp #1
        bne updateSegmentLeftSlow_nextOffset2
        
        lda segmentTileOffsetsUL,y
        tax
        lda tileLeft,x
        sta segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
		sta segmentCurrentTile,y
		rts

updateSegmentLeftSlow_nextOffset2 anop
        cmp #5
        beq updateSegmentLeftSlow_checkDir
        rts

updateSegmentLeftSlow_checkDir anop
        ldx segmentBeingUpdated
        lda segmentStates,x
        cmp #SEGMENT_STATE_POISONED_HEAD
        beq updateSegmentLeftSlow_changeDir
        ldx segmentTileOffsetsUL,y
		cpx #LHS_FIRST_TILE_OFFSET
		bge updateSegmentLeftSlow_changeDir
		lda tileType,x
		bne updateSegmentLeftSlow_checkPoison
        lda tileLeft,x
        cmp #LHS_FIRST_TILE_OFFSET
        bge updateSegmentLeftSlow_changeDir
        tax
        lda tileType,x
        bne updateSegmentLeftSlow_checkPoison
		phy
		txy
		ldx tileBitOffset,y
		lda tileBitMask,y
		ply
		and segmentTileMask,x
		bne updateSegmentLeftSlow_changeDir
        rts
updateSegmentLeftSlow_checkPoison anop
        cmp #TILE_POISON_MUSHROOM1
        blt updateSegmentLeftSlow_changeDir
        ldx segmentBeingUpdated
        lda #SEGMENT_STATE_POISONED_HEAD
        sta segmentStates,x

updateSegmentLeftSlow_changeDir anop
        lda #SEGMENT_FACING_DOWN_LEFT
        sta segmentFacing,y
        lda #SEGMENT_DIR_RIGHT
        sta segmentHorizontalDir,y
        lda segmentVerticalDir,y
        beq updateSegmentLeftSlow_dirDown

        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-5*GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        bge updateSegmentLeftSlow_doUp
        lda #SEGMENT_DIR_DOWN
        sta segmentVerticalDir,y
        bra updateSegmentLeftSlow_doDown

updateSegmentLeftSlow_doUp anop
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsLR,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUR,y
        
        lda segmentTileOffsetsLL,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUL,y
		sta segmentCurrentTile,y
        rts
        
updateSegmentLeftSlow_dirDown anop
        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        blt updateSegmentLeftSlow_doDown
; If the head segment was poisoned, it is no longer poisoned once the head is going up again.
		lda #SEGMENT_DIR_UP
		sta segmentVerticalDir,y
        ldx segmentBeingUpdated
		lda segmentStates,x
		cmp #SEGMENT_STATE_HEAD
		beq updateSegmentLeftSlow_notPoisoned
        lda #SEGMENT_STATE_HEAD
        sta segmentStates,x
        bra updateSegmentLeftSlow_doUp
updateSegmentLeftSlow_notPoisoned anop
		stz segmentsAddEnabled
		bra updateSegmentLeftSlow_doUp
        
updateSegmentLeftSlow_doDown anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsUR,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLR,y
        
        lda segmentTileOffsetsUL,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLL,y
		sta segmentCurrentTile,y
        rts
        
        
updateSegmentDownLeftFast entry
		lda segmentScreenOffsets,y
		cmp #$2000-(7*SCREEN_BYTES_PER_ROW)
		bge updateSegmentDownLeftFast_notOffscreen
		lda segmentPixelOffset
		cmp #7
		beq updateSegmentDownLeftFast_moveOnScreen
		rts

updateSegmentDownLeftFast_moveOnScreen anop
		lda segmentScreenOffsets,y
		clc
		adc #2*SCREEN_BYTES_PER_ROW
		sta segmentScreenOffsets,y
		rts

updateSegmentDownLeftFast_notOffscreen anop
        lda segmentVerticalDir,y
        beq updateSegmentDownLeftFast_down
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW*2+1
        bra updateSegmentDownLeftFast_cont
        
updateSegmentDownLeftFast_down anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW*2-1
        
updateSegmentDownLeftFast_cont anop
        sta segmentScreenOffsets,y
        
        lda segmentPixelOffset
        and #3
        beq updateSegmentDownLeftFast_nextOffset
        
        lda #SEGMENT_FACING_LEFT
        sta segmentFacing,y
        lda segmentVerticalDir,y
        beq updateSegmentDownLeftFast_tilesDown
        
        lda segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
        lda segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
		rts
        
updateSegmentDownLeftFast_tilesDown anop
        lda segmentTileOffsetsLL,y
        sta segmentTileOffsetsUL,y
        lda segmentTileOffsetsLR,y
        sta segmentTileOffsetsUR,y
        rts
        
updateSegmentDownLeftFast_nextOffset anop
        lda #SEGMENT_FACING_DOWN
        sta segmentFacing,y
        rts
        
        
updateSegmentDownLeftSlow entry
        lda segmentScreenOffsets,y
        tax
        lda #1
        and segmentPixelOffset
        beq updateSegmentDownLeftSlow_skipDec
        dex

updateSegmentDownLeftSlow_skipDec anop
        lda segmentVerticalDir,y
        beq updateSegmentDownLeftSlow_down
        txa
        sec
        sbc #SCREEN_BYTES_PER_ROW
        bra updateSegmentDownLeftSlow_cont
        
updateSegmentDownLeftSlow_down anop
        txa
        clc
        adc #SCREEN_BYTES_PER_ROW
        
updateSegmentDownLeftSlow_cont anop
        sta segmentScreenOffsets,y
        
        lda segmentPixelOffset
        cmp #4
        bne updateSegmentDownLeftSlow_nextOffset
        
        lda #SEGMENT_FACING_LEFT
        sta segmentFacing,y
        lda segmentVerticalDir,y
        beq updateSegmentDownLeftSlow_tilesDown
        
        lda segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
        lda segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
        rts
        
updateSegmentDownLeftSlow_tilesDown anop
        lda segmentTileOffsetsLL,y
        sta segmentTileOffsetsUL,y
        lda segmentTileOffsetsLR,y
        sta segmentTileOffsetsUR,y
        rts
        
updateSegmentDownLeftSlow_nextOffset anop
        cmp #7
        bne updateSegmentDownLeftSlow_done
        lda #SEGMENT_FACING_DOWN
        sta segmentFacing,y
        
updateSegmentDownLeftSlow_done anop
        rts
      
      
updateSegmentDownFast entry
        lda segmentHorizontalDir,y
        beq updateSegmentDownFast_left
        
        lda #SEGMENT_FACING_DOWN_RIGHT
        sta segmentFacing,y
        lda segmentVerticalDir,y
        beq updateSegmentDownFast_downRight
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW*2-1
        bra updateSegmentDownFast_done
        
updateSegmentDownFast_downRight anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW*2+1
        bra updateSegmentDownFast_done
        
updateSegmentDownFast_left anop
        lda #SEGMENT_FACING_DOWN_LEFT
        sta segmentFacing,y
        lda segmentVerticalDir,y
        beq updateSegmentDownFast_downLeft
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW*2+1
        bra updateSegmentDownFast_done
        
updateSegmentDownFast_downLeft anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW*2-1
        
updateSegmentDownFast_done anop
        sta segmentScreenOffsets,y
        rts
      
      
updateSegmentDownSlow entry
        lda segmentVerticalDir,y
        beq updateSegmentDownSlow_down
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW
        bra updateSegmentDownSlow_cont
        
updateSegmentDownSlow_down anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW
        
updateSegmentDownSlow_cont anop
        sta segmentScreenOffsets,y

        lda segmentPixelOffset
        cmp #2
        bne updateSegmentDownSlow_done
        
        lda segmentHorizontalDir,y
        beq updateSegmentDownSlow_left
        
        lda #SEGMENT_FACING_DOWN_RIGHT
        sta segmentFacing,y
        tyx
        inc segmentScreenOffsets,x
        rts
        
updateSegmentDownSlow_left anop
        lda #SEGMENT_FACING_DOWN_LEFT
        sta segmentFacing,y
        tyx
        dec segmentScreenOffsets,x

updateSegmentDownSlow_done anop
        rts
 
 
updateSegmentDownRightFast entry
		lda segmentScreenOffsets,y
		cmp #$2000-(7*SCREEN_BYTES_PER_ROW)
		bge updateSegmentDownRightFast_notOffscreen
		lda segmentPixelOffset
		cmp #7
		beq updateSegmentDownRightFast_moveOnScreen
		rts

updateSegmentDownRightFast_moveOnScreen anop
		lda segmentScreenOffsets,y
		clc
		adc #2*SCREEN_BYTES_PER_ROW
		sta segmentScreenOffsets,y
		rts

updateSegmentDownRightFast_notOffscreen anop
        lda segmentVerticalDir,y
        beq updateSegmentDownRightFast_down
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW*2-1
        bra updateSegmentDownRightFast_cont
        
updateSegmentDownRightFast_down anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW*2+1
        
updateSegmentDownRightFast_cont anop
        sta segmentScreenOffsets,y
        
        lda segmentPixelOffset
        and #3
        beq updateSegmentDownRightFast_nextOffset
        
        lda #SEGMENT_FACING_RIGHT
        sta segmentFacing,y
        lda segmentVerticalDir,y
        beq updateSegmentDownRightFast_tilesDown
        
        lda segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
        lda segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
        rts
        
updateSegmentDownRightFast_tilesDown anop
        lda segmentTileOffsetsLL,y
        sta segmentTileOffsetsUL,y
        lda segmentTileOffsetsLR,y
        sta segmentTileOffsetsUR,y
        rts
        
updateSegmentDownRightFast_nextOffset anop
        lda #SEGMENT_FACING_DOWN
        sta segmentFacing,y
        rts
        
        
updateSegmentDownRightSlow entry
        lda segmentScreenOffsets,y
        tax
        lda #1
        and segmentPixelOffset
        beq updateSegmentDownRightSlow_skipInc
        inx

updateSegmentDownRightSlow_skipInc anop
        lda segmentVerticalDir,y
        beq updateSegmentDownRightSlow_down
        txa
        sec
        sbc #SCREEN_BYTES_PER_ROW
        bra updateSegmentDownRightSlow_cont
        
updateSegmentDownRightSlow_down anop
        txa
        clc
        adc #SCREEN_BYTES_PER_ROW
        
updateSegmentDownRightSlow_cont anop
        sta segmentScreenOffsets,y
        
        lda segmentPixelOffset
        cmp #4
        bne updateSegmentDownRightSlow_nextOffset
        
        lda #SEGMENT_FACING_RIGHT
        sta segmentFacing,y
        lda segmentVerticalDir,y
        beq updateSegmentDownRightSlow_tilesDown
        
        lda segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
        lda segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
        rts
        
updateSegmentDownRightSlow_tilesDown anop
        lda segmentTileOffsetsLL,y
        sta segmentTileOffsetsUL,y
        lda segmentTileOffsetsLR,y
        sta segmentTileOffsetsUR,y
        rts
        
updateSegmentDownRightSlow_nextOffset anop
        cmp #7
        bne updateSegmentDownRightSlow_done
        lda #SEGMENT_FACING_DOWN
        sta segmentFacing,y
        
updateSegmentDownRightSlow_done anop
        rts

                
updateSegmentRightFast entry
        tyx
        inc segmentScreenOffsets,x
        
        lda segmentPixelOffset
        and #3
        bne updateSegmentRightFast_nextOffset
        lda segmentTileOffsetsUR,y
        sta segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
        rts
        
updateSegmentRightFast_nextOffset anop
        cmp #1
        bne updateSegmentRightFast_nextOffset2
        
        lda segmentTileOffsetsUR,y
        tax
        lda tileRight,x
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
		sta segmentCurrentTile,y
        
updateSegmentRightFast_nextOffset2 anop
        cmp #3
        beq updateSegmentRightFast_checkDir
        rts
        
updateSegmentRightFast_checkDir anop
        ldx segmentBeingUpdated
        lda segmentStates,x
        cmp #SEGMENT_STATE_POISONED_HEAD
        beq updateSegmentRightFast_changeDir
        ldx segmentTileOffsetsUR,y
		cpx #RHS_FIRST_TILE_OFFSET
		bge updateSegmentRightFast_changeDir
		lda tileType,x
		bne updateSegmentRightFast_checkPoison
        lda tileRight,x
        cmp #RHS_FIRST_TILE_OFFSET
        bge updateSegmentRightFast_changeDir
        tax
        lda tileType,x
        bne updateSegmentRightFast_checkPoison
		phy
		txy
		ldx tileBitOffset,y
		lda tileBitMask,y
		ply
		and segmentTileMask,x
		bne updateSegmentRightFast_changeDir
        rts
updateSegmentRightFast_checkPoison anop
        cmp #TILE_POISON_MUSHROOM1
        blt updateSegmentRightFast_changeDir
        ldx segmentBeingUpdated
        lda #SEGMENT_STATE_POISONED_HEAD
        sta segmentStates,x

updateSegmentRightFast_changeDir anop
        lda #SEGMENT_FACING_DOWN_RIGHT
        sta segmentFacing,y
        lda #SEGMENT_DIR_LEFT
        sta segmentHorizontalDir,y
        lda segmentVerticalDir,y
        beq updateSegmentRightFast_dirDown

        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-5*GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        bge updateSegmentRightFast_doUp
        lda #SEGMENT_DIR_DOWN
        sta segmentVerticalDir,y
        bra updateSegmentRightFast_doDown

updateSegmentRightFast_doUp anop
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW*2
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsLR,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUR,y
		sta segmentCurrentTile,y
        
        lda segmentTileOffsetsLL,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUL,y
        rts
        
updateSegmentRightFast_dirDown anop
        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        blt updateSegmentRightFast_doDown
; If the head segment was poisoned, it is no longer poisoned once the head is going up again.
		lda #SEGMENT_DIR_UP
		sta segmentVerticalDir,y
        ldx segmentBeingUpdated
		lda segmentStates,x
		cmp #SEGMENT_STATE_HEAD
		beq updateSegmentRightFast_notPoisoned
        lda #SEGMENT_STATE_HEAD
        sta segmentStates,x
        bra updateSegmentRightFast_doUp
updateSegmentRightFast_notPoisoned anop
		stz segmentsAddEnabled
		bra updateSegmentRightFast_doUp
        
updateSegmentRightFast_doDown anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW*2
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsUR,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLR,y
		sta segmentCurrentTile,y
        
        lda segmentTileOffsetsUL,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLL,y
        rts
        

updateSegmentRightSlow entry
        lda #1
        and segmentPixelOffset
        beq updateSegmentRightSlow_skipInc
        tyx
        inc segmentScreenOffsets,x

updateSegmentRightSlow_skipInc anop
        lda segmentPixelOffset
        bne updateSegmentRightSlow_nextOffset
        lda segmentTileOffsetsUR,y
        sta segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
        rts
        
updateSegmentRightSlow_nextOffset anop
        cmp #1
        bne updateSegmentRightSlow_nextOffset2
        
        lda segmentTileOffsetsUR,y
        tax
        lda tileRight,x
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
		sta segmentCurrentTile,y
		lda numSegments
		cmp #1
		beq updateSegmentsRightSlow_lastSegment
		rts
updateSegmentsRightSlow_lastSegment anop
		ldx segmentBeingUpdated
		lda #SEGMENT_SPEED_FAST
		sta segmentSpeed,x
		rts

updateSegmentRightSlow_nextOffset2 anop
        cmp #5
        beq updateSegmentRightSlow_checkDir
        rts

updateSegmentRightSlow_checkDir anop
        ldx segmentBeingUpdated
        lda segmentStates,x
        cmp #SEGMENT_STATE_POISONED_HEAD
        beq updateSegmentRightSlow_changeDir
        ldx segmentTileOffsetsUR,y
		cpx #RHS_FIRST_TILE_OFFSET
		bge updateSegmentRightSlow_changeDir
		lda tileType,x
		bne updateSegmentRightSlow_checkPoison
        lda tileRight,x
        cmp #RHS_FIRST_TILE_OFFSET
        bge updateSegmentRightSlow_changeDir
        tax
        lda tileType,x
        bne updateSegmentRightSlow_checkPoison
		phy
		txy
		ldx tileBitOffset,y
		lda tileBitMask,y
		ply
		and segmentTileMask,x
		bne updateSegmentRightSlow_changeDir
        rts
updateSegmentRightSlow_checkPoison anop
        cmp #TILE_POISON_MUSHROOM1
        blt updateSegmentRightSlow_changeDir
        ldx segmentBeingUpdated
        lda #SEGMENT_STATE_POISONED_HEAD
        sta segmentStates,x

updateSegmentRightSlow_changeDir anop
        lda #SEGMENT_FACING_DOWN_RIGHT
        sta segmentFacing,y
        lda #SEGMENT_DIR_LEFT
        sta segmentHorizontalDir,y
        lda segmentVerticalDir,y
        beq updateSegmentRightSlow_dirDown

        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-5*GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        bge updateSegmentRightSlow_doUp
        lda #SEGMENT_DIR_DOWN
        sta segmentVerticalDir,y
        bra updateSegmentRightSlow_doDown

updateSegmentRightSlow_doUp anop
        lda segmentScreenOffsets,y
        sec
        sbc #SCREEN_BYTES_PER_ROW
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsLR,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUR,y
		sta segmentCurrentTile,y
        
        lda segmentTileOffsetsLL,y
        tax
        lda tileAbove,x
        sta segmentTileOffsetsUL,y
        rts
        
updateSegmentRightSlow_dirDown anop
        lda segmentTileOffsetsUR,y
        cmp #(NUM_GAME_TILES-GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
        blt updateSegmentRightSlow_doDown
; If the head segment was poisoned, it is no longer poisoned once the head is going up again.
		lda #SEGMENT_DIR_UP
		sta segmentVerticalDir,y
		ldx segmentBeingUpdated
		lda segmentStates,x
		cmp #SEGMENT_STATE_HEAD
		beq updateSegmentRightSlow_notPoisoned
        lda #SEGMENT_STATE_HEAD
        sta segmentStates,x
		bra updateSegmentRightSlow_doUp
updateSegmentRightSlow_notPoisoned anop
		stz segmentsAddEnabled
        bra updateSegmentRightSlow_doUp
        
updateSegmentRightSlow_doDown anop
        lda segmentScreenOffsets,y
        clc
        adc #SCREEN_BYTES_PER_ROW
        sta segmentScreenOffsets,y
        
        lda segmentTileOffsetsUR,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLR,y
		sta segmentCurrentTile,y
        
        lda segmentTileOffsetsUL,y
        tax
        lda tileBelow,x
        sta segmentTileOffsetsLL,y
        rts
        

addBodySegment entry
        lda numSegments
        asl a
        tax
        
        inc numSegments

        lda #SEGMENT_STATE_BODY
        sta segmentStates,x
        
        lda segmentSpeed-2,x
        sta segmentSpeed,x
        
        beq addBodySegment_fast
        jmp addBodySegment_slow

addBodySegment_fast anop
        lda segmentPosOffset-2,x
        clc
        adc #8
        sta segmentPosOffset,x
        tay

        lda segmentHorizontalDir-8,y
        sta segmentHorizontalDir-6,y
        sta segmentHorizontalDir-4,y
        sta segmentHorizontalDir-2,y
        sta segmentHorizontalDir,y
        
        lda segmentVerticalDir-8,y
        sta segmentVerticalDir-6,y
        sta segmentVerticalDir-4,y
        sta segmentVerticalDir-2,y
        sta segmentVerticalDir,y
        
        lda segmentFacing-8,y
        sta segmentFacing-6,y
        sta segmentFacing-4,y
        sta segmentFacing-2,y
        sta segmentFacing,y

        lda tileScreenOffset
        sec
        sbc #SCREEN_BYTES_PER_ROW*8
        sta segmentScreenOffsets-6,y
        sta segmentScreenOffsets-4,y
        sta segmentScreenOffsets-2,y
        sta segmentScreenOffsets,y

        lda segmentTileOffsetsUL-8,y
        sta segmentTileOffsetsUL-6,y
        sta segmentTileOffsetsUL-4,y
        sta segmentTileOffsetsUL-2,y
        sta segmentTileOffsetsUL,y
        
        lda segmentTileOffsetsUR-8,y
        sta segmentTileOffsetsUR-6,y
        sta segmentTileOffsetsUR-4,y
        sta segmentTileOffsetsUR-2,y
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsUR,y
        
        lda segmentTileOffsetsLL-8,y
        sta segmentTileOffsetsLL-6,y
        sta segmentTileOffsetsLL-4,y
        sta segmentTileOffsetsLL-2,y
        sta segmentTileOffsetsLL,y
        
        lda segmentTileOffsetsLR-8,y
        sta segmentTileOffsetsLR-6,y
        sta segmentTileOffsetsLR-4,y
        sta segmentTileOffsetsLR-2,y
        sta segmentTileOffsetsLR,y

; This is a bit weird but we pretend the body segment is in the bottom RHS tile while it is offscreen.
; We have to put in a valid game tile here and it doesn't matter if body segments "collide".  But we
; don't want head segments to collide with a off-screen body segment.  Since the head segments always
; appear at the top, it is safe to just tuck the body segments away at the bottom RHS.
		lda #NUM_GAME_TILES-1
		sta segmentCurrentTile-6,y
		sta segmentCurrentTile-4,y
		sta segmentCurrentTile-2,y
		sta segmentCurrentTile,y

        rtl
addBodySegment_slow anop
        lda segmentPosOffset-2,x
        clc
        adc #16
        sta segmentPosOffset,x
        tay

        lda segmentHorizontalDir-16,y
        sta segmentHorizontalDir-14,y
        sta segmentHorizontalDir-12,y
        sta segmentHorizontalDir-10,y
        sta segmentHorizontalDir-8,y
        sta segmentHorizontalDir-6,y
        sta segmentHorizontalDir-4,y
        sta segmentHorizontalDir-2,y
        sta segmentHorizontalDir,y
        
        lda segmentVerticalDir-16,y
        sta segmentVerticalDir-14,y
        sta segmentVerticalDir-12,y
        sta segmentVerticalDir-10,y
        sta segmentVerticalDir-8,y
        sta segmentVerticalDir-6,y
        sta segmentVerticalDir-4,y
        sta segmentVerticalDir-2,y
        sta segmentVerticalDir,y
        
        lda segmentFacing-16,y
        sta segmentFacing-14,y
        sta segmentFacing-12,y
        sta segmentFacing-10,y
        sta segmentFacing-8,y
        sta segmentFacing-6,y
        sta segmentFacing-4,y
        sta segmentFacing-2,y
        sta segmentFacing,y

        lda tileScreenOffset
        sec
        sbc #SCREEN_BYTES_PER_ROW*8
        sta segmentScreenOffsets-14,y
        sta segmentScreenOffsets-12,y
        sta segmentScreenOffsets-10,y
        sta segmentScreenOffsets-8,y
        sta segmentScreenOffsets-6,y
        sta segmentScreenOffsets-4,y
        sta segmentScreenOffsets-2,y
        sta segmentScreenOffsets,y

        lda segmentTileOffsetsUL-16,y
        sta segmentTileOffsetsUL-14,y
        sta segmentTileOffsetsUL-12,y
        sta segmentTileOffsetsUL-10,y
        sta segmentTileOffsetsUL-8,y
        sta segmentTileOffsetsUL-6,y
        sta segmentTileOffsetsUL-4,y
        sta segmentTileOffsetsUL-2,y
        sta segmentTileOffsetsUL,y
        
        lda segmentTileOffsetsUR-16,y
        sta segmentTileOffsetsUR-14,y
        sta segmentTileOffsetsUR-12,y
        sta segmentTileOffsetsUR-10,y
        sta segmentTileOffsetsUR-8,y
        sta segmentTileOffsetsUR-6,y
        sta segmentTileOffsetsUR-4,y
        sta segmentTileOffsetsUR-2,y
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsUR,y
        
        lda segmentTileOffsetsLL-16,y
        sta segmentTileOffsetsLL-14,y
        sta segmentTileOffsetsLL-12,y
        sta segmentTileOffsetsLL-10,y
        sta segmentTileOffsetsLL-8,y
        sta segmentTileOffsetsLL-6,y
        sta segmentTileOffsetsLL-4,y
        sta segmentTileOffsetsLL-2,y
        sta segmentTileOffsetsLL,y
        
        lda segmentTileOffsetsLR-16,y
        sta segmentTileOffsetsLR-14,y
        sta segmentTileOffsetsLR-12,y
        sta segmentTileOffsetsLR-10,y
        sta segmentTileOffsetsLR-8,y
        sta segmentTileOffsetsLR-6,y
        sta segmentTileOffsetsLR-4,y
        sta segmentTileOffsetsLR-2,y
        sta segmentTileOffsetsLR,y
        sta segmentTileOffsetsLR,y

; See the comment above why we pretend the body segment is at the bottom RHS tile.
		lda #NUM_GAME_TILES-1
		sta segmentCurrentTile-14,y
		sta segmentCurrentTile-12,y
		sta segmentCurrentTile-10,y
		sta segmentCurrentTile-8,y
		sta segmentCurrentTile-6,y
		sta segmentCurrentTile-4,y
		sta segmentCurrentTile-2,y
		sta segmentCurrentTile,y

        rtl
        
        
addSlowHeadSegment entry
        lda numSegments
        asl a
        tax
        
        lda #SEGMENT_STATE_HEAD
        sta segmentStates,x
        
        lda #SEGMENT_SPEED_SLOW
        sta segmentSpeed,x
        
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
        
        lda #SEGMENT_FACING_DOWN_LEFT
        sta segmentFacing,y
        
		ldx #32
        lda tileScreenOffset,x
        sec
        sbc #SCREEN_BYTES_PER_ROW*7+2
        sta segmentScreenOffsets,y
        
        txa
        sta segmentTileOffsetsUL,y
        sta segmentTileOffsetsLL,y
		sta segmentCurrentTile,y
        lda tileRight,x
        sta segmentTileOffsetsUR,y
        sta segmentTileOffsetsLR,y
        
        inc numSegments
        lda #5
        sta segmentPixelOffset
		lda #1
		sta segmentsAddEnabled
        
        rtl


addFastHeadSegment entry
		lda numSegments
		asl a
		tax
		
		lda #SEGMENT_STATE_HEAD
		sta segmentStates,x
		
		lda #SEGMENT_SPEED_FAST
		sta segmentSpeed,x
		
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
		
		lda #SEGMENT_FACING_DOWN_LEFT
		sta segmentFacing,y

		ldx #16
		lda tileScreenOffset,x
		sec
		sbc #SCREEN_BYTES_PER_ROW*8+2
		sta segmentScreenOffsets,y
		
		txa
		sta segmentTileOffsetsUL,y
		sta segmentTileOffsetsLL,y
		sta segmentCurrentTile,y
		lda tileRight,x
		sta segmentTileOffsetsUR,y
		sta segmentTileOffsetsLR,y
		
		inc numSegments
		lda #5
		sta segmentPixelOffset
		lda #1
		sta segmentsAddEnabled
		
		rtl
        

; Call this with the segment num * 2 in the X register
shootSegment entry
		dec numSegments
		phx
		lda segmentStates,x
		cmp #SEGMENT_STATE_BODY
		beq shootSegment_body
		jsl scoreAddOneHundred
		bra shootSegment_doneScore
shootSegment_body anop
		jsl scoreAddTen
shootSegment_doneScore anop
		plx
		lda #SEGMENT_STATE_EXPLODING
		sta segmentStates,x
		ldy segmentPosOffset,x
		
; We take over the segmentFacing value when exploding to be an explosion sprite offset
		lda #EXPLOSION_LAST_OFFSET
		sta segmentFacing,y
		
		lda segmentCurrentTile,y
		cmp #(NUM_GAME_TILES-GAME_NUM_TILES_WIDE)*SIZEOF_TILE_INFO
		bge shootSegment_skipMushroom
		tay
		lda tileType,y
		beq shootSegment_normalMushroom
		cmp #TILE_POISON_MUSHROOM1
		bge shootSegment_poisonMushroom
shootSegment_normalMushroom anop
		lda #TILE_MUSHROOM4
		bra shootSegment_dirtyTile
shootSegment_poisonMushroom anop
		lda #TILE_POISON_MUSHROOM4
shootSegment_dirtyTile anop
		sta tileType,y
		lda #TILE_STATE_DIRTY
		sta tileDirty,y
shootSegment_skipMushroom anop
; If this is the last segment, then do not look for a following body segment
		cpx #22
		bge shootSegment_done
; If the segment after this is a body segment, then it is now a head segment
		lda segmentStates+2,x
		cmp #SEGMENT_STATE_BODY
		bne shootSegment_done
		lda #SEGMENT_STATE_HEAD
		sta segmentStates+2,x
shootSegment_done anop
        rtl
		
		
shootRandomSegment entry
		lda numSegments
		bne shootRandomSegment_hasSegments
		rtl
shootRandomSegment_hasSegments anop
		lda #12
		jsl randN
		asl a
		tax
		lda segmentStates,x
		cmp #SEGMENT_STATE_HEAD
		blt shootRandomSegment_hasSegments
		jmp shootSegment


numSegments     dc i2'0'
segmentsAddEnabled	dc i2'1'

; The method used to track a segments position and other details on the screen are a bit
; funky.  In order to have body segments follow a head segment, we keep information from
; the position of the head segment.  The segmentPosOffset gives an offset into the other
; larger arrays (96 words) which describes the position of the segment.  When a head is
; updated, the segmentPosOffset is decremented.  That way, the previous positions are
; still there and body segments after that can reference it.
;
; We need at least 96 of them because a slow moving head segment goes through 8 positions
; before it can be re-used by the next body segment.  If there are 12 segments max, we
; need (8*12) positions to ensure all segments can know where there position was and will
; be next.
segmentStates           dc 12i2'SEGMENT_STATE_NONE'
segmentSpeed            dc 12i2'SEGMENT_SPEED_SLOW'
segmentPosOffset        dc 12i2'0'
segmentHorizontalDir    dc 96i2'SEGMENT_DIR_RIGHT'
segmentVerticalDir      dc 96i2'SEGMENT_DIR_DOWN'
segmentFacing           dc 96i2'SEGMENT_FACING_DOWN'
segmentScreenOffsets    dc 96i2'0'
segmentTileOffsetsUL    dc 96i2'0'
segmentTileOffsetsUR    dc 96i2'0'
segmentTileOffsetsLL    dc 96i2'0'
segmentTileOffsetsLR    dc 96i2'0'
segmentCurrentTile      dc 96i2'0'

segmentTileMask         dc 40i2'0'

SEGMENT_SPRITE_LAST_OFFSET  gequ 7*4
segmentSpriteOffset dc i2'0'
segmentPixelOffset  dc i2'0'
segmentBeingUpdated dc i2'0'
segmentEmptyOffset 	dc i2'0'


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
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'
                    dc i4'rightDownHead1s'
                    dc i4'rightDownHead2s'


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
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'
                    dc i4'rightDownHead1'
                    dc i4'rightDownHead2'


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
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'
                    dc i4'rightDownBody1s'
                    dc i4'rightDownBody2s'


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
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'
                    dc i4'rightDownBody1'
                    dc i4'rightDownBody2'


; rightBodyShiftJumpTable
                    dc i4'rightBody5s'
                    dc i4'rightBody4s'
                    dc i4'rightBody1s'
                    dc i4'rightBody2s'
                    dc i4'rightBody3s'
                    dc i4'rightBody2s'
                    dc i4'rightBody1s'
                    dc i4'rightBody4s'

segmentUpdateJumpTable  dc i2'updateSegmentLeftFast'
                        dc i2'updateSegmentLeftSlow'
                        dc i2'updateSegmentDownLeftFast'
                        dc i2'updateSegmentDownLeftSlow'
                        dc i2'updateSegmentDownFast'
                        dc i2'updateSegmentDownSlow'
                        dc i2'updateSegmentDownRightFast'
                        dc i2'updateSegmentDownRightSlow'
                        dc i2'updateSegmentRightFast'
                        dc i2'updateSegmentRightSlow'
                        
        end
