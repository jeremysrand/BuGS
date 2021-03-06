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

scores start spriteSeg
        using globalData

score300 entry
        _spriteHeader
 
; $1 - Green
; $2 - Red
; $3 - Off-white
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
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$00f0
        ora #$3303
        sta $2,s
        
        lda $4,s
        and #$00f0
        ora #$3303
        sta $4,s
        
        lda $a0,s
        and #$f0ff
        ora #$0300
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0303
        sta $a2,s
        
        lda $a4,s
        and #$f0f0
        ora #$0303
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$f0f0
        ora #$0303
        sta $2,s
        
        lda $4,s
        and #$f0f0
        ora #$0303
        sta $4,s
        
        lda $a0,s
        and #$f0ff
        ora #$0300
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0303
        sta $a2,s
        
        lda $a4,s
        and #$f0f0
        ora #$0303
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$00f0
        ora #$3303
        sta $2,s
        
        lda $4,s
        and #$00f0
        ora #$3303
        sta $4,s
        
        _spriteFooter
        rtl


score600 entry
        _spriteHeader
 
; $1 - Green
; $2 - Red
; $3 - Off-white
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
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$00f0
        ora #$3303
        sta $2,s
        
        lda $4,s
        and #$00f0
        ora #$3303
        sta $4,s
        
        lda $a0,s
        and #$fff0
        ora #$0003
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0303
        sta $a2,s
        
        lda $a4,s
        and #$f0f0
        ora #$0303
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$f0f0
        ora #$0303
        sta $2,s
        
        lda $4,s
        and #$f0f0
        ora #$0303
        sta $4,s
        
        lda $a0,s
        and #$f0f0
        ora #$0303
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0303
        sta $a2,s
        
        lda $a4,s
        and #$f0f0
        ora #$0303
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$00f0
        ora #$3303
        sta $2,s
        
        lda $4,s
        and #$00f0
        ora #$3303
        sta $4,s
        
        _spriteFooter
        rtl


score900 entry
        _spriteHeader
 
; $1 - Green
; $2 - Red
; $3 - Off-white
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
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$00f0
        ora #$3303
        sta $2,s
        
        lda $4,s
        and #$00f0
        ora #$3303
        sta $4,s
        
        lda $a0,s
        and #$f0f0
        ora #$0303
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0303
        sta $a2,s
        
        lda $a4,s
        and #$f0f0
        ora #$0303
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$f0f0
        ora #$0303
        sta $2,s
        
        lda $4,s
        and #$f0f0
        ora #$0303
        sta $4,s
        
        lda $a0,s
        and #$f0ff
        ora #$0300
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0303
        sta $a2,s
        
        lda $a4,s
        and #$f0f0
        ora #$0303
        sta $a4,s
        
        tsc
        adc #$0140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$3303
        sta $0,s
        
        lda $2,s
        and #$00f0
        ora #$3303
        sta $2,s
        
        lda $4,s
        and #$00f0
        ora #$3303
        sta $4,s
        
        _spriteFooter
        rtl

        end
