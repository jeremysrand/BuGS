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

scorpions start spriteSeg
        using globalData

leftScorpion1 entry
        iny
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
        
        lda $0,s
;        and #$0f0f
        ora #$8080
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8404
        sta $2,s
        
        lda $4,s
;        and #$0fff
        ora #$8000
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda #$8444
        sta $a2,s
        
        lda $a4,s
;        and #$f00f
        ora #$0840
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0ff0
        ora #$8008
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00ff
        ora #$8800
        sta $4,s
        
        lda $6,s
;        and #$00f0
        ora #$8808
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        tya
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$8088
        sta $a4,s
        
        lda $a6,s
;        and #$f0f0
        ora #$0808
        sta $a6,s
        
        tsc
        adc #$142
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $4,s
;        and #$f0ff
        ora #$0800
        sta $4,s
        
        lda $a0,s
;        and #$00f0
        ora #$8808
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f
        ora #$0080
        sta $a2,s
        
        lda $a4,s
;        and #$00ff
        ora #$8800
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a4,s
;        and #$0f00
        ora #$8088
        sta $a4,s
        
        tya
        sta $2,s
        sta $4,s
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftScorpion1s entry
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
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$4048
        sta $4,s
        
        lda $6,s
;        and #$f0f0
        ora #$0808
        sta $6,s
        
        lda $a2,s
;        and #$f00f
        ora #$0480
        sta $a2,s
        
        lda #$4448
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$142
        tcs
        
        lda $0,s
;        and #$ff00
        ora #$0088
        sta $0,s
        
        lda $2,s
;        and #$0f00
        ora #$8088
        sta $2,s
        
        lda $4,s
;        and #$0ff0
        ora #$8008
        sta $4,s
        
        lda $6,s
;        and #$0f00
        ora #$8088
        sta $6,s
        
        lda $a0,s
;        and #$00f0
        ora #$8808
        sta $a0,s
        
        tya
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0088
        sta $a4,s
        
        lda $a6,s
;        and #$0f0f
        ora #$8080
        sta $a6,s
        
        tsc
        adc #$142
        tcs
        
        tya
        sta $0,s
        sta $a0,s
        
        lda $4,s
;        and #$0fff
        ora #$8000
        sta $4,s
        
        lda $a4,s
;        and #$0ff0
        ora #$8008
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $4,s
;        and #$0f00
        ora #$8088
        sta $4,s
        
        lda $a0,s
;        and #$00f0
        ora #$8808
        sta $a0,s
        
        lda $a4,s
;        and #$ff00
        ora #$0088
        sta $a4,s
        
        tya
        sta $0,s
        sta $2,s
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftScorpion2 entry
        iny
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
        
        lda $0,s
;        and #$0f0f
        ora #$8080
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8404
        sta $2,s
        
        lda $4,s
;        and #$0fff
        ora #$8000
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda #$8444
        sta $a2,s
        
        lda $a4,s
;        and #$f00f
        ora #$0840
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0ff0
        ora #$8008
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00ff
        ora #$8800
        sta $4,s
        
        lda $6,s
;        and #$00f0
        ora #$8808
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
;        and #$00f0
        ora #$8808
        sta $a2,s
        
        lda $a4,s
;        and #$0ff0
        ora #$8008
        sta $a4,s
        
        lda $a6,s
;        and #$f0f0
        ora #$0808
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        tya
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0088
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a2,s
;        and #$00f0
        ora #$8808
        sta $a2,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        tsc
        adc #$142
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $4,s
;        and #$ff00
        ora #$0088
        sta $4,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a4,s
;        and #$ff0f
        ora #$0080
        sta $a4,s
        
        tya
        sta $2,s
        sta $a2,s
        
        _spriteFooter
        rtl


leftScorpion2s entry
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
        
       lda $0,s
;       and #$f0ff
       ora #$0800
       sta $0,s
       
       lda $2,s
;       and #$fff0
       ora #$0008
       sta $2,s
        
       lda $4,s
;       and #$0f00
       ora #$4048
       sta $4,s
        
       lda $6,s
