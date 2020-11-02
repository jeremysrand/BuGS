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

PLAYER_TILES_HIGH	equ 7

MOUSE_MAX_X		equ GAME_NUM_TILES_WIDE*TILE_PIXEL_WIDTH-TILE_PIXEL_WIDTH
MOUSE_MAX_Y		equ GAME_NUM_TILES_TALL*TILE_PIXEL_HEIGHT-TILE_PIXEL_HEIGHT

STARTING_MOUSE_X	equ GAME_NUM_TILES_WIDE*TILE_PIXEL_WIDTH/2
STARTING_MOUSE_Y	equ MOUSE_MAX_Y
		
initPlayer entry
		lda #STARTING_MOUSE_X
		sta mouseX
		lda #STARTING_MOUSE_Y
		sta mouseY
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
		lda mouseX
		lsr a
		bcs updatePlayer_shift
		adc #$9834
		tay
		jsl drawShip
		bra updatePlayer_dirty
		
updatePlayer_shift anop
		adc #$9833
		tay
		jsl drawShipShift
		bra updatePlayer_dirty
		
updatePlayer_dirty anop
		lda #TILE_STATE_DIRTY
		sta tileDirty+1200
		sta tileDirty+1202
		sta tileDirty+1204
		sta tileDirty+1206
		sta tileDirty+1208
		sta tileDirty+1210
		sta tileDirty+1212
		sta tileDirty+1214
		sta tileDirty+1216
		sta tileDirty+1218
		sta tileDirty+1220
		sta tileDirty+1222
		sta tileDirty+1224
		sta tileDirty+1226
		sta tileDirty+1228
		sta tileDirty+1230
		sta tileDirty+1232
		sta tileDirty+1234
		sta tileDirty+1236
		sta tileDirty+1238
		sta tileDirty+1240
		sta tileDirty+1242
		sta tileDirty+1244
		sta tileDirty+1246
		sta tileDirty+1248
		rtl

mouseX		dc i2'0'
mouseY 		dc i2'0'
mouseDown   dc i2'0'

        end
