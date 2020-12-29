;
;  game.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-06-10.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

;
; The actual game is a 30x30 grid of 8x8 tiles.
; The GS can do 30 wide with 10 tiles to spare.
; The GS can only do 25 tiles tall though.  So,
; the screen will be 30 wide pushed to the right-
; most side.  The left side will have the score,
; count of lives and the high score.  Rather than
; having them at the top, running that info on
; the side will give us more vertical height for
; more on-screen action.

        case on
        mcopy game.macros
        keep game

game    start
        using globalData
		using tileData
        
        jsl setupScreen
        
        lda #0
        jsl setColour

gameLoop anop
        
        _drawDirtyGameRow 0
        _drawDirtyGameRow 1
        _drawDirtyGameRow 2
        _drawDirtyGameRow 3
        _drawDirtyGameRow 4
        _drawDirtyGameRow 5
        _drawDirtyGameRow 6
        _drawDirtyGameRow 7
        _drawDirtyGameRow 8
        _drawDirtyGameRow 9
        _drawDirtyGameRow 10
        _drawDirtyGameRow 11
        _drawDirtyGameRow 12
        _drawDirtyGameRow 13
        _drawDirtyGameRow 14
        
        jsl drawScorpion
        
        _drawDirtyGameRow 15
        _drawDirtyGameRow 16
        _drawDirtyGameRow 17
        _drawDirtyGameRow 18
        _drawDirtyGameRow 19
        _drawDirtyGameRow 20
        _drawDirtyGameRow 21
        _drawDirtyGameRow 22
        _drawDirtyGameRow 23
        _drawDirtyGameRow 24
        
        jsl drawSpider
        jsl drawFlea
        jsl drawSegments
        jsl drawDirtyNonGameTiles
        
		jsl updatePlayer
		jsl updateShot
        jsl updateScorpion
        jsl updateSpider
        jsl updateFlea
        jsl updateSegments
		jsl updateLevel
		jsl updateSounds
		
        jsl checkKeyboard
        
        jsl waitForVbl
        
        lda shouldQuit
        beq gameDone
        jmp gameLoop
        
gameDone anop
        short i,m
        lda >BORDER_COLOUR_REGISTER
        and #$f0
        ora borderColour
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
        rtl
        

drawDirtyNonGameTiles entry
        ldy numDirtyNonGameTiles
        beq dirtyTileLoopDone2
dirtyTileLoop2 anop
        dey
        dey
        phy
        
        ldx dirtyNonGameTiles,y
        stz tileDirty,x
        ldy tileScreenOffset,x
        lda tileType,x
        
        jsl drawTile
        
        ply
        bne dirtyTileLoop2
dirtyTileLoopDone2 anop
        stz numDirtyNonGameTiles
        rtl


drawTile entry
        tax
        
        lda tileJumpTable,x
        sta jumpInst+1
        
        lda tileJumpTable+2,x
        sta jumpInst+3
        
jumpInst jmp >mushroom1
        nop

        
setupScreen entry
        short i,m
        lda >SHADOW_REGISTER     ; Enable shadowing of SHR
        and #$f7
        sta >SHADOW_REGISTER
        
        lda #$a1
        sta >NEW_VIDEO_REGISTER     ; Enable SHR mode
        lda >BORDER_COLOUR_REGISTER
        long i,m
        and #$000f
        sta borderColour
		
		short i,m
		lda >BORDER_COLOUR_REGISTER
		and #$f0
		sta >BORDER_COLOUR_REGISTER
		long i,m
        
        sei
        phd
        tsc
        sta >backupStack
        lda >STATE_REGISTER      ; Direct Page and Stack in Bank 01/
        ora #$0030
        sta >STATE_REGISTER
        ldx #$0000
        
        lda #$9dfe
        tcs
        ldy #$7e00
nextWord anop
        phx
        dey
        dey
        bpl nextWord
        
        lda >STATE_REGISTER
        and #$ffcf
        sta >STATE_REGISTER
        lda >backupStack
        tcs
        pld
        cli
        
        rtl

		
; The accumulator has a 0 in it when starting a one player game, 1 when
; starting a two player game.
startGame entry
		ldx gameRunning
		bne startGame_notRunning
		rtl
