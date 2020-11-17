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
		
		
addRandomMushrooms entry
		stz numInfieldMushrooms
		ldy #STARTING_NUM_MUSHROOMS
		
addRandomMushrooms_loop anop
		phy
addRandomMushrooms_tryAgain anop
		jsl randomMushroomOffset
		tax
		lda tileType,x
		bne addRandomMushrooms_tryAgain
		lda #TILE_MUSHROOM4
		sta tileType,x
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		cpx #SPIDER_STARTING_TOP_ROW_OFFSET
		blt addRandomMushrooms_notInfield
		inc numInfieldMushrooms
addRandomMushrooms_notInfield anop
		ply
		dey
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
		dec numInfieldMushrooms
shootMushrom_notInfield anop
		jmp scoreAddOne
		
shootMushroom_poisonedNoScore anop
		tya
		sec
		sbc #4
		sta tileType,x
		
shootMushroom_done anop
		rtl

		end
