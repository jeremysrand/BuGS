;
;  gamePlayer.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-10-28.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

		case on
        mcopy gamePlayer.macros
        keep gamePlayer

gamePlayer start
		using globalData
		using tileData
		using screenData
		
initPlayer entry
		ldy #STARTING_NUM_LIVES
		sty numLives
		ldx #P1_LIVES_OFFSET
initPlayer_loop anop
		lda #TILE_PLAYER
		sta tileType,x
		phy
		_dirtyNonGameTile
		ply
		dex
		dex
		dey
		bne initPlayer_loop
		rtl
		
		
playerLevelStart entry
		lda #STARTING_MOUSE_X
		sta mouseX
		lda #STARTING_MOUSE_Y
		sta mouseY
		dec numLives
		lda #P1_LIVES_OFFSET
		sec
		sbc numLives
		sec
		sbc numLives
		tax
		lda #TILE_EMPTY
		sta tileType,x
		_dirtyNonGameTile
		rtl
		
		
playerAddLife entry
		lda #P1_LIVES_OFFSET
		sec
		sbc numLives
		sec
		sbc numLives
		tax
		inc numLives
		lda #TILE_PLAYER
		sta tileType,x
		_dirtyNonGameTile
		rtl
		

updatePlayer entry
		lda gameRunning
		beq updatePlayer_gameRunning
		rtl
updatePlayer_gameRunning anop
		ldx #0
		ldy #0
; This code for reading the mouse data is based on some code which John Brooks helpfully provided, although I did things
; quite differently because I have different needs.  But this is about as low cost as can be made for reading the position
; of the mouse.
		short i,m
		phb
		lda #$e0
		pha
		plb
		lda MOUSE_STATUS
		bpl updatePlayer_noMousePoll
		and #2
		bne updatePlayer_mouseYOnly
		ldx MOUSE_DATA_REG
updatePlayer_mouseYOnly anop
		ldy MOUSE_DATA_REG
updatePlayer_doneMousePoll anop
		plb
		long i,m
		bra updatePlayer_handleDeltas

updatePlayer_noMousePoll anop
		plb
		long i,m
		jmp updatePlayer_skipDeltas
		
updatePlayer_handleDeltas anop
; The X register has the deltaX
		txa
		bit #$40
		bne updatePlayer_negX
		and #$3f
		clc
		adc mouseX
		cmp #MOUSE_MAX_X
		blt updatePlayer_doneX
		lda #MOUSE_MAX_X-1
		bra updatePlayer_doneX
updatePlayer_negX anop
		ora #$ffc0
		clc
		adc mouseX
		bpl updatePlayer_doneX
		lda #0
updatePlayer_doneX anop
		sta mouseX
		
; The Y register has the deltaY
		tya
		bit #$40
		bne updatePlayer_negY
		and #$3f
		clc
		adc mouseY
		cmp #MOUSE_MAX_Y
		blt updatePlayer_doneY
		lda #MOUSE_MAX_Y-1
		bra updatePlayer_doneY
updatePlayer_negY anop
		ora #$ffc0
		clc
		adc mouseY
		bpl updatePlayer_doneY
		lda #0
updatePlayer_doneY anop
		sta mouseY

; The Y register also has a bit in it which indicates whether the
; mouse is down or not.
		tya
		and #$0080
		sta mouseDown

updatePlayer_skipDeltas anop
		lda mouseY
		asl a
		tay
		lda mouseX
		lsr a
		bcs updatePlayer_shift
		adc mouseYAddress,y
		sta mouseAddress
		tay
		jsl drawShip
		bra updatePlayer_dirty
		
updatePlayer_shift anop
		adc mouseYAddress,y
		dec a
		sta mouseAddress
		tay
		jsl drawShipShift
		bra updatePlayer_dirty
		
updatePlayer_dirty anop
		beq updatePlayer_noCollision
; Player collision here...
;		brk $00
updatePlayer_noCollision anop
		lda mouseAddress
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		tax
		lda #TILE_STATE_DIRTY
		cpx #RHS_FIRST_TILE_OFFSET
		bge updatePlayer_tileOffscreen1
		sta tileDirty,x
updatePlayer_tileOffscreen1 anop
		ldy tileRight,x
		cpy #RHS_FIRST_TILE_OFFSET
		bge updatePlayer_tileOffscreen2
		sta tileDirty,y
updatePlayer_tileOffscreen2 anop
		ldy tileBelow,x
		cpy #INVALID_TILE_NUM
		beq updatePlayer_done
		sta tileDirty,y
		ldx tileRight,y
		cpx #RHS_FIRST_TILE_OFFSET
		bge updatePlayer_done
		sta tileDirty,x
		
updatePlayer_done anop
		rtl

mouseX		dc i2'0'
mouseY 		dc i2'0'
mouseDown   dc i2'0'

        end