startGame_notRunning anop
		stz gameRunning
		jsl addRandomMushrooms
		jsl scoreStartGame
		jsl initPlayer
		jsl spiderInitGame
		jsl levelInit
		jsl soundInit
; Fall through intentionally here...
startLevel entry
		jsl segmentsInitLevel
		jsl scorpionInitLevel
		jsl spiderInitLevel
		jsl fleaInitLevel
		jsl shotInitLevel
		jsl playerLevelStart
		jmp levelStart
		

pauseGame entry
		jsl pauseSound
		
		ldx #GAME_NUM_TILES_WIDE*4+2
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*6+2
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_P
		_overwriteTile TILE_LETTER_A
		_overwriteTile TILE_LETTER_U
		_overwriteTile TILE_LETTER_S
		_overwriteTile TILE_LETTER_E
		_overwriteTile TILE_LETTER_D
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*8+2
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*10+2
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_P
		_overwriteTile TILE_LETTER_R
		_overwriteTile TILE_LETTER_E
		_overwriteTile TILE_LETTER_S
		_overwriteTile TILE_LETTER_S
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_Q
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_T
		_overwriteTile TILE_LETTER_O
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_Q
		_overwriteTile TILE_LETTER_U
		_overwriteTile TILE_LETTER_I
		_overwriteTile TILE_LETTER_T
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*12+2
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_O
		_overwriteTile TILE_LETTER_T
		_overwriteTile TILE_LETTER_H
		_overwriteTile TILE_LETTER_E
		_overwriteTile TILE_LETTER_R
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_K
		_overwriteTile TILE_LETTER_E
		_overwriteTile TILE_LETTER_Y
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_T
		_overwriteTile TILE_LETTER_O
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_LETTER_R
		_overwriteTile TILE_LETTER_E
		_overwriteTile TILE_LETTER_S
		_overwriteTile TILE_LETTER_U
		_overwriteTile TILE_LETTER_M
		_overwriteTile TILE_LETTER_E
		_overwriteTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*14+2
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		_overwriteTile TILE_EMPTY
		
		short i,m
pauseGame_loop anop
		lda >KEYBOARD
		bpl pauseGame_loop
		sta >KEYBOARD_STROBE
		long i,m
		and #$7f
		cmp #'q'
		beq pauseGame_quit
		cmp #'Q'
		beq pauseGame_quit
		jsl unpauseSound
		rtl
pauseGame_quit anop
		stz shouldQuit
		rtl
		
		
gameOver entry
		lda #1
		sta gameRunning
		jsl segmentsInitLevel
		jsl scorpionInitLevel
		jsl spiderInitLevel
		jsl fleaInitLevel
		
		ldx #0
gameOver_loop anop
		lda tileType,x
		beq gameOver_tileEmpty
		stz tileType,x
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
gameOver_tileEmpty anop
		inx
		inx
		cpx #RHS_FIRST_TILE_OFFSET
		blt gameOver_loop
		
		jmp checkHighScore
		

checkKeyboard entry
checkKey_loop2 anop
        short i,m
        lda >KEYBOARD
        bpl checkKey_done
        sta >KEYBOARD_STROBE
        long i,m
        and #$007f
		
		ldx gameRunning
		beq checkKey_pause
        
        cmp #'q'
        beq checkKey_quit
        cmp #'Q'
        beq checkKey_quit

		cmp #'1'
		beq checkKey_game
		
		cmp #'2'
		beq checkKey_game
        
checkKey_done anop
		long i,m
        rtl
		
checkKey_pause anop
		jmp pauseGame
                
checkKey_quit anop
        stz shouldQuit
        rtl

checkKey_game anop
		sec
		sbc #'1'
		jmp startGame


waitForKey entry
        short i,m
waitForKey_loop anop
        lda >KEYBOARD
        bpl waitForKey_loop
        sta >KEYBOARD_STROBE
        long i,m
        rtl


waitForVbl entry
vblLoop anop
        lda >VERTICAL_COUNTER     ; load the counter value
        and #$80ff                ; mask out the VBL bits
        asl a                     ; shift the word around
        adc #0                    ; move MSB -> LSB
        cmp #$1c8
        bge vblLoop
        rtl
        
        
shouldQuit          dc i2'1'
borderColour        dc i2'0'

        end
