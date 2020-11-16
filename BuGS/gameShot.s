;
;  gameShot.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-11-15.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

		case on
        mcopy gameShot.macros
        keep gameShot

gameShot start
		using globalData
		using tileData
		using screenData

SHOT_STATE_NONE	equ 0
SHOT_STATE_START_SHOOTING	equ 1
SHOT_STATE_SHOOTING		equ 2


shotInitLevel entry
		stz shotState
		rtl

maybeShoot entry
		lda shotState
		bne maybeShoot_alreadyShooting
		lda #SHOT_STATE_START_SHOOTING
		sta shotState
maybeShoot_alreadyShooting anop
		rtl


updateShot entry
		lda playerState
		cmp #PLAYER_STATE_ONSCREEN
		beq updateShot_playerOnscreen
		rtl
updateShot_playerOnscreen anop
		lda shotState
		bne updateShot_notNone
		lda mouseX
		and #1
		bne updateShot_shifted
		lda mouseAddress
		sec
		sbc #$1df
		tay
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		tax
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		jmp >drawHalfShot
updateShot_shifted anop
		lda mouseAddress
		sec
		sbc #$1de
		tay
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		tax
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		jmp >drawHalfShotShift

		
updateShot_notNone anop
		rtl


shotState	dc i2'SHOT_STATE_NONE'
shotShifted	dc i2'0'
shotAddress	dc i2'0'

        end
