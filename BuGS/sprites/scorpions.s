;
;  scorpions.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy scorpions.macros
        keep scorpions

scorpions start

left_scorpion1 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|.ROR|..O.|O...
; .O..|RROR|R..O|....
; .OO.|.OOO|..OO|.OOO
; ..OO|OOOO|OOO.|.O.O
; ....|.OOO|O...|...O
; ....|.OOO|O...|..OO
; ....|.OOO|OOOO|OOOO
; ....|..OO|OOOO|OOO.
;
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8404
        sta $3,s
        
        lda $5,s
;        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda #$8444
        sta $a3,s
        
        lda $a5,s
;        and #$f00f
        ora #$0840
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
;        and #$00f0
        ora #$8808
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        lda $a7,s
;        and #$f0f0
        ora #$0808
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $5,s
;        and #$f0ff
        ora #$0800
        sta $5,s
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a5,s
;        and #$00ff
        ora #$8800
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        tya
        sta $3,s
        sta $5,s
        sta $a3,s
        
        _spriteFooter
        rtl
        

left_scorpion1s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O|....
; ....|O..R|RORR|..O.|....
; ....|OO..|OOO.|.OO.|OOO.
; ....|.OOO|OOOO|OO..|O.O.
; ....|....|OOOO|....|..O.
; ....|....|OOOO|....|.OO.
; ....|....|OOOO|OOOO|OOO.
; ....|....|.OOO|OOOO|OO..
;

        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
;        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a3,s
;        and #$f00f
        ora #$0480
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
;        and #$ff00
        ora #$0088
        sta $1,s
        
        lda $3,s
;        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $5,s
;        and #$0ff0
        ora #$8008
        sta $5,s
        
        lda $7,s
;        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0088
        sta $a5,s
        
        lda $a7,s
;        and #$0f0f
        ora #$8080
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        tya
        sta $1,s
        sta $a1,s
        
        lda $5,s
;        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $a5,s
;        and #$0ff0
        ora #$8008
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $5,s
;        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a5,s
;        and #$ff00
        ora #$0088
        sta $a5,s
        
        tya
        sta $1,s
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl
        

left_scorpion2 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|.ROR|..O.|O...
; .O..|RROR|R..O|....
; .OO.|.OOO|..OO|.OOO
; ..OO|.OOO|.OO.|.O.O
; ...O|OOOO|OO..|.O..
; ....|.OOO|....|OO..
; ....|.OOO|OOOO|OO..
; ....|..OO|OOOO|O...
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8404
        sta $3,s
        
        lda $5,s
;        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda #$8444
        sta $a3,s
        
        lda $a5,s
;        and #$f00f
        ora #$0840
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
;        and #$00f0
        ora #$8808
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a3,s
;        and #$00f0
        ora #$8808
        sta $a3,s
        
        lda $a5,s
;        and #$0ff0
        ora #$8008
        sta $a5,s
        
        lda $a7,s
;        and #$f0f0
        ora #$0808
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        tya
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a3,s
;        and #$00f0
        ora #$8808
        sta $a3,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $5,s
;        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
;        and #$ff0f
        ora #$0080
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


left_scorpion2s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
       _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O|....
; ....|O..R|RORR|..O.|....
; ....|OO..|OOO.|.OO.|OOO.
; ....|.OO.|OOO.|OO..|O.O.
; ....|..OO|OOOO|O...|O...
; ....|....|OOO.|...O|O...
; ....|....|OOOO|OOOO|O...
; ....|....|.OOO|OOOO|....
;
       ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
       lda $1,s
;       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
;       and #$fff0
       ora #$0008
       sta $3,s
        
       lda $5,s
;       and #$0f00
       ora #$4048
       sta $5,s
        
       lda $7,s
;       and #$f0f0
       ora #$0808
       sta $7,s
       
       lda $a3,s
;       and #$f00f
       ora #$0480
       sta $a3,s
       
       lda #$4448
       sta $a5,s
       
       lda $a7,s
