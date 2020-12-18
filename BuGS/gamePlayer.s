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
		
PLAYER_EXPLOSION_FRAME_COUNT	equ 3
PLAYER_RESTART_LEVEL_FRAME_COUNT	equ 20
		
		
initPlayer entry
		ldy #STARTING_NUM_LIVES
		sty numLives
		stz playerIgnoreFirstPoll
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
		stz playerIgnoreFirstPoll
		lda #PLAYER_STATE_ONSCREEN
		sta playerState
		lda #STARTING_MOUSE_X
		sta mouseX
		lda #STARTING_MOUSE_Y
		sta mouseY
		lda #1
		sta mouseDown
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
		jmp playExtraLifeSound
		

updatePlayer entry
		lda gameRunning
		beq updatePlayer_gameRunning
		rtl
updatePlayer_gameRunning anop
		lda playerState
		cmp #PLAYER_STATE_NONE
		bne updatePlayer_notNone
		lda playerFrameCount
		bne updatePlayer_wait
		lda numLives
		beq updatePlayer_gameOver
		lda numSegments
		bne updatePlayer_notNextLevel
; If we are going to the next level, let updateLevel handle that for us.
		rtl
updatePlayer_notNextLevel anop
		jmp startLevel
updatePlayer_gameOver anop
		jmp gameOver
updatePlayer_wait anop
		dec a
		sta playerFrameCount
		rtl
updatePlayer_notNone anop
		cmp #PLAYER_STATE_EXPLODING
		beq updatePlayer_exploding
		jmp updatePlayer_notExploding
updatePlayer_exploding anop
		lda playerFrameCount
		beq updatePlayer_nextExplosion
		dec a
		sta playerFrameCount
		bra updatePlayer_drawExplosion
updatePlayer_nextExplosion anop
		lda playerExplosionOffset
		beq updatePlayer_doneExplosion
		sec
		sbc #4
		sta playerExplosionOffset
		lda #PLAYER_EXPLOSION_FRAME_COUNT
		sta playerFrameCount
		bra updatePlayer_drawExplosion
updatePlayer_doneExplosion anop
		lda #PLAYER_STATE_MUSHROOMS
		sta playerState
		rtl

updatePlayer_drawExplosion anop
		lda mouseAddress
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		tax
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		ldy tileBelow,x
		cpy #INVALID_TILE_NUM
		beq updatePlayer_drawExplosionSkipBelow1
		sta tileDirty,y
updatePlayer_drawExplosionSkipBelow1 anop
		ldy tileRight,x
		sta tileDirty,y
		ldx tileBelow,y
		cpx #INVALID_TILE_NUM
		beq updatePlayer_drawExplosionSkipBelow2
		sta tileDirty,x
updatePlayer_drawExplosionSkipBelow2 anop
		ldx tileRight,y
		sta tileDirty,x
		ldy tileBelow,x
		cpy #INVALID_TILE_NUM
		beq updatePlayer_drawExplosionSkipBelow3
		sta tileDirty,y
updatePlayer_drawExplosionSkipBelow3 anop
		ldy mouseAddress
		ldx playerExplosionOffset
		lda shipExplosionJumpTable,x
		sta jumpInst+1
		lda shipExplosionJumpTable+2,x
		sta jumpInst+3
jumpInst anop
		jmp >shipExplosion1
		nop
		
updatePlayer_notExploding anop
		cmp #PLAYER_STATE_MUSHROOMS
		bne updatePlayer_notMushrooms
		jsl resetMushrooms
		bcc updatePlayer_doneMushrooms
		rtl
		
updatePlayer_doneMushrooms anop
		lda #PLAYER_RESTART_LEVEL_FRAME_COUNT
		sta playerFrameCount
		lda #PLAYER_STATE_NONE
		sta playerState
		rtl
		
updatePlayer_notMushrooms anop
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
		lda playerIgnoreFirstPoll
		bne updatePlayer_handleDeltas
		lda #1
		sta playerIgnoreFirstPoll
		jmp updatePlayer_skipDeltas

updatePlayer_noMousePoll anop
		plb
		long i,m
		jmp updatePlayer_skipDeltas
		
updatePlayer_handleDeltas anop
; The X and Y register also has a bit in each which indicates whether a
; mouse button is down or not.
		txa
		and #$0080
		beq updatePlayer_mouseDown
		tya
		and #$0080
		beq updatePlayer_mouseDown
		lda #1
		sta mouseDown
		bra updatePlayer_doY
updatePlayer_mouseDown anop
		stz mouseDown

updatePlayer_doY anop
; The Y register has the deltaY
		tya
		bit #$40
		bne updatePlayer_negY
		and #$3f
		inc a
		lsr a
		bne updatePlayer_hasPosY
		jmp updatePlayer_doX
updatePlayer_hasPosY anop
		cmp #9
		blt updatePlayer_posYNoClamp
		lda #8
updatePlayer_posYNoClamp anop
		clc
		adc mouseY
		cmp #MOUSE_MAX_Y
		blt updatePlayer_checkBelow
		lda #MOUSE_MAX_Y-1
updatePlayer_checkBelow anop
		sta mouseY
		asl a
		tay
		lda mouseYTileBelow,y
		sta mouseTemp
		lda mouseX
		asl a
		tay
		lda mouseXTileLeft,y
		clc
		adc mouseTemp
		phx
		tax
		lda tileType,x
		bne updatePlayer_blockedBelow
		lda mouseXTileRight,y
		clc
		adc mouseTemp
		tax
		lda tileType,x
		bne updatePlayer_blockedBelow
		plx
		bra updatePlayer_doX
updatePlayer_blockedBelow anop
		plx
		lda mouseY
		dec a
		and #$fff8
		sta mouseY
		bra updatePlayer_doX
		
