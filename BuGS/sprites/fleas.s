;
;  fleas.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy fleas.macros
        keep fleas

fleas start
        using globalData


flea1  entry
        _spriteHeader       ; 30
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OOG.|GOOO
; ....|..G.|G.OO
; ....|..G.|G.G.
; ....|.G.G|...G
;
        
        lda $0,s            ; 5
        and #$00ff          ; 3
        ora #$8800          ; 3
        sta $0,s            ; 5
; 46
        lda $2,s            ; 5
        and #$ff0f          ; 3
        ora #$0080          ; 3
        sta $2,s            ; 5
; 62
        lda $a0,s
        and #$00f0
        ora #$8804
        sta $a0,s
; 78
        lda $a2,s
        and #$ff00
        ora #$0088
        sta $a2,s
; 94
        tsc                 ; 2
        adc #$0141          ; 3
        tcs                 ; 2
; 101
        pea $8844           ; 5
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
; 122
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
; 138
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
; 155
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
; 171
        lda $a1,s
        and #$0f00
        ora #$c088
        sta $a1,s
; 187
        tsc
        adc #$00a4
        tcs
        pea $88c8
; 199
        lda $9f,s
        ora #$c000
        sta $9f,s
; 212
        lda $a1,s
        and #$000f
        ora #$88c0
        sta $a1,s
; 228
        tsc
        adc #$013e
        tcs
; 235
        lda $1,s
        ora #$c000
        sta $1,s
; 248
        lda $3,s
        ora #$c0c0
        sta $3,s
; 261
        lda $a1,s
        ora #$0c0c
        sta $a1,s
; 274
        lda $a3,s
        ora #$0c00
        sta $a3,s
; 287
        _spriteFooter
; 311 cycles
        rtl


flea2  entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OO.G|.OOO
; ....|..G.|.GOO
; ....|.G..|G..G
; ....|.G.G|..G.
;
        
        lda $0,s
        and #$00ff
        ora #$8800
        sta $0,s
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$8804
        sta $a0,s
        
        lda $a2,s
        and #$ff00
        ora #$0088
        sta $a2,s
        
        tsc
        adc #$0141
        tcs
        
        pea $8844
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        lda $a1,s
        and #$f000
        ora #$0c88
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$880c
        sta $3,s
        
        tsc
        adc #$00a0
        tcs
        
        lda $1,s
        ora #$000c
        sta $1,s
        
        lda $3,s
        ora #$0cc0
        sta $3,s
        
        lda $a1,s
        ora #$0c0c
        sta $a1,s
        
        lda $a3,s
        ora #$c000
        sta $a3,s
        
        _spriteFooter
        rtl
        

flea3  entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OO.G|.OOO
; ....|..G.|G.OO
; ....|..G.|.G.G
; ....|...G|..G.
;
        
        lda $0,s
        and #$00ff
        ora #$8800
        sta $0,s
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$8804
        sta $a0,s
        
        lda $a2,s
        and #$ff00
        ora #$0088
        sta $a2,s
        
        tsc
        adc #$0141
        tcs
        
        pea $8844
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        lda $a1,s
        and #$f000
        ora #$0c88
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        and #$000f
        ora #$88c0
        sta $3,s
        
        tsc
        adc #$00a0
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        ora #$0c0c
        sta $3,s
        
        lda $a1,s
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        ora #$c000
        sta $a3,s
        
        _spriteFooter
        rtl
        

flea4  entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OOG.|GOOO
; ....|..G.|G.OO
; ....|..G.|.G.G
; ....|...G|.G.G
;
        lda $0,s
        and #$00ff
        ora #$8800
        sta $0,s
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$8804
        sta $a0,s
        
        lda $a2,s
        and #$ff00
        ora #$0088
        sta $a2,s
        
        tsc
        adc #$0141
        tcs
        
        pea $8844
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$c088
        sta $a1,s
        
        tsc
        adc #$00a4
        tcs
        pea $88c8
        
        lda $9f,s
        ora #$c000
        sta $9f,s
        
        lda $a1,s
        and #$000f
        ora #$88c0
        sta $a1,s
        
        tsc
        adc #$013e
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        ora #$0c0c
        sta $3,s
        
        lda $a1,s
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        ora #$0c0c
        sta $a3,s
        
        _spriteFooter
        rtl

        end