;       and #$0fff
       ora #$8000
       sta $a7,s
       
       tsc
       adc #$142
       tcs
       
       lda $1,s
;       and #$ff00
       ora #$0088
       sta $1,s
       
       lda $3,s
;       and #$0f00
       ora #$8088
       sta $3,s
       
       lda $5,s
;       and #$0ff0
       ora #$8008
       sta $5,s
       
       lda $7,s
;       and #$0f00
       ora #$8088
       sta $7,s
       
       lda $a1,s
;       and #$0ff0
       ora #$8008
       sta $a1,s
       
       lda $a3,s
;       and #$0f00
       ora #$8088
       sta $a3,s
       
       lda $a5,s
;       and #$ff00
       ora #$0088
       sta $a5,s
       
       lda $a7,s
;       and #$0f0f
       ora #$8080
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
;       and #$00ff
       ora #$8800
       sta $1,s
       
       tya
       sta $3,s
       
       lda $5,s
;       and #$ff0f
       ora #$0080
       sta $5,s
       
       lda $7,s
;       and #$ff0f
       ora #$0080
       sta $7,s
       
       lda $a3,s
;       and #$0f00
       ora #$8088
       sta $a3,s
       
       lda $a5,s
;       and #$f0ff
       ora #$0800
       sta $a5,s
       
       lda $a7,s
;       and #$ff0f
       ora #$0080
       sta $a7,s
       
       tsc
       adc #$142
       tcs
       
       lda $5,s
;       and #$ff0f
       ora #$0080
       sta $5,s
       
       lda $a1,s
;       and #$00f0
       ora #$8808
       sta $a1,s
       
       tya
       sta $1,s
       sta $3,s
       sta $a3,s
       
       _spriteFooter
       rtl


left_scorpion3 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|ROR.|O.O.|....
; .O.R|RORR|.O..|....
; .OO.|OOO.|OO..|..OO
; ..OO|OOOO|O...|.O.O
; ....|OOO.|....|OO.O
; ....|OOO.|..OO|O..O
; ....|OOOO|OOOO|..O.
; ....|.OOO|OOO.|....
;
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
;        and #$0f00
        ora #$4048
        sta $3,s
        
        lda $5,s
;        and #$0f0f
        ora #$8080
        sta $5,s
        
        lda $a1,s
;        and #$f0f0
        ora #$0408
        sta $a1,s
        
        lda #$4448
        sta $a3,s
        
        lda $a5,s
;        and #$fff0
        ora #$0008
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
;        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $7,s
;        and #$00ff
        ora #$8800
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f
        ora #$0080
        sta $a5,s
        
        lda $a7,s
;        and #$f0f0
        ora #$0808
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
;        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $5,s
;        and #$f000
        ora #$0888
        sta $5,s
        
        lda $a1,s
;        and #$0f00
        ora #$8088
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$8800
        sta $a3,s
        
        lda $a5,s
;        and #$f00f
        ora #$0880
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $5,s
;        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a3,s
;        and #$0f00
        ora #$8088
        sta $a3,s
        
        tya
        sta $1,s
        sta $3,s
        
        _spriteFooter
        rtl


left_scorpion3s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
       _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O.R|OR.O|.O..|....
; ....|O.RR|ORR.|O...|....
; ....|OO.O|OO.O|O...|.OO.
; ....|.OOO|OOOO|....|O.O.
; ....|...O|OO..|...O|O.O.
; ....|...O|OO..|.OOO|..O.
; ....|...O|OOOO|OOO.|.O..
; ....|....|OOOO|OO..|....
;
       ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
       lda $1,s
;       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
;       and #$f0f0
       ora #$0408
       sta $3,s
        
       lda $5,s
;       and #$f000
       ora #$0884
       sta $5,s
        
       lda $7,s
;       and #$fff0
       ora #$0008
       sta $7,s
       
       lda $a3,s
