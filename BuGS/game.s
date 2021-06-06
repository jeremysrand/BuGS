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
		using playerData
        

PLAYER_DEATH_FRAME_COUNT	equ 30
NEXT_LEVEL_FRAME_COUNT 	equ 60
NEXT_PLAYER_FRAME_COUNT	equ 180
GAME_OVER_FRAME_COUNT	equ 180
RESTART_LEVEL_FRAME_COUNT	equ 20


		jsl setupScreen
        
        lda #0
        jsl setColour
		jsl setGameNotRunning
		jsl updateHighScore

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
		jsl updateGameState
        jsl updateScorpion
        jsl updateSpider
        jsl updateFlea
        jsl updateSegments
		jsl updateSounds
		
		lda shouldPreloadSound
		bne gameLoop_skipPreload
		jsl preloadSound
		lda #1
		sta shouldPreloadSound
gameLoop_skipPreload anop

; The following is the network poll code which runs when not playing a game
		lda gameState
		bne gameLoop_skipNetwork
		jsl pollNetwork
		lda hasGlobalHighScores
		beq gameLoop_skipNetwork
		lda highScoreCountdown
		beq gameLoop_swapHighScores
		dec a
		sta highScoreCountdown
		bra gameLoop_skipNetwork
gameLoop_swapHighScores anop
		lda #10*60
		sta highScoreCountdown
		lda displayGlobalHighScores
		eor #1
		sta displayGlobalHighScores
		jsl staticGameBoard
gameLoop_skipNetwork anop
	
		lda globalScoreAge
		beq gameLoop_skipScoreAgeDec
		dec a
		sta globalScoreAge
gameLoop_skipScoreAgeDec anop
		
        jsl checkKeyboard
        
        jsl waitForBeam
        
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
        sta backupStack
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
        lda backupStack
        tcs
        pld
        cli
        
        rtl

		
; The accumulator has a 0 in it when starting a one player game, 1 when
; starting a two player game.
startGame entry
		ldx gameState
		beq startGame_notRunning
		rtl
startGame_notRunning anop
		sta isSinglePlayer
		lda #GAME_STATE_LEVEL
		sta gameState
		jsl initPlayer
		jsl scoreStartGame
		lda isSinglePlayer
		beq startGame_singlePlayer
		lda #PLAYER_TWO
		sta playerNum
		jsl addRandomMushrooms
		jsl copyToPlayer2Tiles
		lda #PLAYER_ONE
		sta playerNum
startGame_singlePlayer anop
		jsl addRandomMushrooms
		jsl spiderInitGame
		jsl levelInit
		jsl soundInit
		jsl disconnectNetwork
; Fall through intentionally here...
startLevel entry
		jsl segmentsInitLevel
		jsl scorpionInitLevel
		jsl spiderInitLevel
		jsl fleaInitLevel
		jsl shotInitLevel
		jsl playerLevelStart
		jmp levelStart


updateGameState entry
		lda gameState
		beq updateGameState_none
		cmp #GAME_STATE_LEVEL
		beq updateGameState_level
		cmp #GAME_STATE_NEXT_LEVEL
		beq updateGameState_nextLevel
		cmp #GAME_STATE_PLAYER_DYING
		beq updateGameState_playerDying
		cmp #GAME_STATE_BONUS
		beq updateGameState_bonus
		jmp updateGameState_moreStates
updateGameState_none anop
		stz frameCount
		rtl
		
updateGameState_level anop
		lda numSegments
		bne updateGameState_levelNotDone
		jsl levelNext
		lda #GAME_STATE_NEXT_LEVEL
		sta gameState
		lda #NEXT_LEVEL_FRAME_COUNT
		sta frameCount
		jsl stopSegmentSound
updateGameState_levelNotDone anop
		lda playerState
		cmp #PLAYER_STATE_EXPLODING
		bne updateGameState_levelPlayerNotDying
		lda #GAME_STATE_PLAYER_DYING
		sta gameState
		lda #PLAYER_DEATH_FRAME_COUNT
		sta frameCount
updateGameState_levelPlayerNotDying anop
		rtl
		
updateGameState_nextLevel anop
		lda playerState
		cmp #PLAYER_STATE_EXPLODING
		bne updateGameState_nextLevelPlayerNotDying
		lda #GAME_STATE_PLAYER_DYING
		sta gameState
		lda #PLAYER_DEATH_FRAME_COUNT
		sta frameCount
		rtl
updateGameState_nextLevelPlayerNotDying anop
		lda frameCount
		beq updateGameState_startLevel
		dec a
		sta frameCount
		rtl
