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
        jsl setupScreen
        
        lda colourPalette
        jsl setColour
        
        jsl drawDirtyGameTiles
        
        jsl drawDirtyNonGameTiles
        
        jsl waitForKey
        rtl


drawDirtyGameTiles entry
        ldy #$0
dirtyTileLoop anop
        cpy numDirtyGameTiles
        blt handleDirtyTile
        stz numDirtyGameTiles
        rtl
handleDirtyTile anop
        phy
        tya
        asl a
        tay
        
        lda dirtyGameTiles,y
        asl a
        asl a
        asl a
        tax
        
        stz tiles,x
        
        txy
        iny
        iny
        
        ldx tiles,y
        
        iny
        iny
        
        lda tiles,y
        
        jsl drawTile
        
        ply
        iny
        bra dirtyTileLoop
        

drawDirtyNonGameTiles entry
        ldy #$0
dirtyTileLoop2 anop
        cpy numDirtyNonGameTiles
        blt handleDirtyTile2
        stz numDirtyNonGameTiles
        rtl
handleDirtyTile2 anop
        phy
        tya
        asl a
        tay
        
        lda dirtyNonGameTiles,y
        asl a
        asl a
        asl a
        tax
        
        stz tiles,x
        
        txy
        iny
        iny
        
        ldx tiles,y
        
        iny
        iny
        
        lda tiles,y
        
        jsl drawTile
        
        ply
        iny
        bra dirtyTileLoop2

drawTile entry
        asl a
        asl a
        tay
        
        lda tileJumpTable,y
        sta jumpInst+1
        iny
        iny
        
        lda tileJumpTable,y
        sta jumpInst+3
        
jumpInst jmp >mushroom1
        nop
        

