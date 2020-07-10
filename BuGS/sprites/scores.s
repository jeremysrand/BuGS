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
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0808
        sta $a2,s
        
        lda $a4,s
;        and #$f0f0
        ora #$0808
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$f0f0
        ora #$0808
        sta $2,s
        
        lda $4,s
;        and #$f0f0
        ora #$0808
        sta $4,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0808
        sta $a2,s
        
        lda $a4,s
;        and #$f0f0
        ora #$0808
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
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
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0808
        sta $a2,s
        
        lda $a4,s
;        and #$f0f0
        ora #$0808
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$f0f0
        ora #$0808
        sta $2,s
        
        lda $4,s
;        and #$f0f0
        ora #$0808
        sta $4,s
        
        lda $a0,s
;        and #$f0f0
        ora #$0808
        sta $a0,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0808
        sta $a2,s
        
        lda $a4,s
;        and #$f0f0
        ora #$0808
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
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
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        lda $a0,s
;        and #$f0f0
        ora #$0808
        sta $a0,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0808
        sta $a2,s
        
        lda $a4,s
;        and #$f0f0
        ora #$0808
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$f0f0
        ora #$0808
        sta $2,s
        
        lda $4,s
;        and #$f0f0
        ora #$0808
        sta $4,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$f0f0
        ora #$0808
        sta $a2,s
        
        lda $a4,s
;        and #$f0f0
        ora #$0808
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
;        and #$00f0
        ora #$8808
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$8808
        sta $2,s
        
        lda $4,s
;        and #$00f0
        ora #$8808
        sta $4,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'


        end