updatePlayer_negY anop
		ora #$ffc0
		dec a
		lsr a
		ora #$8000
		cmp #$fff8
		bge updatePlayer_negYNoClamp
		lda #$fff8
updatePlayer_negYNoClamp anop
		clc
		adc mouseY
		bpl updatePlayer_checkAbove
		lda #0
updatePlayer_checkAbove anop
		sta mouseY
		asl a
		tay
		lda mouseYTileAbove,y
		sta mouseTemp
		lda mouseX
		asl a
		tay
		lda mouseXTileLeft,y
		clc
		adc mouseTemp
		phx
		tax
		lda tileType,x
		bne updatePlayer_blockedAbove
		lda mouseXTileRight,y
		clc
		adc mouseTemp
		tax
		lda tileType,x
		bne updatePlayer_blockedAbove
		plx
		bra updatePlayer_doX
updatePlayer_blockedAbove anop
		plx
		lda mouseY
		clc
		adc #TILE_PIXEL_HEIGHT
		and #$fff8
		sta mouseY

updatePlayer_doX anop
; The X register has the deltaX
		txa
		bit #$40
		bne updatePlayer_negX
		and #$3f
		inc a
		lsr a
		bne updatePlayer_hasPosX
		jmp updatePlayer_skipDeltas
updatePlayer_hasPosX anop
		cmp #9
		blt updatePlayer_posXNoClamp
		lda #8
updatePlayer_posXNoClamp anop
		clc
		adc mouseX
		cmp #MOUSE_MAX_X
		blt updatePlayer_checkRight
		lda #MOUSE_MAX_X-1
updatePlayer_checkRight anop
		sta mouseX
		asl a
		tay
		lda mouseXTileRight,y
		sta mouseTemp
		lda mouseY
		asl a
		tay
		lda mouseYTileAbove,y
		clc
		adc mouseTemp
		tax
		lda tileType,x
		bne updatePlayer_blockedRight
		lda mouseYTileBelow,y
		clc
		adc mouseTemp
		tax
		lda tileType,x
		beq updatePlayer_skipDeltas
updatePlayer_blockedRight anop
		lda mouseX
		dec a
		and #$fff8
		sta mouseX
		bra updatePlayer_skipDeltas
		
updatePlayer_negX anop
		ora #$ffc0
		dec a
		lsr a
		ora #$8000
		cmp #$fff8
		bge updatePlayer_negXNoClamp
		lda #$fff8
updatePlayer_negXNoClamp anop
		clc
		adc mouseX
		bpl updatePlayer_checkLeft
		lda #0
updatePlayer_checkLeft anop
		sta mouseX
		asl a
		tay
		lda mouseXTileLeft,y
		sta mouseTemp
		lda mouseY
		asl a
		tay
		lda mouseYTileAbove,y
		clc
		adc mouseTemp
		tax
		lda tileType,x
		bne updatePlayer_blockedLeft
		lda mouseYTileBelow,y
		clc
		adc mouseTemp
		tax
		lda tileType,x
		beq updatePlayer_skipDeltas
updatePlayer_blockedLeft anop
		lda mouseX
		clc
		adc #TILE_PIXEL_WIDTH
		and #$fff8
		sta mouseX

updatePlayer_skipDeltas anop
		lda mouseDown
		bne updatePlayer_notShooting
		jsl maybeShoot
updatePlayer_notShooting anop
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
		bne updatePlayer_collision
		jmp updatePlayer_noCollision
updatePlayer_collision anop
		lda #PLAYER_STATE_EXPLODING
		sta playerState

; Figure out which kind of bug collided with the player and cause it to
; explode.
		txa
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		jsl isSpiderCollision
		bcc updatePlayer_notSpiderCollision
		jsl explodeSpider
		bra updatePlayer_explode
updatePlayer_notSpiderCollision anop
		jsl isFleaCollision
		bcc updatePlayer_notFleaCollision
		jsl explodeFlea
		bra updatePlayer_explode
		
updatePlayer_notFleaCollision anop
		jsl isSegmentCollision
		bcc updatePlayer_explode
		jsl explodeSegment
		
updatePlayer_explode anop
		lda mouseAddress
		sec
		sbc #TILE_BYTE_WIDTH/2
		sta mouseAddress
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		cmp #RHS_FIRST_TILE_OFFSET
		bge updatePlayer_explosionOffLeft
		tay
		ldx tileRight,y
		ldy tileRight,x
		cpy #RHS_FIRST_TILE_OFFSET
		blt updatePlayer_contCollision
		lda mouseAddress
		dec a
		and #$fffc
		sta mouseAddress
		bra updatePlayer_contCollision
		
updatePlayer_explosionOffLeft anop
		lda mouseAddress
		clc
		adc #TILE_BYTE_WIDTH
		and #$fffc
		sta mouseAddress
		
updatePlayer_contCollision anop
		lda #PLAYER_EXPLOSION_FRAME_COUNT
		sta playerFrameCount
		lda #SHIP_EXPLOSION_LAST_OFFSET
		sta playerExplosionOffset
		jsl playDeathSound
		jmp updatePlayer_exploding
		
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


playerFrameCount 		dc i2'0'
playerExplosionOffset	dc i2'0'
playerIgnoreFirstPoll   dc i2'0'
mouseDown	dc i2'0'
mouseTemp 	dc i2'0'


SHIP_EXPLOSION_LAST_OFFSET	equ 7*4

shipExplosionJumpTable anop
		dc i4'shipExplosion8'
		dc i4'shipExplosion7'
		dc i4'shipExplosion6'
		dc i4'shipExplosion5'
		dc i4'shipExplosion4'
		dc i4'shipExplosion3'
		dc i4'shipExplosion2'
		dc i4'shipExplosion1'


        end