;       and #$f0f0
       ora #$0808
       sta $6,s
       
       lda $a2,s
;       and #$f00f
       ora #$0480
       sta $a2,s
       
       lda #$4448
       sta $a4,s
       
       lda $a6,s
;       and #$0fff
       ora #$8000
       sta $a6,s
       
       tsc
       adc #$142
       tcs
       
       lda $0,s
;       and #$ff00
       ora #$0088
       sta $0,s
       
       lda $2,s
;       and #$0f00
       ora #$8088
       sta $2,s
       
       lda $4,s
;       and #$0ff0
       ora #$8008
       sta $4,s
       
       lda $6,s
;       and #$0f00
       ora #$8088
       sta $6,s
       
       lda $a0,s
;       and #$0ff0
       ora #$8008
       sta $a0,s
       
       lda $a2,s
;       and #$0f00
       ora #$8088
       sta $a2,s
       
       lda $a4,s
;       and #$ff00
       ora #$0088
       sta $a4,s
       
       lda $a6,s
;       and #$0f0f
       ora #$8080
       sta $a6,s
       
       tsc
       adc #$140
       tcs
       
       lda $0,s
;       and #$00ff
       ora #$8800
       sta $0,s
       
       tya
       sta $2,s
       
       lda $4,s
;       and #$ff0f
       ora #$0080
       sta $4,s
       
       lda $6,s
;       and #$ff0f
       ora #$0080
       sta $6,s
       
       lda $a2,s
;       and #$0f00
       ora #$8088
       sta $a2,s
       
       lda $a4,s
;       and #$f0ff
       ora #$0800
       sta $a4,s
       
       lda $a6,s
;       and #$ff0f
       ora #$0080
       sta $a6,s
       
       tsc
       adc #$142
       tcs
       
       lda $4,s
;       and #$ff0f
       ora #$0080
       sta $4,s
       
       lda $a0,s
;       and #$00f0
       ora #$8808
       sta $a0,s
       
       tya
       sta $0,s
       sta $2,s
       sta $a2,s
       
       _spriteFooter
       rtl


leftScorpion3 entry
        iny
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
        
        lda $0,s
;        and #$0f0f
        ora #$8080
        sta $0,s
        
        lda $2,s
;        and #$0f00
        ora #$4048
        sta $2,s
        
        lda $4,s
;        and #$0f0f
        ora #$8080
        sta $4,s
        
        lda $a0,s
;        and #$f0f0
        ora #$0408
        sta $a0,s
        
        lda #$4448
        sta $a2,s
        
        lda $a4,s
;        and #$fff0
        ora #$0008
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0ff0
        ora #$8008
        sta $0,s
        
        lda $2,s
;        and #$0f00
        ora #$8088
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0088
        sta $4,s
        
        lda $6,s
;        and #$00ff
        ora #$8800
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        tya
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f
        ora #$0080
        sta $a4,s
        
        lda $a6,s
;        and #$f0f0
        ora #$0808
        sta $a6,s
        
        tsc
        adc #$142
        tcs
        
        lda $0,s
;        and #$0f00
        ora #$8088
        sta $0,s
        
        lda $4,s
;        and #$f000
        ora #$0888
        sta $4,s
        
        lda $a0,s
;        and #$0f00
        ora #$8088
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$8800
        sta $a2,s
        
        lda $a4,s
;        and #$f00f
        ora #$0880
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $4,s
;        and #$0fff
        ora #$8000
        sta $4,s
        
        lda $a0,s
;        and #$00f0
        ora #$8808
        sta $a0,s
        
        lda $a2,s
;        and #$0f00
        ora #$8088
        sta $a2,s
        
        tya
        sta $0,s
        sta $2,s
        
        _spriteFooter
        rtl


leftScorpion3s entry
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
        
       lda $0,s
;       and #$f0ff
       ora #$0800
       sta $0,s
       
       lda $2,s
;       and #$f0f0
       ora #$0408
       sta $2,s
        
       lda $4,s
;       and #$f000
       ora #$0884
       sta $4,s
        
       lda $6,s
;       and #$fff0
       ora #$0008
       sta $6,s
       
       lda $a2,s