updateGameState_startLevel anop
		lda #GAME_STATE_LEVEL
		sta gameState
		jmp levelStart
	
updateGameState_playerDying anop
		lda frameCount
		beq updateGameState_playerDead
		dec a
		sta frameCount
		rtl
updateGameState_playerDead anop
		lda #GAME_STATE_BONUS
		sta gameState
		jsl segmentsInitLevel
		jsl scorpionInitLevel
		jsl spiderInitLevel
		jsl fleaInitLevel
		rtl
		
updateGameState_bonus anop
		jsl resetMushrooms
		bcc updateGameState_doneBonus
		rtl
updateGameState_doneBonus anop
		ldx playerNum
		lda numLives,x
		bne updateGameState_gameNotOver
		jsl checkHighScore
		bcc updateGameState_notHighScore
		lda isSinglePlayer
		beq updateGameState_isSinglePlayer
		stz isSinglePlayer
		bra updateGameState_twoPlayer
updateGameState_isSinglePlayer anop
		jmp setGameNotRunning
updateGameState_notHighScore anop
		lda isSinglePlayer
		beq updateGameState_isSinglePlayer
		lda #GAME_STATE_GAME_OVER
		sta gameState
		lda #GAME_OVER_FRAME_COUNT
		sta frameCount
		rtl
updateGameState_gameNotOver anop
		jsl segmentsInitLevel
		jsl scorpionInitLevel
		jsl spiderInitLevel
		jsl fleaInitLevel
		lda isSinglePlayer
		bne updateGameState_twoPlayer
		lda #GAME_STATE_NEXT_LIFE
		sta gameState
		lda #RESTART_LEVEL_FRAME_COUNT
		sta frameCount
		rtl
updateGameState_twoPlayer anop
		lda #GAME_STATE_NEXT_PLAYER
		sta gameState
		lda #NEXT_PLAYER_FRAME_COUNT
		sta frameCount
		lda playerNum
		eor #PLAYER_TWO
		sta playerNum
		jsl scoreSwitchPlayer
		ldx playerNum
		lda colourLevelNum,x
		jsl setColour
		lda playerNum
		beq updateGameState_toPlayer1
		jsl copyToPlayer1Tiles
		jmp copyFromPlayer2Tiles
updateGameState_toPlayer1 anop
		jsl copyToPlayer2Tiles
		jmp copyFromPlayer1Tiles
		
updateGameState_moreStates anop
		cmp #GAME_STATE_NEXT_LIFE
		beq updateGameState_nextLife
		cmp #GAME_STATE_NEXT_PLAYER
		beq updateGameState_nextPlayer
		cmp #GAME_STATE_GAME_OVER
		beq updateGameState_gameOver
		rtl
		
updateGameState_nextLife anop
		lda frameCount
		bne updateGameState_nextLifeWait
		lda #GAME_STATE_LEVEL
		sta gameState
		jmp startLevel
updateGameState_nextLifeWait anop
		dec a
		sta frameCount
		rtl

updateGameState_nextPlayer anop
		lda frameCount
		bne updateGameState_nextPlayerWait
		lda #GAME_STATE_LEVEL
		sta gameState
		jmp startLevel
updateGameState_nextPlayerWait anop
		dec a
		sta frameCount
updateGameState_printPlayerNumber anop
		ldx #GAME_NUM_TILES_WIDE*12+16
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_P
		_overwriteGameTile TILE_LETTER_L
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		lda playerNum
		beq updateGameState_displayPlayer1
		_overwriteGameTile TILE_NUMBER_2
		rtl
updateGameState_displayPlayer1 anop
		_overwriteGameTile TILE_NUMBER_1
		rtl
		
updateGameState_gameOver anop
		lda frameCount
		bne updateGameState_gameOverWait
		stz isSinglePlayer
		jmp updateGameState_twoPlayer
		
updateGameState_gameOverWait anop
		dec a
		sta frameCount
		ldx #GAME_NUM_TILES_WIDE*10+14
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_G
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_M
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_V
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		jmp updateGameState_printPlayerNumber
	
	
copyToPlayer1Tiles entry
		ldx #0
copyToPlayer1Tiles_loop anop
		lda tileType,x
		sta >player1Tiles,x
		inx
		inx
		cpx #RHS_FIRST_TILE_OFFSET
		blt copyToPlayer1Tiles_loop
		rtl

		
copyToPlayer2Tiles entry
		ldx #0
