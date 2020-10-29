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

updatePlayer entry
		lda gameRunning
		beq updatePlayer_gameRunning
		rtl
updatePlayer_gameRunning anop
		pha
		pha
		pha
		~ReadMouse
		pla
		pla
		pla
		lsr a
		bcs updatePlayer_shift
		adc #$9834
		tay
		jsl drawShip
		bra updatePlayer_dirty
		
updatePlayer_shift anop
		adc #$9834
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
	
        end