;       and #$000f
       ora #$4480
       sta $a2,s
       
       lda $a4,s
;       and #$0f0
       ora #$4084
       sta $a4,s
       
       lda $a6,s
;       and #$ff0f
       ora #$0080
       sta $a6,s
    
       tsc
       adc #$142
       tcs
        
       lda $0,s
;       and #$f000
       ora #$0888
       sta $0,s
       
       lda $2,s
;       and #$f000
       ora #$0888
       sta $2,s
        
       lda $4,s
;       and #$ff0f
       ora #$0080
       sta $4,s
        
       lda $6,s
;       and #$0ff0
       ora #$8008
       sta $6,s
       
       lda $a0,s
;       and #$00f0
       ora #$8808
       sta $a0,s
       
       tya
       sta $a2,s
       
       lda $a6,s
;       and #$0f0f
       ora #$8080
       sta $a6,s
       
       tsc
       adc #$140
       tcs
       
       lda $0,s
;       and #$f0ff
       ora #$0800
       sta $0,s
       
       lda $2,s
;       and #$ff00
       ora #$0088
       sta $2,s
       
       lda $4,s
;       and #$f0ff
       ora #$0800
       sta $4,s
       
       lda $6,s
;       and #$0f0f
       ora #$8080
       sta $6,s
       
       lda $a0,s
;       and #$f0ff
       ora #$0800
       sta $a0,s
       
       lda $a2,s
;       and #$ff00
       ora #$088
       sta $a2,s
       
       lda $a4,s
;       and #$00f0
       ora #$8808
       sta $a4,s
       
       lda $a6,s
;       and #$0fff
       ora #$8000
       sta $a6,s
       
       tsc
       adc #$140
       tcs
       
       lda $0,s
;       and #$f0ff
       ora #$0800
       sta $0,s
       
       lda $4,s
;       and #$0f00
       ora #$8088
       sta $4,s
       
       lda $6,s
;       and #$fff0
       ora #$0008
       sta $6,s
       
       lda $a4,s
;       and #$ff00
       ora #$0088
       sta $a4,s
       
       tya
       sta $2,s
       sta $a2,s
       
       _spriteFooter
       rtl


leftScorpion4 entry
        iny
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
        
        lda $0,s
;        and #$0f0f
        ora #$8080
        sta $0,s
        
        lda $2,s
;        and #$0f00
        ora #$4048
        sta $2,s
        
        lda $4,s
;        and #$0f0f
        ora #$8080
        sta $4,s
        
        lda $a0,s
;        and #$f0f0
        ora #$0408
        sta $a0,s
        
        lda #$4448
        sta $a2,s
        
        lda $a4,s
;        and #$fff0
        ora #$0008
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0ff0
        ora #$8008
        sta $0,s
        
        lda $2,s
;        and #$0f00
        ora #$8088
        sta $2,s
        
        lda $4,s
;        and #$f000
        ora #$0888
        sta $4,s
        
        lda $6,s
;        and #$0ff0
        ora #$8008
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        tya
        sta $a2,s
        
        lda $a4,s
;        and #$f00f
        ora #$0880
        sta $a4,s
        
        lda $a6,s
;        and #$00ff
        ora #$8800
        sta $a6,s
        
        tsc
        adc #$142
        tcs
        
        lda $0,s
;        and #$0f00
        ora #$8088
        sta $0,s
        
        lda $4,s
;        and #$f00f
        ora #$0880
        sta $4,s
        
        lda $a0,s
;        and #$0f00
        ora #$8088
        sta $a0,s
        
        lda $a4,s
;        and #$f0ff
        ora #$0800
        sta $a4,s
        
        tsc
        adc #$145
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


leftScorpion4s entry
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
        
       lda $0,s
;       and #$f0ff
       ora #$0800
       sta $0,s
       
       lda $2,s
;       and #$f0f0
       ora #$0408
       sta $2,s
        
       lda $4,s
;       and #$f000
       ora #$0884
       sta $4,s
        
       lda $6,s
;       and #$fff0
       ora #$0008
       sta $6,s
       
       lda $a2,s