;       and #$000f
       ora #$4480
       sta $a3,s
       
       lda $a5,s
;       and #$0f0
       ora #$4084
       sta $a5,s
       
       lda $a7,s
;       and #$ff0f
       ora #$0080
       sta $a7,s
    
       tsc
       adc #$142
       tcs
        
       lda $1,s
;       and #$f000
       ora #$0888
       sta $1,s
       
       lda $3,s
;       and #$f000
       ora #$0888
       sta $3,s
        
       lda $5,s
;       and #$ff0f
       ora #$0080
       sta $5,s
        
       lda $7,s
;       and #$0ff0
       ora #$8008
       sta $7,s
       
       lda $a1,s
;       and #$00f0
       ora #$8808
       sta $a1,s
       
       tya
       sta $a3,s
       
       lda $a7,s
;       and #$0f0f
       ora #$8080
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
;       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
;       and #$ff00
       ora #$0088
       sta $3,s
       
       lda $5,s
;       and #$f0ff
       ora #$0800
       sta $5,s
       
       lda $7,s
;       and #$0f0f
       ora #$8080
       sta $7,s
       
       lda $a1,s
;       and #$f0ff
       ora #$0800
       sta $a1,s
       
       lda $a3,s
;       and #$ff00
       ora #$088
       sta $a3,s
       
       lda $a5,s
;       and #$00f0
       ora #$8808
       sta $a5,s
       
       lda $a7,s
;       and #$0fff
       ora #$8000
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
;       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $5,s
;       and #$0f00
       ora #$8088
       sta $5,s
       
       lda $7,s
;       and #$fff0
       ora #$0008
       sta $7,s
       
       lda $a5,s
;       and #$ff00
       ora #$0088
       sta $a5,s
       
       tya
       sta $3,s
       sta $a3,s
       
       _spriteFooter
       rtl


left_scorpion4 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|ROR.|O.O.|....
; .O.R|RORR|.O..|O...
; .OO.|OOO.|OO.O|.OO.
; ..OO|OOOO|O..O|..OO
; ....|OOO.|....|O..O
; ....|OOO.|....|...O
; ....|OOOO|OOOO|OOOO
; ....|.OOO|OOOO|OOO.
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
;        and #$0f00
        ora #$4048
        sta $3,s
        
        lda $5,s
;        and #$0f0f
        ora #$8080
        sta $5,s
        
        lda $a1,s
;        and #$f0f0
        ora #$0408
        sta $a1,s
        
        lda #$4448
        sta $a3,s
        
        lda $a5,s
;        and #$fff0
        ora #$0008
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
;        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $5,s
;        and #$f000
        ora #$0888
        sta $5,s
        
        lda $7,s
;        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
;        and #$f00f
        ora #$0880
        sta $a5,s
        
        lda $a7,s
;        and #$00ff
        ora #$8800
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
;        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $5,s
;        and #$f00f
        ora #$0880
        sta $5,s
        
        lda $a1,s
;        and #$0f00
        ora #$8088
        sta $a1,s
        
        lda $a5,s
;        and #$f0ff
        ora #$0800
        sta $a5,s
        
        tsc
        adc #$146
        tcs
        
        phy
        phy
        phy
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        _spriteFooter
        rtl


left_scorpion4s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
       _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O.R|OR.O|.O..|....
; ....|O.RR|ORR.|O..O|....
; ....|OO.O|OO.O|O.O.|OO..
; ....|.OOO|OOOO|..O.|.OO.
; ....|...O|OO..|...O|..O.
; ....|...O|OO..|....|..O.
; ....|...O|OOOO|OOOO|OOO.
; ....|....|OOOO|OOOO|OO..
;

       ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
       lda $1,s
;       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
;       and #$f0f0
       ora #$0408
       sta $3,s
        
       lda $5,s
;       and #$f000
       ora #$0884
       sta $5,s
        
       lda $7,s
;       and #$fff0
       ora #$0008
       sta $7,s
       
       lda $a3,s
