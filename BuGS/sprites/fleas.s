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


flea1  entry
        dex
        dex
        dex
        dex
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
; ....|..G.|G.G.
; ....|.G.G|...G
;
        
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
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
        ora #$c0c0
        sta $3,s
        
        lda $a1,s
        ora #$0c0c
        sta $a1,s
        
        lda $a3,s
        ora #$0c00
        sta $a3,s
        
        _spriteFooter
        rtl
        

flea2  entry
        dex
        dex
        dex
        dex
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
        
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
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
        dex
        dex
        dex
        dex
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
        
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
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
        dex
        dex
        dex
        dex
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
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
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


backupStack dc i2'0'

        end