;       and #$000f
       ora #$4480
       sta $a2,s
       
       lda $a4,s
;       and #$0f0
       ora #$4084
       sta $a4,s
       
       lda $a6,s
;       and #$f00f
       ora #$0880
       sta $a6,s
    
       tsc
       adc #$142
       tcs
        
       lda $0,s
;       and #$f000
       ora #$0888
       sta $0,s
       
       lda $2,s
;       and #$f000
       ora #$0888
       sta $2,s
        
       lda $4,s
;       and #$0f0f
       ora #$8080
       sta $4,s
        
       lda $6,s
;       and #$ff00
       ora #$0088
       sta $6,s
       
       lda $a0,s
;       and #$00f0
       ora #$8808
       sta $a0,s
       
       tya
       sta $a2,s
       
       lda $a4,s
;       and #$0fff
       ora #$8000
       sta $a4,s
       
       lda $a6,s
;       and #$0ff0
       ora #$8008
       sta $a6,s
       
       tsc
       adc #$140
       tcs
       
       lda $0,s
;       and #$f0ff
       ora #$0800
       sta $0,s
       
       lda $2,s
;       and #$ff00
       ora #$0088
       sta $2,s
       
       lda $4,s
;       and #$f0ff
       ora #$0800
       sta $4,s
       
       lda $6,s
;       and #$0fff
       ora #$8000
       sta $6,s
       
       lda $a0,s
;       and #$f0ff
       ora #$0800
       sta $a0,s
       
       lda $a2,s
;       and #$ff00
       ora #$0088
       sta $a2,s
       
       lda $a6,s
;       and #$0fff
       ora #$8000
       sta $a6,s
       
       tsc
       adc #$140
       tcs
       
       lda $0,s
;       and #$f0ff
       ora #$0800
       sta $0,s
       
       lda $6,s
;       and #$0f00
       ora #$8088
       sta $6,s
       
       lda $a6,s
;       and #$ff00
       ora #$0088
       sta $a6,s
       
       tya
       sta $2,s
       sta $4,s
       sta $a2,s
       sta $a4,s
       
       _spriteFooter
       rtl


rightScorpion1 entry
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
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$4048
        sta $4,s
        
        lda $6,s
;        and #$f0f0
        ora #$0808
        sta $6,s
        
        lda $a2,s
;        and #$f00f
        ora #$0480
        sta $a2,s
        
        lda #$4448
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0f00
        ora #$8088
        sta $0,s
        
        lda $2,s
;        and #$ff00
        ora #$0088
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$8088
        sta $4,s
        
        lda $6,s
;        and #$0ff0
        ora #$8008
        sta $6,s
        
        lda $a0,s
;        and #$0f0f
        ora #$8080
        sta $a0,s
        
        lda $a2,s
;        and #$00f0
        ora #$8808
        sta $a2,s
        
        tya
        sta $a4,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$ff0f
        ora #$0080
        sta $0,s
        
        lda $2,s
;        and #$f0ff
        ora #$0800
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$8088
        sta $4,s
        
        lda $a0,s
;        and #$ff00
        ora #$0088
        sta $a0,s
        
        lda $a2,s
;        and #$f0ff
        ora #$0800
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$8088
        sta $a4,s
        
        tsc
        adc #$143
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


rightScorpion1s entry
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
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $2,s
;        and #$f00f
        ora #$0480
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0084
        sta $4,s
        
        lda $6,s
;        and #$0f0f
        ora #$8080
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$4400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$4084
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$13e
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$f000
        ora #$0888
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$0880
        sta $4,s
        
        lda $6,s
;        and #$ff00
        ora #$0088
        sta $6,s
        
        lda $8,s
;        and #$ff00
        ora #$0088
        sta $8,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$fff0
        ora #$0008
        sta $a2,s
        
        tya
        sta $a4,s
        sta $a6,s
        
        lda $a8,s
;        and #$ff0f
        ora #$0080
        sta $a8,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $4,s
;        and #$00ff
        ora #$8800
        sta $4,s
        
        lda $6,s