;       and #$000f
       ora #$4480
       sta $a3,s
       
       lda $a5,s
;       and #$0f0
       ora #$4084
       sta $a5,s
       
       lda $a7,s
;       and #$f00f
       ora #$0880
       sta $a7,s
    
       tsc
       adc #$142
       tcs
        
       lda $1,s
;       and #$f000
       ora #$0888
       sta $1,s
       
       lda $3,s
;       and #$f000
       ora #$0888
       sta $3,s
        
       lda $5,s
;       and #$0f0f
       ora #$8080
       sta $5,s
        
       lda $7,s
;       and #$ff00
       ora #$0088
       sta $7,s
       
       lda $a1,s
;       and #$00f0
       ora #$8808
       sta $a1,s
       
       tya
       sta $a3,s
       
       lda $a5,s
;       and #$0fff
       ora #$8000
       sta $a5,s
       
       lda $a7,s
;       and #$0ff0
       ora #$8008
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
;       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
;       and #$ff00
       ora #$0088
       sta $3,s
       
       lda $5,s
;       and #$f0ff
       ora #$0800
       sta $5,s
       
       lda $7,s
;       and #$0fff
       ora #$8000
       sta $7,s
       
       lda $a1,s
;       and #$f0ff
       ora #$0800
       sta $a1,s
       
       lda $a3,s
;       and #$ff00
       ora #$0088
       sta $a3,s
       
       lda $a7,s
;       and #$0fff
       ora #$8000
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
;       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $7,s
;       and #$0f00
       ora #$8088
       sta $7,s
       
       lda $a7,s
;       and #$ff00
       ora #$0088
       sta $a7,s
       
       tya
       sta $3,s
       sta $5,s
       sta $a3,s
       sta $a5,s
       
       _spriteFooter
       rtl


right_scorpion1 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O
; ....|O..R|RORR|..O.
; OOO.|OO..|OOO.|.OO.
; O.O.|.OOO|OOOO|OO..
; O...|...O|OOO.|....
; OO..|...O|OOO.|....
; OOOO|OOOO|OOO.|....
; .OOO|OOOO|OO..|....
;

        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
;        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a3,s
;        and #$f00f
        ora #$0480
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $3,s
;        and #$ff00
        ora #$0088
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $7,s
;        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
;        and #$0f0f
        ora #$8080
        sta $a1,s
        
        lda $a3,s
;        and #$00f0
        ora #$8808
        sta $a3,s
        
        tya
        sta $a5,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda $3,s
;        and #$f0ff
        ora #$0800
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
;        and #$ff00
        ora #$0088
        sta $a1,s
        
        lda $a3,s
;        and #$f0ff
        ora #$0800
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        tsc
        adc #$144
        tcs
        
        phy
        phy
        
        lda $5,s
;        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0088
        sta $a5,s
        
        _spriteFooter
        rtl


right_scorpion1s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..O.|O..R|OR..|O.O.
; ....|...O|..RR|ORR.|.O..
; ...O|OO.O|O..O|OO..|OO..
; ...O|.O..|OOOO|OOOO|O...
; ...O|....|..OO|OO..|....
; ...O|O...|..OO|OO..|....
; ...O|OOOO|OOOO|OO..|....
; ....|OOOO|OOOO|O...|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
;        and #$f00f
        ora #$0480
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0084
        sta $5,s
        
        lda $7,s
;        and #$0f0f
        ora #$8080
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$4400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$4084
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$f000
        ora #$0888
        sta $3,s
        
        lda $5,s
;        and #$f00f
        ora #$0880
        sta $5,s
        
        lda $7,s
;        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $9,s
;        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$fff0
        ora #$0008
        sta $a3,s
        
        tya
        sta $a5,s
        sta $a7,s
        
        lda $a9,s
;        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $5,s
;        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
;        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a5,s
;        and #$00ff
        ora #$8800
        sta $a5,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $7,s
