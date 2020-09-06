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
        
        jsl setupScreen
        
        lda colourPalette
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
        
        short i,m
        lda >BORDER_COLOUR_REGISTER
        and #$f7
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
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
        
        short i,m
        lda >BORDER_COLOUR_REGISTER
        and #$f3
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
        jsl drawSpider
        
        short i,m
        lda >BORDER_COLOUR_REGISTER
        and #$f1
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
        jsl drawFlea
        
        short i,m
        lda >BORDER_COLOUR_REGISTER
        ora #$08
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
        jsl drawSegments
        
        short i,m
        lda >BORDER_COLOUR_REGISTER
        ora #$04
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
        jsl drawDirtyNonGameTiles
        
        short i,m
        lda >BORDER_COLOUR_REGISTER
        ora #$02
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
        jsl updateScorpion
        jsl updateSpider
        jsl updateFlea
        jsl updateSegments
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
        


checkKeyboard entry
checkKey_loop2 anop
        short i,m
        lda >KEYBOARD
        bpl checkKey_done
        sta >KEYBOARD_STROBE
        long i,m
        and #$007f
        
        cmp #'q'
        beq checkKey_quit
        cmp #'Q'
        beq checkKey_quit
        cmp #$001b
        beq checkKey_quit
        
        cmp #'f'
        beq checkKey_addFlea
        cmp #'F'
        beq checkKey_shootFlea
        
        cmp #'s'
        beq checkKey_addScorpion
        cmp #'S'
        beq checkKey_shootScorpion
        
        cmp #'p'
        beq checkKey_addSpider
        cmp #'P'
        beq checkKey_shootSpider
        
        cmp #'+'
        beq checkKey_fast
        cmp #'-'
        beq checkKey_slow
        
        cmp #'c'
        beq checkKey_centipede
        
        lda colourPalette
        inc a
        cmp #NUM_COLOUR_PALETTES
        blt checkKey_skip
        lda #$0000
checkKey_skip anop
        sta colourPalette
        jmp setColour
        
checkKey_done anop
        rtl
        
checkKey_addFlea anop
        jmp addFlea
        
checkKey_shootFlea anop
        jmp shootFlea
        
checkKey_addScorpion anop
        jmp addScorpion
        
checkKey_shootScorpion anop
        jmp shootScorpion
        
checkKey_addSpider anop
        jmp addSpider
        
checkKey_shootSpider anop
        jmp shootSpider
                
checkKey_quit anop
        stz shouldQuit
        rtl
        
checkKey_fast anop
        lda #SPRITE_SPEED_FAST
        jsl setFleaSpeed
        lda #SPRITE_SPEED_FAST
        jsl setSpiderSpeed
        lda #SPRITE_SPEED_FAST
        jmp setScorpionSpeed

checkKey_slow anop
        lda #SPRITE_SPEED_SLOW
        jsl setFleaSpeed
        lda #SPRITE_SPEED_SLOW
        jsl setSpiderSpeed
        lda #SPRITE_SPEED_SLOW
        jmp setScorpionSpeed

checkKey_centipede anop
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jsl addHeadSegment
        jmp addHeadSegment
;        jmp addBodySegment


waitForKey entry
        short i,m
waitForKey_loop anop
        lda >KEYBOARD
        bpl waitForKey_loop
        sta >KEYBOARD_STROBE
        long i,m
        rtl


waitForVbl entry
        short i,m
        lda >BORDER_COLOUR_REGISTER
        and #$f0
        sta >BORDER_COLOUR_REGISTER
        long i,m
vblLoop anop
        lda >VERTICAL_COUNTER     ; load the counter value
        and #$80ff                ; mask out the VBL bits
        asl a                     ; shift the word around
        adc #0                    ; move MSB -> LSB
        cmp #$1c8
        bge vblLoop
        rtl
        
        
colourPalette       dc i2'0'
shouldQuit          dc i2'1'
borderColour        dc i2'0'

        end