;        and #$ff00
        ora #$0088
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f
        ora #$0080
        sta $a2,s
        
        lda $a4,s
;        and #$00ff
        ora #$8800
        sta $a4,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $6,s
;        and #$ff00
        ora #$0088
        sta $6,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tya
        sta $2,s
        sta $4,s
        sta $a2,s
        sta $a4,s
        
        _spriteFooter
        rtl


rightScorpion2 entry
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
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$4048
        sta $4,s
        
        lda $6,s
;        and #$f0f0
        ora #$0808
        sta $6,s
        
        lda $a2,s
;        and #$f00f
        ora #$0480
        sta $a2,s
        
        lda #$4448
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0f00
        ora #$8088
        sta $0,s
        
        lda $2,s
;        and #$ff00
        ora #$0088
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$8088
        sta $4,s
        
        lda $6,s
;        and #$0ff0
        ora #$8008
        sta $6,s
        
        lda $a0,s
;        and #$0f0f
        ora #$8080
        sta $a0,s
        
        lda $a2,s
;        and #$0ff0
        ora #$8008
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$8088
        sta $a4,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $2,s
;        and #$00ff
        ora #$8800
        sta $2,s
        
        tya
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a4,s
;        and #$0f00
        ora #$8088
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00ff
        ora #$8800
        sta $0,s
        
        lda $4,s
;        and #$0f00
        ora #$8088
        sta $4,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a4,s
;        and #$ff00
        ora #$0088
        sta $a4,s
        
        tya
        sta $2,s
        sta $a2,s
        
        _spriteFooter
        rtl


rightScorpion2s entry
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
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $2,s
;        and #$f00f
        ora #$0480
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0084
        sta $4,s
        
        lda $6,s
;        and #$0f0f
        ora #$8080
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$4400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$4084
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$13e
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$f000
        ora #$0888
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$0880
        sta $4,s
        
        lda $6,s
;        and #$ff00
        ora #$0088
        sta $6,s
        
        lda $8,s
;        and #$ff00
        ora #$0088
        sta $8,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$fff0
        ora #$0008
        sta $a2,s
        
        lda $a4,s
;        and #$f000
        ora #$0888
        sta $a4,s
        
        lda $a6,s
;        and #$f000
        ora #$0888
        sta $a6,s
        
        lda $a8,s
;        and #$ff0f
        ora #$0080
        sta $a8,s
        
        tsc
        adc #$142
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        tya
        sta $4,s
        
        lda $a0,s
;        and #$0ff0
        ora #$8008
        sta $a0,s
        
        lda $a2,s
;        and #$f0ff
        ora #$0800
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0088
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $4,s
;        and #$ff00
        ora #$0088
        sta $4,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a4,s
;        and #$ff0f
        ora #$0080
        sta $a4,s
        
        tya
        sta $2,s
        sta $a2,s
        
        _spriteFooter
        rtl


rightScorpion3 entry
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
        
        lda $2,s
;        and #$f0f0
        ora #$0808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8404
        sta $4,s
        
        lda $6,s
;        and #$f0f0
        ora #$0808
        sta $6,s
        
        lda $a2,s
;        and #$0fff
        ora #$8000
        sta $a2,s
        
        lda #$8444
        sta $a4,s
        
        lda $a6,s
;        and #$0f0f
        ora #$8040
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0f00
        ora #$8088
        sta $0,s
        
        lda $2,s
;        and #$00ff
        ora #$8800
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        lda $6,s
;        and #$0ff0
        ora #$8008
        sta $6,s
        
        lda $a0,s
;        and #$0f0f
        ora #$8080
        sta $a0,s
        
        lda $a2,s
;        and #$f0ff
        ora #$0800
        sta $a2,s
        
        tya
        sta $a4,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$000f
        ora #$8880
        sta $0,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        lda $a0,s
;        and #$f00f
        ora #$0880
        sta $a0,s
        
        lda $a2,s
;        and #$ff00
        ora #$0088
        sta $a2,s
        
        lda $a4,s
;        and #$00f0
        ora #$8808
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $a2,s
;        and #$00f0
        ora #$8808
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$8088
        sta $a4,s
        
        tya
        sta $2,s
        sta $4,s
        
        _spriteFooter
        rtl


