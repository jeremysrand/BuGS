;
;  ship.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-09.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;
        
        case on
        mcopy ship.macros
        keep ship

ship start

drawShip entry
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|....
; ..OO|O...
; .RRO|RR..
; ORRO|RRO.
; OOOO|OOO.
; .OOO|OO..
; ..OO|O...
; ..OO|O...

        lda $0,s
        _collision #$0c00
        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $a0,s
        _collision #$cc00
        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
        _collision #$00c0
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        _collision #$cc0c
        and #$00f0
        ora #$4804
        sta $0,s

        lda $2,s
        _collision #$00cc
        and #$ff00
        ora #$0044
        sta $2,s
        
        lda $a0,s
        _collision #$cccc
        lda #$4884
        sta $a0,s
        
        lda $a2,s
        _collision #$c0cc
        and #$0f00
        ora #$8044
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $a0,s
        _collision #$cccc
        lda #$8888
        sta $0,s

        lda $2,s
        _collision #$c0cc
        and #$0f00
        ora #$8088
        sta $2,s
        
        lda $a0,s
        _collision #$cc0c
        and #$00f0
        ora #$8808
        sta $a0,s
        
        lda $a2,s
        _collision #$00cc
        and #$ff00
        ora #$0088
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        _collision #$cc00
        and #$00ff
        ora #$8800
        sta $0,s

        lda $2,s
        _collision #$00c0
        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $a0,s
        _collision #$cc00
        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
        _collision #$00c0
        and #$ff0f
        ora #$0080
        sta $a2,s

        _spriteFooter
        
        lda collision
        rtl
        

drawShipShift entry
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|O...
; ...O|OO..
; ..RR|ORR.
; .ORR|ORRO
; .OOO|OOOO
; ..OO|OOO.
; ...O|OO..
; ...O|OO..

        lda $2,s
        _collision #$00c0
        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $a0,s
        _collision #$0c00
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
        _collision #$00cc
        and #$ff00
        ora #$0088
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        _collision #$cc00
        and #$00ff
        ora #$4400
        sta $0,s

        lda $2,s
        _collision #$c0cc
        and #$0f00
        ora #$4084
        sta $2,s
        
        lda $a0,s
        _collision #$cc0c
        and #$00f0
        lda #$4408
        sta $a0,s
        
        lda $a2,s
        _collision #$cccc
        lda #$4884
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $a0,s
        _collision #$cc0c
        and #$00f0
        lda #$8808
        sta $0,s

        lda $2,s
        _collision #$cccc
        lda #$8888
        sta $2,s
        
        lda $a0,s
        _collision #$cc00
        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
        _collision #$c0cc
        and #$0f00
        ora #$8088
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        _collision #$0c00
        and #$f0ff
        ora #$0800
        sta $0,s

        lda $2,s
        _collision #$00cc
        and #$ff00
        ora #$0088
        sta $2,s
        
        lda $a0,s
        _collision #$0c00
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
        _collision #$00cc
        and #$ff00
        ora #$0088
        sta $a2,s

        _spriteFooter
        
        lda collision
        rtl
        
        
clearShipCollision entry
        lda #$0000
        sta collision
        rtl
        
        
backupStack dc i2'0'
collision   dc i2'0'
        
        end
