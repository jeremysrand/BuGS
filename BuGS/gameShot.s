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
		cmp #SHOT_STATE_START_SHOOTING
		bne updateShot_shooting
		jsl playFireSound
		lda SHOT_STATE_SHOOTING
		sta shotState
		lda #1
		and mouseX
		sta shotShifted
		bne updateShot_startShootingShifted
		lda mouseAddress
		sec
		sbc #TILE_PIXEL_HEIGHT*SCREEN_BYTES_PER_ROW-1
		sta shotAddress
		bra updateShot_findDirty
updateShot_startShootingShifted anop
		lda mouseAddress
		sec
		sbc #TILE_PIXEL_HEIGHT*SCREEN_BYTES_PER_ROW-2
		sta shotAddress
updateShot_findDirty anop
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		sta shotTileOffsetAbove
		tax
		lda tileBelow,x
		sta shotTileOffsetBelow
		bra updateShot_drawShot

updateShot_shooting anop
		lda shotAddress
		sec
		sbc #TILE_PIXEL_HEIGHT*SCREEN_BYTES_PER_ROW
		sta shotAddress
		cmp #SCREEN_ADDRESS-6*SCREEN_BYTES_PER_ROW
		bge updateShot_updateDirty
		lda #SHOT_STATE_NONE
		sta shotState
		rtl

updateShot_updateDirty anop
		ldx shotTileOffsetAbove
		stx shotTileOffsetBelow
		lda tileAbove,x
		cmp #INVALID_TILE_NUM
		beq updateShot_drawShot
		sta shotTileOffsetAbove

updateShot_drawShot anop
		lda #TILE_STATE_DIRTY
		ldx shotTileOffsetAbove
		sta tileDirty,x
		ldx shotTileOffsetBelow
		sta tileDirty,x
		ldy shotAddress
		lda shotShifted
		bne updateShot_drawShifted
		jsl drawShot
		bra updateShot_checkCollision
updateShot_drawShifted	anop
		jsl drawShotShift

updateShot_checkCollision anop
		bne updateShot_collision
		rtl
updateShot_collision anop
		cpx #SCREEN_ADDRESS
		bge updateShot_onScreen
		rtl
updateShot_onScreen anop
		and #$3333
		bne updateShot_maybeMushroom
		
		txy
		txa
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		cmp #SPIDER_STARTING_TOP_ROW_OFFSET
		blt updateShot_maybeScorpion
		jsl isSpiderCollision
		bcc updateShot_notSpiderOrScorpion
		lda #SHOT_STATE_NONE
		sta shotState
		jmp shootSpider

updateShot_maybeScorpion anop
		jsl isScorpionCollision
		bcc updateShot_notSpiderOrScorpion
		lda #SHOT_STATE_NONE
		sta shotState
		jmp shootScorpion

updateShot_notSpiderOrScorpion anop
		jsl isFleaCollision
		bcc updateShot_maybeSegment
		lda #SHOT_STATE_NONE
		sta shotState
		jmp shootFlea

updateShot_maybeSegment anop
		jsl isSegmentCollision
		bcc updateShot_done
		lda #SHOT_STATE_NONE
		sta shotState
		jmp shootSegment

updateShot_maybeMushroom anop
		txa
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		tax
		lda tileType,x
		beq updateShot_done
		lda #SHOT_STATE_NONE
		sta shotState
		jsl shootMushroom
updateShot_done anop
		rtl


shotState	dc i2'SHOT_STATE_NONE'
shotShifted	dc i2'0'
shotAddress	dc i2'0'
shotTileOffsetAbove dc i2'0'
shotTileOffsetBelow dc i2'0'

        end
