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
        
        ldx #$3463
        jsl flea1
        
        ldx #$346b
        jsl flea2
        
        ldx #$3473
        jsl flea3
        
        ldx #$347b
        jsl flea4
        
        ldx #$3483
        jsl score300
        
        ldx #$348b
        jsl score600
        
        ldx #$3493
        jsl score900
        
        ldx #$3e0b
        jsl leftScorpion1
        
        ldx #$3e1b
        jsl leftScorpion1s
        
        ldx #$3e2b
        jsl leftScorpion2
        
        ldx #$3e3b
        jsl leftScorpion2s
        
        ldx #$3e4b
        jsl leftScorpion3
        
        ldx #$3e5b
        jsl leftScorpion3s
        
        ldx #$3e6b
        jsl leftScorpion4
        
        ldx #$3e7b
        jsl leftScorpion4s
        
        ldx #$480b
        jsl rightScorpion1
        
        ldx #$481b
        jsl rightScorpion1s
        
        ldx #$482b
        jsl rightScorpion2
        
        ldx #$483b
        jsl rightScorpion2s
        
        ldx #$484b
        jsl rightScorpion3
        
        ldx #$485b
        jsl rightScorpion3s
        
        ldx #$486b
        jsl rightScorpion4
        
        ldx #$487b
        jsl rightScorpion4s
        
        ldx #$520b
        jsl spider1
        
        ldx #$521b
        jsl spider1s
        
        ldx #$522b
        jsl spider2
        
        ldx #$523b
        jsl spider2s
        
        ldx #$524b
        jsl spider3
        
        ldx #$525b
        jsl spider3s
        
        ldx #$526b
        jsl spider4
        
        ldx #$527b
        jsl spider4s
        
        ldx #$528b
        jsl spider5
        
        ldx #$529b
        jsl spider5s
        
        ldx #$5c0b
        jsl spider6
        
        ldx #$5c1b
        jsl spider6s
        
        ldx #$5c2b
        jsl spider7
        
        ldx #$5c3b
        jsl spider7s
        
        ldx #$5c43
        jsl explosion1
        
        ldx #$5c4b
        jsl explosion2
        
        ldx #$5c53
        jsl explosion3
        
        ldx #$5c5b
        jsl explosion4
        
        ldx #$5c63
        jsl explosion5
        
        ldx #$5c6b
        jsl explosion6
        
        ldx #$5c73
        jsl leftHead1
        
        ldx #$5c7b
        jsl leftHead1s
        
        ldx #$5c83
        jsl leftHead2
        
        ldx #$5c8b
        jsl leftHead2s
        
        ldx #$5c93
        jsl leftHead3
        
        ldx #$5c9b
        jsl leftHead3s
        
        ldx #$6603
        jsl leftHead4
        
        ldx #$660b
        jsl leftHead4s
        
        ldx #$6613
        jsl leftHead5
        
        ldx #$661b
        jsl leftHead5s
        
        jsl waitForKey
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
        
backupStack dc i2'0'
colourPalette dc i2'0'

        end
