;
;  segments.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-03.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy segments.macros
        keep segments

segments start

left_head1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|....
; .RRG|G...
; GRRG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GRRG|GG..
; .RRG|G...
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $a1,s
        and #$00f0
        ora #$4c04
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$142
        tcs
        
        pea $4cc4
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda #$cccc
        sta $a1,s

        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$142
        tcs
        
        pea $cccc

        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda #$4cc4
        sta $a1,s

        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$4c04
        sta $1,s
        
        lda $3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $3,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl


left_head1s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|O...
; ..RR|GG..
; .GRR|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GRR|GGG.
; ..RR|GG..
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00ff
        ora #$4400
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$440c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda #$cccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda #$cccc
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$440c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
        and #$00ff
        ora #$4400
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'

        end
