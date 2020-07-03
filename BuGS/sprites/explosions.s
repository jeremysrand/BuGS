;
;  explosions.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy explosions.macros
        keep explosions

explosions start

explosion1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ..RR|.R..
; .OGR|G...
; .GGG|GGR.
; RGGG|GGO.
; RGG.|GGG.
; OGGG|GGOG
; .OGG|RGO.
; .ROR|.R.G
;
        
        lda $1,s
        and #$00ff
        ora #$4400
        sta $1,s
        
        lda $3,s
        and #$fff0
        ora #$0004
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$c408
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$ff0f     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$40cc
        sta $3,s
        

        lda #$cc4c
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$80cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0f00
        ora #$c04c
        sta $1,s
        
        lda $3,s
;        and #$fff0     not necessary with pure green
        ora #$c0cc
        sta $3,s

        lda #$cc8c
        sta $a1,s
        
        lda #$8ccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$cc08
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$804c
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8404
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0c04
        sta $a3,s
        
        _spriteFooter
        rtl


explosion2 entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ..GR|G.R.
; .GGG|GGRG
; OGGG|GGGO
; OGGO|OGGG
; OGGO|OGGO
; OGGG|GGGG
; OGGR|GGGO
; .G.R|.G..
;

        lda $1,s
        and #$00ff
        ora #$c400
        sta $1,s
        
        lda $3,s
        and #$0f0f
        ora #$40c0
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda #$4ccc
        sta $a3,s
        
        tsc
        adc #$144
        tcs
        
        pea $c8cc
        pea $cc8c
        
        adc #$a0
        tcs
        
        pea $cc8c
        pea $c88c
        
        adc #$a0
        tcs
        
        pea $c88c
        pea $c88c
        
        adc #$a0
        tcs
        
        pea $cccc
        pea $cc8c
        
        adc #$a0
        tcs
        
        pea $c8cc
        pea $c48c
        
        lda $a1,s
        and #$f0f0
        ora #$040c
        sta $a1,s
        
        lda $a3,s
;        and #$f0f0         not necessary for pure green
        ora #$000c
        sta $a3,s
        
        _spriteFooter
        rtl


explosion3 entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; .GOG|RG..
; G.GG|GGGR
; GGGO|GOG.
; RGO.|.GGG
; GG..|.G..
; GRRG|RGGG
; RGGG|GGG.
; .OG.|.G.O
        
        lda $1,s
        and #$00f0
        ora #$8c0c
        sta $1,s
        
        lda $3,s
        and #$ff00
        ora #$004c
        sta $3,s
        
        lda $a1,s
;        and #$000f     not necessary with pure green
        ora #$ccc0
        sta $a1,s
        
        lda #$c4cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda #$c8cc
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$c0c8
        sta $3,s
        

        lda $a1,s
        and #$0f00
        ora #$804c
        sta $a1,s
        
        lda $a3,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $1,s
        
        lda $3,s
;        and #$fff0     not necessary with pure green
        ora #$000c
        sta $3,s

        lda #$4cc4
        sta $a1,s
        
        lda #$cc4c
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda #$cc4c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
        and #$0ff0
        ora #$c008
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$080c
        sta $a3,s
        
        _spriteFooter
        rtl


explosion4 entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; G.GO|.R.G
; .O.G|G.G.
; RG.R|.O.R
; G.R.|..G.
; GG..|...O
; .R.R|.RGO
; O.R.|R.GR
; RG.G|GGO.
;

        
        lda $1,s
        and #$000f
        ora #$c8c0
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0c04
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0c08
        sta $a1,s
        
        lda $a3,s
;        and #$0f0f     not necessary with pure green
        ora #$c0c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f000
        ora #$044c
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0408
        sta $3,s
        

        lda $a1,s
        and #$0f0f
        ora #$40c0
        sta $a1,s
        
        lda $a3,s
;        and #$0fff     not necessary with pure green
        ora #$c000
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $1,s
        
        lda $3,s
        and #$f0ff
        ora #$0800
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0404
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$c804
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
        and #$0f0f
        ora #$4080
        sta $1,s
        
        lda $3,s
        and #$000f
        ora #$c440
        sta $3,s
        
        lda $a1,s
        and #$f000
        ora #$0c4c
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$80cc
        sta $a3,s
        
        _spriteFooter
        rtl


explosion5 entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; .G..|G.G.
; .ROG|.RG.
; GO..|G..O
; .R..|..R.
; G.R.|.R.R
; .O.G|.GO.
; RGR.|..G.
; .G.G|OR..
;
        
        lda $1,s
;        and #$000f     not necessary with pure green
        ora #$000c
        sta $1,s
        
        lda $3,s
;        and #$f0f0     not necessary with pure green
        ora #$c0c0
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8c04
        sta $a1,s
        
        lda $a3,s
        and #$0ff0
        ora #$c004
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$ff00
        ora #$00c8
        sta $1,s
        
        lda $3,s
        and #$f00f
        ora #$08c0
        sta $3,s
        

        lda $a1,s
        and #$fff0
        ora #$0004
        sta $a1,s
        
        lda $a3,s
        and #$0fff
        ora #$4000
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0f0f
        ora #$40c0
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0404
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0c08
        sta $a1,s
        
        lda $a3,s
        and #$0ff0
        ora #$800c
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
        and #$0f00
        ora #$404c
        sta $1,s
        
        lda $3,s
;        and #$0fff     not necessary with pure green
        ora #$c000
        sta $3,s
        
        lda $a1,s
;        and #$f0f0     not necessary with pure green
        ora #$0c0c
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0084
        sta $a3,s
        
        _spriteFooter
        rtl
        

explosion6 entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; .O.G|..G.
; R.G.|OR.R
; ....|....
; G...|..G.
; .O..|...G
; .O..|..O.
; R.G.|...G
; .O.O|R.R.
;
        
        lda $1,s
        and #$f0f0
        ora #$0c08
        sta $1,s
        
        lda $3,s
;        and #$0fff     not necessary with pure green
        ora #$c000
        sta $3,s
        
        lda $a1,s
        and #$0f0f
        ora #$c040
        sta $a1,s
        
        lda $a3,s
        and #$f000
        ora #$0484
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $a1,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a1,s
        
        lda $a3,s
;        and #$0fff     not necessary with pure green
        ora #$c000
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $3,s
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
        and #$0fff
        ora #$8000
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
        and #$0f0f
        ora #$c040
        sta $1,s
        
        lda $3,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a3,s
        and #$0f0f
        ora #$4040
        sta $a3,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'

        end