;
;  spiders.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy spiders.macros
        keep spiders

spiders start

spider1 entry
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
; ..O.|....|....|O...
; .O.O|....|...O|.O..
; O...|O..G|..O.|..O.
; ....|.ORG|RO..|....
; ..O.|.RRG|RR..|O...
; .O.O|.GGG|GG.O|.O..
; O...|OGRR|RGO.|..O.
; ....|..GR|G...|....
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a5,s
;        and #$f0ff
        ora #$0800
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda $3,s
;        and #$f00f
        ora #$0c80
        sta $3,s
        
        lda $5,s
;        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a3,s
;        and #$00f0
        ora #$4c08
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0048
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
;        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0044
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a3,s
;        and #$00f0  Not necessary with green
        ora #$cc0c
        sta $a3,s
        
        lda $a5,s
;        and #$f000
        ora #$08cc
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda #$448c
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$804c
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a3,s
;        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f    not necessary with green
        ora #$00c0
        sta $a5,s
        
        _spriteFooter
        rtl


spider1s entry
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
; ...O|....|....|.O..
; ..O.|O...|....|O.O.
; .O..|.O..|G..O|...O
; ....|..OR|GRO.|....
; ...O|..RR|GRR.|.O..
; ..O.|O.GG|GGG.|O.O.
; .O..|.OGR|RRGO|...O
; ....|...G|RG..|....
        
        lda $1,s
;        and #$0f0ff
        ora #$0800
        sta $1,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a7,s
;        and #$0f0f
        ora #$8080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
;        and #$f00f
        ora #$08c0
        sta $5,s
        
        lda $7,s
;        and #$f0ff
        ora #$0800
        sta $7,s
        
        lda $a3,s
;        and #$00ff
        ora #$8400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$80c4
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$00ff
        ora #$4400
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$40c4
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$000f
        ora #$cc80
        sta $a3,s
        
        lda $a5,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a5,s
        
        lda $a7,s
;        and #$0f0f
        ora #$8080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$c408
        sta $3,s
        
        lda #$c844
        sta $5,s
        
        lda $7,s
;        and #$f0ff
        ora #$0800
        sta $7,s
        
        lda $a3,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$004c
        sta $a5,s
        
        _spriteFooter
        rtl


spider2 entry
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
; ....|....|....|....
; .OOO|....|...O|OO..
; O...|O..G|..O.|..O.
; ....|.ORG|RO..|....
; ....|.RRG|RR..|....
; .OOO|.GGG|GG.O|OO..
; O...|OGRR|GGO.|..O.
; ....|..GR|G...|....
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a5,s
;        and #$f0ff
        ora #$0800
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
;        and #$f00f
        ora #$0c80
        sta $3,s
        
        lda $5,s
;        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a3,s
;        and #$00f0
        ora #$4c08
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0048
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $3,s
;        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0044
        sta $5,s
        
        lda $a1,s
;        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a3,s
;        and #$00f0        not necessary with pure green
        ora #$cc0c
        sta $a3,s
        
        lda $a5,s
;        and #$f000
        ora #$08cc
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
        
        lda #$448c
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$80cc
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a3,s
;        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $a5,s
        
        _spriteFooter
        rtl


spider2s entry
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
; ....|....|....|....
; ..OO|O...|....|OOO.
; .O..|.O..|G..O|...O
; ....|..OR|GRO.|....
; ....|..RR|GRR.|....
; ..OO|O.GG|GGG.|OOO.
; .O..|.OGR|RGGO|...O
; ....|...G|RG..|....
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a7,s
;        and #$0f00
        ora #$8088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
;        and #$f00f
        ora #$08c0
        sta $5,s
        
        lda $7,s
;        and #$f0ff
        ora #$0800
        sta $7,s
        
        lda $a3,s
;        and #$00ff
        ora #$8400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$80c4
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $3,s
;        and #$00ff
        ora #$4400
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$40c4
        sta $5,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a3,s
;        and #$000f
        ora #$cc80
        sta $a3,s
        
        lda $a5,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a5,s
        
        lda $a7,s
;        and #$0f00
        ora #$8088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$c408
        sta $3,s
        
        lda #$c84c
        sta $5,s
        
        lda $7,s
;        and #$f0ff
        ora #$0800
        sta $7,s
        
        lda $a3,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$004c
        sta $a5,s
        
        _spriteFooter
        rtl


spider3 entry
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
; ....|....|....|....
; ....|....|....|....
; ..OO|O..G|..OO|O...
; .O..|.ORG|RO..|.O..
; O...|.RRG|RR..|..O.
; ..OO|.GGG|GG.O|O...
; .O..|OGGR|RGO.|.O..
; O...|..GR|G...|..O.
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
;        and #$f00f
        ora #$0c80
        sta $3,s
        
        lda $5,s
;        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
;        and #$00f0
        ora #$4c08
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0048
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda $3,s
;        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0044
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a3,s
;        and #$00f0        not necessary with pure green
        ora #$cc0c
        sta $a3,s
        
        lda $a5,s