drawAll entry
        ldx #$2003
        jsl mushroom1
        
        ldx #$200b
        jsl mushroom2
        
        ldx #$2013
        jsl mushroom3
        
        ldx #$201b
        jsl mushroom4
        
        ldx #$2023
        jsl poisonedMushroom1
        
        ldx #$202b
        jsl poisonedMushroom2
        
        ldx #$2033
        jsl poisonedMushroom3
        
        ldx #$203b
        jsl poisonedMushroom4
        
        ldx #$2043
        jsl letterA
        
        ldx #$204b
        jsl letterB
        
        ldx #$2053
        jsl letterC
        
        ldx #$205b
        jsl letterD
        
        ldx #$2063
        jsl letterE
        
        ldx #$206b
        jsl letterF
        
        ldx #$2073
        jsl letterG
        
        ldx #$207b
        jsl letterH
        
        ldx #$2083
        jsl letterI
        
        ldx #$208b
        jsl letterJ
        
        ldx #$2093
        jsl letterK
        
        ldx #$209b
        jsl letterL
        
        ldx #$2a03
        jsl letterM
        
        ldx #$2a0b
        jsl letterN
        
        ldx #$2a13
        jsl letterO
        
        ldx #$2a1b
        jsl letterP
        
        ldx #$2a23
        jsl letterQ
        
        ldx #$2a2b
        jsl letterR
        
        ldx #$2a33
        jsl letterS
        
        ldx #$2a3b
        jsl letterT
        
        ldx #$2a43
        jsl letterU
        
        ldx #$2a4b
        jsl letterV
        
        ldx #$2a53
        jsl letterW
        
        ldx #$2a5b
        jsl letterX
        
        ldx #$2a63
        jsl letterY
        
        ldx #$2a6b
        jsl letterZ
        
        ldx #$2a73
        jsl symbolC
        
        ldx #$2a7b
        jsl symbolP
        
        ldx #$2a83
        jsl symbolDot
        
        ldx #$2a8b
        jsl symbolColon
        
        ldx #$2a93
        jsl solid0
        
        ldx #$2a9b
        jsl solid1
        
        ldx #$3403
        jsl solid2
        
        ldx #$340b
        jsl solid3
        
        ldx #$3413
        jsl number0
        
        ldx #$341b
        jsl number1
        
        ldx #$3423
        jsl number2
        
        ldx #$342b
        jsl number3
        
        ldx #$3433
        jsl number4
        
        ldx #$343b
        jsl number5
        
        ldx #$3443
        jsl number6
        
        ldx #$344b
        jsl number7
        
        ldx #$3453
        jsl number8
        
        ldx #$345b
        jsl number9
        
        ldx #$345f
        jsl flea1
        
        ldx #$3467
        jsl flea2
        
        ldx #$346f
        jsl flea3
        
        ldx #$3477
        jsl flea4
        
        ldx #$347e
        jsl score300
        
        ldx #$3486
        jsl score600
        
        ldx #$348e
        jsl score900
        
        ldx #$3e04
        jsl leftScorpion1
        
        ldx #$3e14
        jsl leftScorpion1s
        
        ldx #$3e24
        jsl leftScorpion2
        
        ldx #$3e34
        jsl leftScorpion2s
        
        ldx #$3e44
        jsl leftScorpion3
        
        ldx #$3e54
        jsl leftScorpion3s
        
        ldx #$3e64
        jsl leftScorpion4
        
        ldx #$3e74
        jsl leftScorpion4s
        
        ldx #$4804
        jsl rightScorpion1
        
        ldx #$4814
        jsl rightScorpion1s
        
        ldx #$4824
        jsl rightScorpion2
        
        ldx #$4834
        jsl rightScorpion2s
        
        ldx #$4844
        jsl rightScorpion3
        
        ldx #$4854
        jsl rightScorpion3s
        
        ldx #$4864
        jsl rightScorpion4
        
        ldx #$4874
        jsl rightScorpion4s
        
        ldx #$5204
        jsl spider1
        
        ldx #$5214
        jsl spider1s
        
        ldx #$5224
        jsl spider2
        
        ldx #$5234
        jsl spider2s
        
        ldx #$5244
        jsl spider3
        
        ldx #$5254
        jsl spider3s
        
        ldx #$5264
        jsl spider4
        
        ldx #$5274
        jsl spider4s
        
        ldx #$5284
        jsl spider5
        
        ldx #$5294
        jsl spider5s
        
        ldx #$5c04
        jsl spider6
        
        ldx #$5c14
        jsl spider6s
        
        ldx #$5c24
        jsl spider7
        
        ldx #$5c34
        jsl spider7s
        
        ldx #$5c40
        jsl explosion1
        
        ldx #$5c48
        jsl explosion2
        
        ldx #$5c50
        jsl explosion3
        
        ldx #$5c58
        jsl explosion4
        
        ldx #$5c60
        jsl explosion5
        
        ldx #$5c68
        jsl explosion6
        
        ldx #$5c70
        jsl leftHead1
        
        ldx #$5c78
        jsl leftHead1s
        
        ldx #$5c80
        jsl leftHead2
        
        ldx #$5c88
        jsl leftHead2s
        
        ldx #$5c90
        jsl leftHead3
        
        ldx #$5c98
        jsl leftHead3s
        
        ldx #$6600
        jsl leftHead4
        
        ldx #$6608
        jsl leftHead4s
        
        ldx #$6610
        jsl leftHead5
        
        ldx #$6618
        jsl leftHead5s
        
        ldx #$6620
        jsl leftBody1
        
        ldx #$6628
        jsl leftBody1s
        
        ldx #$6630
        jsl leftBody2
        
        ldx #$6638
        jsl leftBody2s
        
        ldx #$6640
        jsl leftBody3
        
        ldx #$6648
        jsl leftBody3s
        
        ldx #$6650
        jsl leftBody4
        
        ldx #$6658
        jsl leftBody4s
        
        ldx #$6660
        jsl leftBody5
        
        ldx #$6668
        jsl leftBody5s
        
        ldx #$6670
        jsl rightHead1
        
        ldx #$6678
        jsl rightHead1s
        
        ldx #$6680
        jsl rightHead2
        
        ldx #$6688
        jsl rightHead2s
        
        ldx #$6690
        jsl rightHead3
        
        ldx #$6698
        jsl rightHead3s
        
        ldx #$7000
        jsl rightHead4
        
        ldx #$7008
        jsl rightHead4s
        
        ldx #$7010
        jsl rightHead5
        
        ldx #$7018
        jsl rightHead5s
        
        ldx #$7020
        jsl rightBody1
        
        ldx #$7028
        jsl rightBody1s
        
        ldx #$7030
        jsl rightBody2
        
        ldx #$7038
        jsl rightBody2s
        
        ldx #$7040
        jsl rightBody3
        
        ldx #$7048
        jsl rightBody3s
        
        ldx #$7050
        jsl rightBody4
        
        ldx #$7058
        jsl rightBody4s
        
        ldx #$7060
        jsl rightBody5
        
        ldx #$7068
        jsl rightBody5s
        
        ldx #$7070
        jsl leftDownHead1
        
        ldx #$7078
        jsl leftDownHead1s
        
        ldx #$7080
        jsl leftDownHead2
        
        ldx #$7088
        jsl leftDownHead2s
        
        ldx #$7090
        jsl leftDownBody1
        
        ldx #$7098
        jsl leftDownBody1s
        
        ldx #$7a00
        jsl leftDownBody2
        
        ldx #$7a08
        jsl leftDownBody2s
        
        ldx #$7a10
        jsl rightDownHead1
        
        ldx #$7a18
        jsl rightDownHead1s
        
        ldx #$7a20
        jsl rightDownHead2
        
        ldx #$7a28
        jsl rightDownHead2s
        
        ldx #$7a30
        jsl rightDownBody1
        
        ldx #$7a38
        jsl rightDownBody1s
        
        ldx #$7a40
        jsl rightDownBody2
        
        ldx #$7a48
        jsl rightDownBody2s
        
        ldx #$7a50
        jsl downHead1
        
        ldx #$7a58
        jsl downHead2
        
        ldx #$7a60
        jsl downHead3
        
        ldx #$7a68
        jsl downBody1
        
        ldx #$7a70
        jsl downBody2
        
        ldx #$7a78
        jsl downBody3
        
        ldx #$7a80
        jsl drawShip
        
        ldx #$7a88
        jsl drawShipShift
        
        ldx #$7a90
        jsl drawHalfShot
        
        ldx #$7a98
        jsl drawHalfShotShift
        
        ldx #$8400
        jsl drawShot
        
        ldx #$8408
        jsl drawShotShift
        
        rtl
        
        
