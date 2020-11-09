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

ship start spriteSeg
        using globalData

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

        stz collision
        
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

        stz collision

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
        ora #$4408
        sta $a0,s
        
        lda $a2,s
        _collision #$cccc
        lda #$4884
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        _collision #$cc0c
        and #$00f0
        ora #$8808
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
        
; This differs from the above by being a tile draw routine for drawing the number of lives left.
; It assumes it is drawing to the background and overwrites what may be there and does not check
; for collisions
drawPlayer entry
        _spriteHeader
        
; $1 - Green
; $2 - Red
; $3 - Off-white
;
; ...O|....
; ..OO|O...
; .RRO|RR..
; ORRO|RRO.
; OOOO|OOO.
; .OOO|OO..
; ..OO|O...
; ..OO|O...
;
; Colours #$0000 - Black, Black, Black, Black (x1)
;         #$0300 - Black, Black, Black, Off-white (x1)
;         #$3300 - Black, Black, Off-white, Off-white (x3)
;         #$0030 - Off-white, Black, Black, Black (x3)
;         #$2302 - Black, Red, Red, Off-white (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$2332 - Off-white, Red, Red, Off-white (x1)
;         #$3022 - Red, Red, Off-white, Black (x1)
;         #$3333 - Off-white, Off-white, Off-white, Off-white (x1)
;         #$3033 - Off-white, Off-white, Off-white, Black (x1)
;         #$3303 - Black, Off-white, Off-white, Off-white (x1)
;         #$0033 - Off-white, Off-white, Black, Black (x1)

        pea $0000
        pea $0300
        
        adc #$00a0
        tcs
        
        pea $0030
        pea $3300
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2302
        
        adc #$00a0
        tcs
        
        pea $3022
        pea $2332
        
        adc #$00a0
        tcs
        
        pea $3033
        pea $3333
        
        adc #$00a0
        tcs
        
        pea $0033
        pea $3303
        
        adc #$00a0
        tcs
        
        pea $0030
        pea $3300
        
        adc #$00a0
        tcs
        
        pea $0030
        pea $3300

        _spriteFooter
        rtl
        
        
collision   dc i2'0'
        
        end