;        and #$f000
        ora #$08cc
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda #$c48c
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$804c
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a1,s
;        and #$ff0f
        ora #$0080
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        _spriteFooter
        rtl


spider3s entry
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
; ....|....|....|....
; ....|....|....|....
; ...O|OO..|G..O|OO..
; ..O.|..OR|GRO.|..O.
; .O..|..RR|GRR.|...O
; ...O|O.GG|GGG.|OO..
; ..O.|.OGG|RRGO|..O.
; .O..|...G|RG..|...O
        
        tsc
        adc #$140
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
;        and #$f00f
        ora #$08c0
        sta $5,s
        
        lda $7,s
;        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$8400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$80c4
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$00ff
        ora #$4400
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$40c4
        sta $5,s
        
        lda $7,s
;        and #$f0ff
        ora #$0800
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$000f
        ora #$cc80
        sta $a3,s
        
        lda $a5,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
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
;        and #$00f0
        ora #$cc08
        sta $3,s
        
        lda #$c844
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$004c
        sta $a5,s
        
        lda $a7,s
;        and #$f0ff
        ora #$0800
        sta $a7,s
        
        _spriteFooter
        rtl


spider4 entry
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
; ....|....|....|....
; ....|....|....|....
; ....|...G|....|....
; ...O|OORG|ROOO|....
; ..O.|.RRG|RR..|O...
; .O..|OGGG|GGO.|.O..
; O...|OGGR|GGO.|..O.
; ..OO|..GR|G..O|O...
        
        tsc
        adc #$140
        tcs
        
        lda $3,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $3,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda #$4c88
        sta $a3,s
        
        lda #$8848
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
;        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0044
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda #$cc8c
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$80cc
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda #$c48c
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$80cc
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
;        and #$f00f
        ora #$08c0
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        _spriteFooter
        rtl


spider4s entry
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
; ....|....|....|....
; ....|....|....|....
; ....|....|G...|....
; ....|OOOR|GROO|O...
; ...O|..RR|GRR.|.O..
; ..O.|.OGG|GGGO|..O.
; .O..|.OGG|RGGO|...O
; ...O|O..G|RG..|OO..
        
        tsc
        adc #$140
        tcs
        
        lda $5,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $5,s
        
        lda #$8488
        sta $a3,s
        
        lda #$88c4
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$00ff
        ora #$4400
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$40c4
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$00f0
        ora #$cc08
        sta $a3,s
        
        lda #$c8cc
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$cc08
        sta $3,s
        
        lda #$c84c
        sta $5,s
        
        lda $7,s
;        and #$f0ff
        ora #$0800
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$f00f
        ora #$0c80
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$004c
        sta $a5,s
        
        lda $a7,s
;        and #$ff00
        ora #$0088
        sta $a7,s
        
        _spriteFooter
        rtl


spider5 entry
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
; ....|....|....|....
; ....|....|....|....
; ..OO|O..G|..OO|O...
; .O..|.ORG|RO..|.O..
; O...|.RRG|RR..|..O.
; ..OO|.GGG|GG.O|O...
; .O..|OGRR|RGO.|.O..
; O...|..GR|G...|..O.
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
;        and #$f00f
        ora #$0c80
        sta $3,s
        
        lda $5,s
;        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
;        and #$00f0
        ora #$4c08
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0048
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda $3,s
;        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0044
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a1,s
;        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a3,s
;        and #$00f0        not necessary with pure green
        ora #$cc0c
        sta $a3,s
        
        lda $a5,s
;        and #$f000
        ora #$08cc
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda #$448c
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$804c
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a1,s
;        and #$ff0f
        ora #$0080
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        _spriteFooter
        rtl


spider5s entry
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
; ....|....|....|....
; ....|....|....|....
; ...O|OO..|G..O|OO..
; ..O.|..OR|GRO.|..O.
; .O..|..RR|GRR.|...O
; ...O|O.GG|GGG.|OO..
; ..O.|.OGR|RRGO|..O.
; .O..|...G|RG..|...O
        
        tsc
        adc #$140
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
;        and #$f00f
        ora #$08c0
        sta $5,s
        
        lda $7,s
;        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$8400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$80c4
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$00ff
        ora #$4400
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$40c4
        sta $5,s
        
        lda $7,s
;        and #$f0ff
        ora #$0800
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$000f
        ora #$cc80
        sta $a3,s
        
        lda $a5,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
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
;        and #$00f0
        ora #$c408
        sta $3,s
        
        lda #$c844
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$004c
        sta $a5,s
        
        lda $a7,s
;        and #$f0ff
        ora #$0800
        sta $a7,s
        
        _spriteFooter
        rtl


