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
        jsl clearScreen
        jsl waitForKey
        rtl
        
        
clearScreen entry
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
        
        lda #$9cfe
        tcs
        ldy #$7d00
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