copyToPlayer2Tiles_loop anop
		lda tileType,x
		sta >player2Tiles,x
		inx
		inx
		cpx #RHS_FIRST_TILE_OFFSET
		blt copyToPlayer2Tiles_loop
		rtl
		
		
copyFromPlayer1Tiles entry
		ldx #0
copyFromPlayer1Tiles_loop anop
		lda >player1Tiles,x
		cmp tileType,x
		beq copyFromPlayer1Tiles_skip
		sta tileType,x
		lda TILE_STATE_DIRTY
		sta tileDirty,x
copyFromPlayer1Tiles_skip anop
		inx
		inx
		cpx #RHS_FIRST_TILE_OFFSET
		blt copyFromPlayer1Tiles_loop
		rtl
		
		
copyFromPlayer2Tiles entry
		ldx #0
copyFromPlayer2Tiles_loop anop
		lda >player2Tiles,x
		cmp tileType,x
		beq copyFromPlayer2Tiles_skip
		sta tileType,x
		lda TILE_STATE_DIRTY
		sta tileDirty,x
copyFromPlayer2Tiles_skip anop
		inx
		inx
		cpx #RHS_FIRST_TILE_OFFSET
		blt copyFromPlayer2Tiles_loop
		rtl
		

overwriteGameTile entry
		phy
		tay
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
		tya
		ldy tileScreenOffset,x
		phx
		jsl drawTile
		plx
		inx
		inx
		ply
		rts
		

pauseGame entry
		jsl pauseSound
		
		ldx #GAME_NUM_TILES_WIDE*4+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*6+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_P
		_overwriteGameTile TILE_LETTER_A
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_D
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*8+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*10+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_P
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_Q
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_Q
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_I
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*12+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_LETTER_H
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_K
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_Y
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_T
		_overwriteGameTile TILE_LETTER_O
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_LETTER_R
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_LETTER_S
		_overwriteGameTile TILE_LETTER_U
		_overwriteGameTile TILE_LETTER_M
		_overwriteGameTile TILE_LETTER_E
		_overwriteGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*14+2
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		_overwriteGameTile TILE_EMPTY
		
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
		
		
setGameTile entry
		cmp tileType,x
		beq setGameTile_skip
		sta tileType,x
		lda #TILE_STATE_DIRTY
		sta tileDirty,x
setGameTile_skip anop
		inx
		inx
		rts
		
		
setGameNotRunning entry
		lda #GAME_STATE_NOT_RUNNING
		sta gameState
		jsl segmentsInitLevel
		jsl scorpionInitLevel
		jsl spiderInitLevel
		jsl fleaInitLevel
		jsl addRandomMushrooms
		stz displayGlobalHighScores
		jmp staticGameBoard
		
		
staticGameBoard entry
		lda #TILE_PLAYER
		sta tileType+RHS_FIRST_TILE_OFFSET-GAME_NUM_TILES_WIDE-1
		lda #TILE_STATE_DIRTY
		sta tileDirty+RHS_FIRST_TILE_OFFSET-GAME_NUM_TILES_WIDE-1
		
		lda displayGlobalHighScores
		beq staticGameBoard_localHighScores
		jmp staticGameBoard_globalHighScores

staticGameBoard_localHighScores anop
		ldx #GAME_NUM_TILES_WIDE*8+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_H
		_setGameTile TILE_LETTER_I
		_setGameTile TILE_LETTER_G
		_setGameTile TILE_LETTER_H
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_LETTER_C
		_setGameTile TILE_LETTER_O
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_LETTER_E
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*10+2
		_setGameTile TILE_EMPTY
		_highScoreRow 0
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*12+2
		_setGameTile TILE_EMPTY
		_highScoreRow 1
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*14+2
		_setGameTile TILE_EMPTY
		_highScoreRow 2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*16+2
		_setGameTile TILE_EMPTY
		_highScoreRow 3
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*18+2
		_setGameTile TILE_EMPTY
		_highScoreRow 4
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*20+2
		_setGameTile TILE_EMPTY
		_highScoreRow 5
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*22+2
		_setGameTile TILE_EMPTY
		_highScoreRow 6
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*24+2
		_setGameTile TILE_EMPTY
		_highScoreRow 7
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*26+2
		_setGameTile TILE_EMPTY
		_highScoreRow 8
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*28+2
		_setGameTile TILE_EMPTY
		_highScoreRow 9
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		jmp staticGameBoard_Options

