;
;  game.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-06-10.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy game.macros
        keep game

game    start
        jsl setupScreen
        
        lda #0
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
        short i,m
loop    anop
        lda $e0c000
        bpl loop
        sta $e0c010
        long i,m
        rtl
        
backupStack dc i2'0'

        end
