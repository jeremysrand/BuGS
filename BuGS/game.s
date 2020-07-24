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
        jsl drawDirtyGameTiles
        jsl drawScorpion
        jsl drawSpider
        jsl drawFlea
        jsl drawDirtyNonGameTiles
        
        jsl updateScorpion
        jsl updateSpider
        jsl updateFlea
        jsl checkKeyboard
        
        jsl waitForVbl
        
        lda shouldQuit
        bne gameLoop
        
        short i,m
        lda >BORDER_COLOUR_REGISTER
        and #$f0
        ora borderColour
        sta >BORDER_COLOUR_REGISTER
        long i,m
        
        rtl


drawDirtyGameTiles entry
        ldy numDirtyGameTiles
        beq dirtyTileLoopDone
dirtyTileLoop anop
        dey
        dey
        phy
        
        ldx dirtyGameTiles,y
        stz tiles+TILE_DIRTY_OFFSET,x
        ldy tiles+TILE_SCREEN_OFFSET_OFFSET,x
        lda tiles+TILE_TYPE_OFFSET,x
        
        jsl drawTile
        
        ply
        bne dirtyTileLoop
dirtyTileLoopDone anop
        stz numDirtyGameTiles
        rtl
        

drawDirtyNonGameTiles entry
        ldy numDirtyNonGameTiles
        beq dirtyTileLoopDone2
dirtyTileLoop2 anop
        dey
        dey
        phy
        
        ldx dirtyNonGameTiles,y
        stz tiles+TILE_DIRTY_OFFSET,x
        ldy tiles+TILE_SCREEN_OFFSET_OFFSET,x
        lda tiles+TILE_TYPE_OFFSET,x
        
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
        