;        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tya
        sta $3,s
        sta $5,s
        sta $a3,s
        sta $a5,s
        
        _spriteFooter
        rtl


right_scorpion2 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O
; ....|O..R|RORR|..O.
; OOO.|OO..|OOO.|.OO.
; O.O.|.OO.|OOO.|OO..
; ..O.|..OO|OOOO|O...
; ..OO|....|OOO.|....
; ..OO|OOOO|OOO.|....
; ...O|OOOO|OO..|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
;        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a3,s
;        and #$f00f
        ora #$0480
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $3,s
;        and #$ff00
        ora #$0088
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $7,s
;        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
;        and #$0f0f
        ora #$8080
        sta $a1,s
        
        lda $a3,s
;        and #$0ff0
        ora #$8008
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
;        and #$00ff
        ora #$8800
        sta $3,s
        
        tya
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $5,s
;        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a5,s
;        and #$ff00
        ora #$0088
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


right_scorpion2s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..O.|O..R|OR..|O.O.
; ....|...O|..RR|ORR.|.O..
; ...O|OO.O|O..O|OO..|OO..
; ...O|.O..|OO.O|OO.O|O...
; ....|.O..|.OOO|OOOO|....
; ....|.OO.|...O|OO..|....
; ....|.OOO|OOOO|OO..|....
; ....|..OO|OOOO|O...|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
;        and #$f00f
        ora #$0480
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0084
        sta $5,s
        
        lda $7,s
;        and #$0f0f
        ora #$8080
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$4400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$4084
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$f000
        ora #$0888
        sta $3,s
        
        lda $5,s
;        and #$f00f
        ora #$0880
        sta $5,s
        
        lda $7,s
;        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $9,s
;        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$fff0
        ora #$0008
        sta $a3,s
        
        lda $a5,s
;        and #$f000
        ora #$0888
        sta $a5,s
        
        lda $a7,s
;        and #$f000
        ora #$0888
        sta $a7,s
        
        lda $a9,s
;        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        tya
        sta $5,s
        
        lda $a1,s
;        and #$0ff0
        ora #$8008
        sta $a1,s
        
        lda $a3,s
;        and #$f0ff
        ora #$0800
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0088
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $5,s
;        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
;        and #$ff0f
        ora #$0080
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


right_scorpion3 entry
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|.O.O|.ROR|.O.O
; ....|..O.|RROR|R.O.
; OOO.|..OO|.OOO|.OO.
; O.O.|...O|OOOO|OO..
; O.OO|....|.OOO|....
; O..O|OO..|.OOO|....
; .O..|OOOO|OOOO|....
; ....|.OOO|OOO.|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$f0f0
        ora #$0808
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8404
        sta $3,s
        
        lda $5,s
;        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda #$8444
        sta $a3,s
        
        lda $a5,s
;        and #$0f0f
        ora #$8040
        sta $a5,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
;        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $3,s
;        and #$00ff
        ora #$8800
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $7,s
;        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
;        and #$0f0f
        ora #$8080
        sta $a1,s
        
        lda $a3,s
;        and #$f0ff
        ora #$0800
        sta $a3,s
        
        tya
        sta $a5,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$000f
        ora #$8880
        sta $1,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
;        and #$f00f
        ora #$0880
        sta $a1,s
        
        lda $a3,s
;        and #$ff00
        ora #$0088
        sta $a3,s
        
        lda $a5,s
;        and #$00f0
        ora #$8808
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $a3,s
;        and #$00f0
        ora #$8808
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        tya
        sta $3,s
        sta $5,s
        
        _spriteFooter
        rtl


right_scorpion3s entry
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|O.O.|ROR.|O.O.
; ....|....|.O.R|RORR|.O..
; ...O|OO..|.OO.|OOO.|OO..
; ...O|.O..|..OO|OOOO|O...
; ...O|.OO.|....|OOO.|....
; ...O|..OO|O...|OOO.|....
; ....|O..O|OOOO|OOO.|....
; ....|....|OOOO|OO..|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
;        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
;        and #$0f00
        ora #$4048
        sta $3,s
        
        lda $5,s