staticGameBoard_globalHighScores anop
		ldx #GAME_NUM_TILES_WIDE*8+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_G
		_setGameTile TILE_LETTER_L
		_setGameTile TILE_LETTER_O
		_setGameTile TILE_LETTER_B
		_setGameTile TILE_LETTER_A
		_setGameTile TILE_LETTER_L
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_H
		_setGameTile TILE_LETTER_I
		_setGameTile TILE_LETTER_G
		_setGameTile TILE_LETTER_H
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_LETTER_C
		_setGameTile TILE_LETTER_O
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_LETTER_E
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*10+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 0
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*12+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 1
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*14+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*16+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 3
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*18+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 4
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*20+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 5
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*22+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 6
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*24+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 7
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*26+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 8
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

		ldx #GAME_NUM_TILES_WIDE*28+2
		_setGameTile TILE_EMPTY
		_globalHighScoreRow 9
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY

staticGameBoard_Options anop
		ldx #GAME_NUM_TILES_WIDE*30+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*32+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_P
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_LETTER_E
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_SYMBOL_COLON
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*34+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_NUMBER_1
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_F
		_setGameTile TILE_LETTER_O
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_EMPTY
		_setGameTile TILE_NUMBER_1
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_P
		_setGameTile TILE_LETTER_L
		_setGameTile TILE_LETTER_A
		_setGameTile TILE_LETTER_Y
		_setGameTile TILE_LETTER_E
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*36+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_NUMBER_2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_F
		_setGameTile TILE_LETTER_O
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_EMPTY
		_setGameTile TILE_NUMBER_2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_P
		_setGameTile TILE_LETTER_L
		_setGameTile TILE_LETTER_A
		_setGameTile TILE_LETTER_Y
		_setGameTile TILE_LETTER_E
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*38+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_LETTER_W
		_setGameTile TILE_LETTER_A
		_setGameTile TILE_LETTER_P
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_S
		_setGameTile TILE_LETTER_T
		_setGameTile TILE_LETTER_E
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_LETTER_E
		_setGameTile TILE_LETTER_O
		_setGameTile TILE_EMPTY
		
		lda settings+SETTINGS_SWAP_STEREO_OFFSET
		bne staticGameBoard_swapped
		_setGameTile TILE_LETTER_L
		_setGameTile TILE_SYMBOL_COLON
		_setGameTile TILE_LETTER_R
		bra staticGameBoard_cont
staticGameBoard_swapped anop
		_setGameTile TILE_LETTER_R
		_setGameTile TILE_SYMBOL_COLON
		_setGameTile TILE_LETTER_L
staticGameBoard_cont anop
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		ldx #GAME_NUM_TILES_WIDE*40+2
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_Q
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_T
		_setGameTile TILE_LETTER_O
		_setGameTile TILE_EMPTY
		_setGameTile TILE_LETTER_Q
		_setGameTile TILE_LETTER_U
		_setGameTile TILE_LETTER_I
		_setGameTile TILE_LETTER_T
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		_setGameTile TILE_EMPTY
		
		rtl
		

checkKeyboard entry
checkKey_loop2 anop
        short i,m
        lda >KEYBOARD
        bpl checkKey_done
        sta >KEYBOARD_STROBE
        long i,m
        and #$007f
		
		ldx gameState
		bne checkKey_pause
        
        cmp #'q'
        beq checkKey_quit
        cmp #'Q'
        beq checkKey_quit

		cmp #'1'
		beq checkKey_game
		
		cmp #'2'
		beq checkKey_game
		
		cmp #'s'
		beq checkKey_swapStereo
		cmp #'S'
		beq checkKey_swapStereo
        
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
		
checkKey_swapStereo anop
		jsl swapStereoSettings
		jmp staticGameBoard


waitForKey entry
        short m
waitForKey_loop anop
        lda >KEYBOARD
        bpl waitForKey_loop
        sta >KEYBOARD_STROBE
        long m
		and #$7f
        rtl


waitForBeam entry
beamLoop anop
        lda >VERTICAL_COUNTER     ; load the counter value
        and #$80ff                ; mask out the VBL bits
        asl a                     ; shift the word around
        adc #0                    ; move MSB -> LSB
        cmp #$1c8
        bge beamLoop
        rtl

		
waitForVbl entry
vblLoop1 anop
		short m
		lda #$fe
		cmp >READ_VBL
		bpl vblLoop1
vblLoop2 anop
		cmp >READ_VBL
		bmi vblLoop2
		long m
		rtl
        
        
shouldQuit      dc i2'1'
borderColour    dc i2'0'
frameCount 		dc i2'0'
shouldPreloadSound	dc i2'0'
displayGlobalHighScores dc i2'0'
highScoreCountdown dc i2'0'

        end