drawAll entry
        ldy #$2003
        jsl mushroom1
        
        ldy #$200b
        jsl mushroom2
        
        ldy #$2013
        jsl mushroom3
        
        ldy #$201b
        jsl mushroom4
        
        ldy #$2023
        jsl poisonedMushroom1
        
        ldy #$202b
        jsl poisonedMushroom2
        
        ldy #$2033
        jsl poisonedMushroom3
        
        ldy #$203b
        jsl poisonedMushroom4
        
        ldy #$2043
        jsl letterA
        
        ldy #$204b
        jsl letterB
        
        ldy #$2053
        jsl letterC
        
        ldy #$205b
        jsl letterD
        
        ldy #$2063
        jsl letterE
        
        ldy #$206b
        jsl letterF
        
        ldy #$2073
        jsl letterG
        
        ldy #$207b
        jsl letterH
        
        ldy #$2083
        jsl letterI
        
        ldy #$208b
        jsl letterJ
        
        ldy #$2093
        jsl letterK
        
        ldy #$209b
        jsl letterL
        
        ldy #$2a03
        jsl letterM
        
        ldy #$2a0b
        jsl letterN
        
        ldy #$2a13
        jsl letterO
        
        ldy #$2a1b
        jsl letterP
        
        ldy #$2a23
        jsl letterQ
        
        ldy #$2a2b
        jsl letterR
        
        ldy #$2a33
        jsl letterS
        
        ldy #$2a3b
        jsl letterT
        
        ldy #$2a43
        jsl letterU
        
        ldy #$2a4b
        jsl letterV
        
        ldy #$2a53
        jsl letterW
        
        ldy #$2a5b
        jsl letterX
        
        ldy #$2a63
        jsl letterY
        
        ldy #$2a6b
        jsl letterZ
        
        ldy #$2a73
        jsl symbolC
        
        ldy #$2a7b
        jsl symbolP
        
        ldy #$2a83
        jsl symbolDot
        
        ldy #$2a8b
        jsl symbolColon
        
        ldy #$2a93
        jsl solid0
        
        ldy #$2a9b
        jsl solid1
        
        ldy #$3403
        jsl solid2
        
        ldy #$340b
        jsl solid3
        
        ldy #$3413
        jsl number0
        
        ldy #$341b
        jsl number1
        
        ldy #$3423
        jsl number2
        
        ldy #$342b
        jsl number3
        
        ldy #$3433
        jsl number4
        
        ldy #$343b
        jsl number5
        
        ldy #$3443
        jsl number6
        
        ldy #$344b
        jsl number7
        
        ldy #$3453
        jsl number8
        
        ldy #$345b
        jsl number9
        
        ldy #$345f
        jsl flea1
        
        ldy #$3467
        jsl flea2
        
        ldy #$346f
        jsl flea3
        
        ldy #$3477
        jsl flea4
        
        ldy #$347e
        jsl score300
        
        ldy #$3486
        jsl score600
        
        ldy #$348e
        jsl score900
        
        ldy #$3e04
        jsl leftScorpion1
        
        ldy #$3e14
        jsl leftScorpion1s
        
        ldy #$3e24
        jsl leftScorpion2
        
        ldy #$3e34
        jsl leftScorpion2s
        
        ldy #$3e44
        jsl leftScorpion3
        
        ldy #$3e54
        jsl leftScorpion3s
        
        ldy #$3e64
        jsl leftScorpion4
        
        ldy #$3e74
        jsl leftScorpion4s
        
        ldy #$4804
        jsl rightScorpion1
        
        ldy #$4814
        jsl rightScorpion1s
        
        ldy #$4824
        jsl rightScorpion2
        
        ldy #$4834
        jsl rightScorpion2s
        
        ldy #$4844
        jsl rightScorpion3
        
        ldy #$4854
        jsl rightScorpion3s
        
        ldy #$4864
        jsl rightScorpion4
        
        ldy #$4874
        jsl rightScorpion4s
        
        ldy #$5204
        jsl spider1
        
        ldy #$5214
        jsl spider1s
        
        ldy #$5224
        jsl spider2
        
        ldy #$5234
        jsl spider2s
        
        ldy #$5244
        jsl spider3
        
        ldy #$5254
        jsl spider3s
        
        ldy #$5264
        jsl spider4
        
        ldy #$5274
        jsl spider4s
        
        ldy #$5284
        jsl spider5
        
        ldy #$5294
        jsl spider5s
        
        ldy #$5c04
        jsl spider6
        
        ldy #$5c14
        jsl spider6s
        
        ldy #$5c24
        jsl spider7
        
        ldy #$5c34
        jsl spider7s
        
        ldy #$5c40
        jsl explosion1
        
        ldy #$5c48
        jsl explosion2
        
        ldy #$5c50
        jsl explosion3
        
        ldy #$5c58
        jsl explosion4
        
        ldy #$5c60
        jsl explosion5
        
        ldy #$5c68
        jsl explosion6
        
        ldy #$5c70
        jsl leftHead1
        
        ldy #$5c78
        jsl leftHead1s
        
        ldy #$5c80
        jsl leftHead2
        
        ldy #$5c88
        jsl leftHead2s
        
        ldy #$5c90
        jsl leftHead3
        
        ldy #$5c98
        jsl leftHead3s
        
        ldy #$6600
        jsl leftHead4
        
        ldy #$6608
        jsl leftHead4s
        
        ldy #$6610
        jsl leftHead5
        
        ldy #$6618
        jsl leftHead5s
        
        ldy #$6620
        jsl leftBody1
        
        ldy #$6628
        jsl leftBody1s
        
        ldy #$6630
        jsl leftBody2
        
        ldy #$6638
        jsl leftBody2s
        
        ldy #$6640
        jsl leftBody3
        
        ldy #$6648
        jsl leftBody3s
        
        ldy #$6650
        jsl leftBody4
        
        ldy #$6658
        jsl leftBody4s
        
        ldy #$6660
        jsl leftBody5
        
        ldy #$6668
        jsl leftBody5s
        
        ldy #$6670
        jsl rightHead1
        
        ldy #$6678
        jsl rightHead1s
        
        ldy #$6680
        jsl rightHead2
        
        ldy #$6688
        jsl rightHead2s
        
        ldy #$6690
        jsl rightHead3
        
        ldy #$6698
        jsl rightHead3s
        
        ldy #$7000
        jsl rightHead4
        
        ldy #$7008
        jsl rightHead4s
        
        ldy #$7010
        jsl rightHead5
        
        ldy #$7018
        jsl rightHead5s
        
        ldy #$7020
        jsl rightBody1
        
        ldy #$7028
        jsl rightBody1s
        
        ldy #$7030
        jsl rightBody2
        
        ldy #$7038
        jsl rightBody2s
        
        ldy #$7040
        jsl rightBody3
        
        ldy #$7048
        jsl rightBody3s
        
        ldy #$7050
        jsl rightBody4
        
        ldy #$7058
        jsl rightBody4s
        
        ldy #$7060
        jsl rightBody5
        
        ldy #$7068
        jsl rightBody5s
        
        ldy #$7070
        jsl leftDownHead1
        
        ldy #$7078
        jsl leftDownHead1s
        
        ldy #$7080
        jsl leftDownHead2
        
        ldy #$7088
        jsl leftDownHead2s
        
        ldy #$7090
        jsl leftDownBody1
        
        ldy #$7098
        jsl leftDownBody1s
        
        ldy #$7a00
        jsl leftDownBody2
        
        ldy #$7a08
        jsl leftDownBody2s
        
        ldy #$7a10
        jsl rightDownHead1
        
        ldy #$7a18
        jsl rightDownHead1s
        
        ldy #$7a20
        jsl rightDownHead2
        
        ldy #$7a28
        jsl rightDownHead2s
        
        ldy #$7a30
        jsl rightDownBody1
        
        ldy #$7a38
        jsl rightDownBody1s
        
        ldy #$7a40
        jsl rightDownBody2
        
        ldy #$7a48
        jsl rightDownBody2s
        
        ldy #$7a50
        jsl downHead1
        
        ldy #$7a58
        jsl downHead2
        
        ldy #$7a60
        jsl downHead3
        
        ldy #$7a68
        jsl downBody1
        
        ldy #$7a70
        jsl downBody2
        
        ldy #$7a78
        jsl downBody3
        
        ldy #$7a80
        jsl drawShip
        
        ldy #$7a88
        jsl drawShipShift
        
        ldy #$7a90
        jsl drawHalfShot
        
        ldy #$7a98
        jsl drawHalfShotShift
        
        ldy #$8400
        jsl drawShot
        
        ldy #$8408
        jsl drawShotShift
        
        rtl
        
        
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
        
        lda colourPalette
        inc a
        cmp #NUM_COLOUR_PALETTES
        blt checkKey_skip
        lda #$0000
checkKey_skip anop
        sta colourPalette
        jmp setColour
        
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
        
checkKey_done anop
        rtl


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
vblLoop1 anop
        lda #$fe
        cmp >READ_VBL
        bpl vblLoop1
vblLoop2 anop
        cmp >READ_VBL
        bmi vblLoop2
        lda >BORDER_COLOUR_REGISTER
        ora #$0f
        sta >BORDER_COLOUR_REGISTER
        long i,m
        rtl
        
        
colourPalette       dc i2'0'
shouldQuit          dc i2'1'
borderColour        dc i2'0'

        end