;        and #$0f0f
        ora #$8080
        sta $5,s
        
        lda $a1,s
;        and #$f0f0
        ora #$0408
        sta $a1,s
        
        lda #$4448
        sta $a3,s
        
        lda $a5,s
;        and #$fff0
        ora #$0008
        sta $a5,s
        
        tsc
        adc #$13c
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$ff00
        ora #$0088
        sta $3,s
        
        lda $5,s
;        and #$0ff0
        ora #$8008
        sta $5,s
        
        lda $7,s
;        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $9,s
;        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$fff0
        ora #$0008
        sta $a3,s
        
        lda $a5,s
;        and #$00ff
        ora #$8800
        sta $a5,s
        
        tya
        sta $a7,s
        
        lda $a9,s
;        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$0ff0
        ora #$8008
        sta $3,s
        
        lda $7,s
;        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$8800
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f
        ora #$0080
        sta $a5,s
        
        lda $a7,s
;        and #$0f00
        ora #$8088
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
;        and #$f00f
        ora #$0880
        sta $1,s
        
        lda $5,s
;        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a5,s
;        and #$ff00
        ora #$0088
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


right_scorpion4 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|.O.O|.ROR|.O.O
; ...O|..O.|RROR|R.O.
; .OO.|O.OO|.OOO|.OO.
; OO..|O..O|OOOO|OO..
; O..O|....|.OOO|....
; O...|....|.OOO|....
; OOOO|OOOO|OOOO|....
; .OOO|OOOO|OOO.|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $3,s
;        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8404
        sta $5,s
        
        lda $7,s
;        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$0fff
        ora #$8000
        sta $a3,s
        
        lda #$8444
        sta $a5,s
        
        lda $a7,s
;        and #$0f0f
        ora #$8040
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
;        and #$000f
        ora #$8880
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $7,s
;        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
;        and #$ff00
        ora #$0088
        sta $a1,s
        
        lda $a3,s
;        and #$f00f
        ora #$0880
        sta $a3,s
        
        tya
        sta $a5,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f00f
        ora #$0880
        sta $1,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
;        and #$ff0f
        ora #$0080
        sta $a1,s
        
        lda $a5,s
;        and #$00f0
        ora #$8808
        sta $a5,s
        
        tsc
        adc #$146
        tcs
        
        phy
        phy
        phy
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a5,s
;        and #$0f00
        ora #$8088
        sta $a5,s
        
        tya
        sta $a3,s
        
        _spriteFooter
        rtl
        

right_scorpion4s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|O.O.|ROR.|O.O.
; ....|..O.|.O.R|RORR|.O..
; ....|OO.O|.OO.|OOO.|OO..
; ...O|O..O|..OO|OOOO|O...
; ...O|..O.|....|OOO.|....
; ...O|....|....|OOO.|....
; ...O|OOOO|OOOO|OOO.|....
; ....|OOOO|OOOO|OO..|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $3,s
;        and #$0f0f
        ora #$8080
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
;        and #$0f0f
        ora #$8080
        sta $7,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0
        ora #$0408
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$13e
        tcs
        
        lda $3,s
;        and #$f000
        ora #$0888
        sta $3,s
        
        lda $5,s
;        and #$0ff0
        ora #$8008
        sta $5,s
        
        lda $7,s
;        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $9,s
;        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$f00f
        ora #$0880
        sta $a3,s
        
        lda $a5,s
;        and #$00ff
        ora #$8800
        sta $a5,s
        
        tya
        sta $a7,s
        
        lda $a9,s
;        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$0fff
        ora #$8000
        sta $3,s
        
        lda $7,s
;        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a7,s
;        and #$0f00
        ora #$8088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $7,s
;        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        tya
        sta $3,s
        sta $a3,s
        sta $5,s
        sta $a5,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'

        end