setupScreen entry
        short i,m
        lda $e0c035     ; Enable shadowing of SHR
        and #$f7
        sta $e0c035
        
        lda #$a1
        sta $e0c029     ; Enable SHR mode
        long i,m
        
        sei
        phd
        tsc
        sta backupStack
        lda $e1c068      ; Direct Page and Stack in Bank 01/
        ora #$0030
        sta $e1c068
        ldx #$0000
        
        lda #$9dfe
        tcs
        ldy #$7e00
nextWord anop
        phx
        dey
        dey
        bpl nextWord
        
        lda $e1c068
        and #$ffcf
        sta $e1c068
        lda backupStack
        tcs
        pld
        cli
        
        rtl
        

waitForKey entry
loop2   short i,m
loop1   anop
        lda $e0c000
        bpl loop1
        sta $e0c010
        long i,m
        and #$007f
        cmp #$0051
        beq quit
        cmp #$0071
        beq quit
        cmp #$001b
        beq quit
        lda colourPalette
        inc a
        cmp #$000e
        blt skip
        lda #$0000
skip    sta colourPalette
        jsl setColour
        bra loop2
quit    rtl


waitForVbl entry
        short i,m
vblLoop1 anop
        lda $e0c019
        bmi vblLoop1
vblLoop2 anop
        lda $e0c019
        bmi vblLoop2
        long i,m
        rtl
        
        
backupStack dc i2'0'
colourPalette dc i2'0'

tileJumpTable dc a4'solid0'
              dc a4'mushroom4'
              dc a4'mushroom3'
              dc a4'mushroom2'
              dc a4'mushroom1'
              dc a4'symbolC'
              dc a4'symbolP'
              dc a4'symbolDot'
              dc a4'symbolColon'
              dc a4'poisonedMushroom4'
              dc a4'poisonedMushroom3'
              dc a4'poisonedMushroom2'
              dc a4'poisonedMushroom1'
              dc a4'letterA'
              dc a4'letterB'
              dc a4'letterC'
              dc a4'letterD'
              dc a4'letterE'
              dc a4'letterF'
              dc a4'letterG'
              dc a4'letterH'
              dc a4'letterI'
              dc a4'letterJ'
              dc a4'letterK'
              dc a4'letterL'
              dc a4'letterM'
              dc a4'letterN'
              dc a4'letterO'
              dc a4'letterP'
              dc a4'letterQ'
              dc a4'letterR'
              dc a4'letterS'
              dc a4'letterT'
              dc a4'letterU'
              dc a4'letterV'
              dc a4'letterW'
              dc a4'letterX'
              dc a4'letterY'
              dc a4'letterZ'
              dc a4'number0'
              dc a4'number1'
              dc a4'number2'
              dc a4'number3'
              dc a4'number4'
              dc a4'number5'
              dc a4'number6'
              dc a4'number7'
              dc a4'number8'
              dc a4'number9'
              dc a4'solid1'
              dc a4'solid2'
              dc a4'solid3'
              dc a4'drawPlayer'

        end
