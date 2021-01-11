;
;  gameMushroom.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-10-26.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

		case on
        mcopy gameMushroom.macros
        keep gameMushroom

gameMushroom start
        using globalData
		using tileData
		
		
STARTING_NUM_MUSHROOMS	equ 30
		

resetMushrooms entry
		lda mushroomToRefresh
		cmp #INVALID_TILE_NUM
		beq resetMushrooms_startFromBeginning
		tax
		lda mushroomExplosionSprite
		beq resetMushrooms_doneReset
		sec
		sbc #4
		
resetMushrooms_explode anop
		sta mushroomExplosionSprite
		tay
		lda explosionJumpTable,y
		sta resetMushrooms_jumpInst+1
		lda explosionJumpTable+2,y
		sta resetMushrooms_jumpInst+3
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		lda tileScreenOffset,x
		sec
		sbc #3
		tay
		jsl resetMushrooms_jumpInst
		sec
		rtl
	
resetMushrooms_jumpInst anop
		jmp >explosion1
		nop

resetMushrooms_doneReset anop
		lda mushroomRefreshWait
		beq resetMushrooms_next
		dec a
		sta mushroomRefreshWait
		sec
		rtl
		
resetMushrooms_startFromBeginning anop
		ldx #0

resetMushrooms_loop anop
		cpx #RHS_FIRST_TILE_OFFSET
		blt resetMushrooms_keepChecking
		lda #INVALID_TILE_NUM
		sta mushroomToRefresh
		clc
		rtl

resetMushrooms_keepChecking anop
		lda tileType,x
		beq resetMushrooms_next
		cmp #TILE_MUSHROOM4
		beq resetMushrooms_next
		stx mushroomToRefresh
		lda #TILE_MUSHROOM4
		sta tileType,x
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		jsl playBonusSound
		jsl scoreAddFive
		ldx mushroomToRefresh
		lda #EXPLOSION_LAST_OFFSET
		sta mushroomExplosionSprite
		lda #2
		sta mushroomRefreshWait
		sec
		rtl

resetMushrooms_next anop
		inx
		inx
		bra resetMushrooms_loop
		
		
addRandomMushrooms entry
		lda #INVALID_TILE_NUM
		sta mushroomToRefresh
		
		ldy #RHS_FIRST_TILE_OFFSET-2
addRandomMushrooms_clear anop
		lda tileType,y
		beq addRandomMushrooms_skipClear
		lda #TILE_EMPTY
		sta tileType,y
		lda #TILE_STATE_DIRTY
		sta tileDirty,y
addRandomMushrooms_skipClear anop
		dey
		dey
		bpl addRandomMushrooms_clear
		
		ldx playerNum
		stz numInfieldMushrooms,x
		ldx #STARTING_NUM_MUSHROOMS
		
addRandomMushrooms_loop anop
		phx
addRandomMushrooms_tryAgain anop
		jsl randomMushroomOffset
		tay
		lda tileType,y
		bne addRandomMushrooms_tryAgain
		lda #TILE_MUSHROOM4
		sta tileType,y
		lda #TILE_STATE_DIRTY
		sta tileDirty,y
		cpy #SPIDER_STARTING_TOP_ROW_OFFSET
		blt addRandomMushrooms_notInfield
		ldx playerNum
		inc numInfieldMushrooms,x
addRandomMushrooms_notInfield anop
		plx
		dex
		bne addRandomMushrooms_loop
		rtl
		
		
; Call this with the tile offset of the mushroom being shot in the X register
shootMushroom entry
		ldy tileType,x
		beq shootMushroom_done
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		cpy #TILE_POISON_MUSHROOM1
		bge shootMushroom_poisoned
		tya
		sec
		sbc #4
		sta tileType,x
		bne shootMushroom_done
		bra shootMushroom_empty
		
shootMushroom_poisoned anop
		bne shootMushroom_poisonedNoScore
		lda #TILE_EMPTY
		sta tileType,x
shootMushroom_empty anop
		cpx #SPIDER_STARTING_TOP_ROW_OFFSET
		blt shootMushrom_notInfield
		ldx playerNum
		dec numInfieldMushrooms,x
shootMushrom_notInfield anop
		jmp scoreAddOne
		
shootMushroom_poisonedNoScore anop
		tya
		sec
		sbc #4
		sta tileType,x
		
shootMushroom_done anop
		rtl


mushroomToRefresh	dc i2'INVALID_TILE_NUM'
mushroomExplosionSprite	dc i2'0'
mushroomRefreshWait dc i2'0'


		end
