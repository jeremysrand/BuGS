;
;  scores.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy scores.macros
        keep scores

scores start

score300 entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|....
; ....|....|....
; .OOO|.OOO|.OOO
; ...O|.O.O|.O.O
; .OOO|.O.O|.O.O
; ...O|.O.O|.O.O
; .OOO|.OOO|.OOO
; ....|....|....
;
        tsc
        adc #$013a
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
;        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
;        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
;        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        _spriteFooter
        rtl


score600 entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|....
; ....|....|....
; .OOO|.OOO|.OOO
; .O..|.O.O|.O.O
; .OOO|.O.O|.O.O
; .O.O|.O.O|.O.O
; .OOO|.OOO|.OOO
; ....|....|....
;
        
        tsc
        adc #$013a
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
;        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
;        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
;        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
;        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        _spriteFooter
        rtl


score900 entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|....
; ....|....|....
; .OOO|.OOO|.OOO
; .O.O|.O.O|.O.O
; .OOO|.O.O|.O.O
; ...O|.O.O|.O.O
; .OOO|.OOO|.OOO
; ....|....|....
;

        tsc
        adc #$013a
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
;        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
;        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
;        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
;        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
;        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
;        and #$00f0
        ora #$8808
        sta $5,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'


        end