rightScorpion3s entry
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
        
        lda $2,s
;        and #$0f0f
        ora #$8080
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$4048
        sta $4,s
        
        lda $6,s
;        and #$0f0f
        ora #$8080
        sta $6,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0408
        sta $a2,s
        
        lda #$4448
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$13e
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$ff00
        ora #$0088
        sta $2,s
        
        lda $4,s
;        and #$0ff0
        ora #$8008
        sta $4,s
        
        lda $6,s
;        and #$0f00
        ora #$8088
        sta $6,s
        
        lda $8,s
;        and #$ff00
        ora #$0088
        sta $8,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$fff0
        ora #$0008
        sta $a2,s
        
        lda $a4,s
;        and #$00ff
        ora #$8800
        sta $a4,s
        
        tya
        sta $a6,s
        
        lda $a8,s
;        and #$ff0f
        ora #$0080
        sta $a8,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$0ff0
        ora #$8008
        sta $2,s
        
        lda $6,s
;        and #$0f00
        ora #$8088
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$8800
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f
        ora #$0080
        sta $a4,s
        
        lda $a6,s
;        and #$0f00
        ora #$8088
        sta $a6,s
        
        tsc
        adc #$142
        tcs
        
        lda $0,s
;        and #$f00f
        ora #$0880
        sta $0,s
        
        lda $4,s
;        and #$0f00
        ora #$8088
        sta $4,s
        
        lda $a4,s
;        and #$ff00
        ora #$0088
        sta $a4,s
        
        tya
        sta $2,s
        sta $a2,s
        
        _spriteFooter
        rtl


rightScorpion4 entry
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
        
        lda $2,s
;        and #$f0f0
        ora #$0808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8404
        sta $4,s
        
        lda $6,s
;        and #$f0f0
        ora #$0808
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$0fff
        ora #$8000
        sta $a2,s
        
        lda #$8444
        sta $a4,s
        
        lda $a6,s
;        and #$0f0f
        ora #$8040
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0ff0
        ora #$8008
        sta $0,s
        
        lda $2,s
;        and #$000f
        ora #$8880
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        lda $6,s
;        and #$0ff0
        ora #$8008
        sta $6,s
        
        lda $a0,s
;        and #$ff00
        ora #$0088
        sta $a0,s
        
        lda $a2,s
;        and #$f00f
        ora #$0880
        sta $a2,s
        
        tya
        sta $a4,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f00f
        ora #$0880
        sta $0,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        lda $a0,s
;        and #$ff0f
        ora #$0080
        sta $a0,s
        
        lda $a4,s
;        and #$00f0
        ora #$8808
        sta $a4,s
        
        tsc
        adc #$145
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
        

rightScorpion4s entry
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
        
        lda $2,s
;        and #$0f0f
        ora #$8080
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$4048
        sta $4,s
        
        lda $6,s
;        and #$0f0f
        ora #$8080
        sta $6,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0408
        sta $a2,s
        
        lda #$4448
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$13e
        tcs
        
        lda $2,s
;        and #$f000
        ora #$0888
        sta $2,s
        
        lda $4,s
;        and #$0ff0
        ora #$8008
        sta $4,s
        
        lda $6,s
;        and #$0f00
        ora #$8088
        sta $6,s
        
        lda $8,s
;        and #$ff00
        ora #$0088
        sta $8,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$f00f
        ora #$0880
        sta $a2,s
        
        lda $a4,s
;        and #$00ff
        ora #$8800
        sta $a4,s
        
        tya
        sta $a6,s
        
        lda $a8,s
;        and #$ff0f
        ora #$0080
        sta $a8,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$0fff
        ora #$8000
        sta $2,s
        
        lda $6,s
;        and #$0f00
        ora #$8088
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a6,s
;        and #$0f00
        ora #$8088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $6,s
;        and #$0f00
        ora #$8088
        sta $6,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        tya
        sta $2,s
        sta $a2,s
        sta $4,s
        sta $a4,s
        
        _spriteFooter
        rtl

        end