spider6 entry
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
; ...O|....|...O|....
; ...O|....|...O|....
; ..O.|O..G|..O.|O...
; .O..|.ORG|RO..|.O..
; O..O|.RRG|RR.O|..O.
; ...O|.GGG|GG.O|....
; ..O.|OGGR|RGO.|O...
; .O..|..GR|G...|.O..
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $5,s
;        and #$f0ff
        ora #$0800
        sta $5,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a5,s
;        and #$f0ff
        ora #$0800
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
;        and #$f00f
        ora #$0c80
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
        
        lda $a3,s
;        and #$00f0
        ora #$4c08
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0048
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f00f
        ora #$0880
        sta $1,s
        
        lda $3,s
;        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
;        and #$f000
        ora #$0844
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$00f0  Not necessary with green
        ora #$cc0c
        sta $a3,s
        
        lda $a5,s
;        and #$f000
        ora #$08cc
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$0fff
        ora #$8000
        sta $1,s
        
        lda #$c48c
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$804c
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f    not necessary with green
        ora #$00c0
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        _spriteFooter
        rtl


spider6s entry
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
; ....|O...|....|O...
; ....|O...|....|O...
; ...O|.O..|G..O|.O..
; ..O.|..OR|GRO.|..O.
; .O..|O.RR|GRR.|O..O
; ....|O.GG|GGG.|O...
; ...O|.OGG|RRGO|.O..
; ..O.|...G|RG..|..O.
        
        lda $3,s
;        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a3,s
;        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
;        and #$f00f
        ora #$08c0
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        

        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$8400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$80c4
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$000f
        ora #$4480
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$40c4
        sta $5,s
        
        lda $7,s
;        and #$f00f
        ora #$0880
        sta $7,s
        
        lda $a3,s
;        and #$000f
        ora #$cc80
        sta $a3,s
        
        lda $a5,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$00f0
        ora #$cc08
        sta $3,s
        
        lda #$c844
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$004c
        sta $a5,s
        
        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        _spriteFooter
        rtl


spider7 entry
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
; ....|O...|..O.|....
; ....|O...|..O.|....
; ...O|O..G|..OO|....
; ..O.|.ORG|RO..|O...
; .O..|.RRG|RR..|.O..
; O..O|.GGG|GG.O|..O.
; ...O|OGGR|GGOO|....
; ..O.|..GR|G...|O...
        
        lda $3,s
;        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $5,s
;        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $a3,s
;        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a5,s
;        and #$0fff
        ora #$8000
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$f00f
        ora #$0c80
        sta $3,s
        
        lda $5,s
;        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$00f0
        ora #$4c08
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$0048
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
;        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
;        and #$ff00
        ora #$0044
        sta $5,s
        
        lda $7,s
;        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a1,s
;        and #$f00f
        ora #$0880
        sta $a1,s
        
        lda $a3,s
;        and #$00f0  Not necessary with green
        ora #$cc0c
        sta $a3,s
        
        lda $a5,s
;        and #$f000
        ora #$08cc
        sta $a5,s

        lda $a7,s
;        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda #$c48c
        sta $3,s
        
        lda #$88cc
        sta $5,s
        
        lda $a1,s
;        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f    not necessary with green
        ora #$00c0
        sta $a5,s
        
        lda $a7,s
;        and #$ff0f
        ora #$0080
        sta $a7,s
        
        _spriteFooter
        rtl


spider7s entry
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
; ....|.O..|...O|....
; ....|.O..|...O|....
; ....|OO..|G..O|O...
; ...O|..OR|GRO.|.O..
; ..O.|..RR|GRR.|..O.
; .O..|O.GG|GGG.|O..O
; ....|OOGG|RGGO|O...
; ...O|...G|RG..|.O..
        
        lda $3,s
;        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
;        and #$f0ff
        ora #$0800
        sta $5,s
        
        lda $a3,s
;        and #$fff0
        ora #$0008
        sta $a3,s
        
        lda $a5,s
;        and #$f0ff
        ora #$0800
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $3,s
;        and #$ff00
        ora #$0088
        sta $3,s
        
        lda $5,s
;        and #$f00f
        ora #$08c0
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        

        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$00ff
        ora #$8400
        sta $a3,s
        
        lda $a5,s
;        and #$0f00
        ora #$80c4
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
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
        ora #$4400
        sta $3,s
        
        lda $5,s
;        and #$0f00
        ora #$40c4
        sta $5,s
        
        lda $7,s
;        and #$0fff
        ora #$8000
        sta $7,s

        lda $a1,s
;        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
;        and #$000f
        ora #$cc80
        sta $a3,s
        
        lda $a5,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a5,s
        
        lda $a7,s
;        and #$f00f
        ora #$0880
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda #$cc88
        sta $3,s
        
        lda #$c84c
        sta $5,s
        
        lda $7,s
;        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
;        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a3,s
        
        lda $a5,s
;        and #$ff00
        ora #$004c
        sta $a5,s
        
        lda $a7,s
;        and #$fff0
        ora #$0008
        sta $a7,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'

        end
