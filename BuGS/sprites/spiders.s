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

spiders start spriteSeg
        using globalData

spider1 entry
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
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$f0f0
        ora #$0808
        sta $a0,s
        
        lda $a4,s
;        and #$f0ff
        ora #$0800
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$ff0f
        ora #$0080
        sta $0,s
        
        lda $2,s
;        and #$f00f
        ora #$0c80
        sta $2,s
        
        lda $4,s
;        and #$0fff
        ora #$8000
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a2,s
;        and #$00f0
        ora #$4c08
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0048
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $2,s
;        and #$ff0f
        ora #$4c04
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0044
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$f0f0
        ora #$0808
        sta $a0,s
        
        lda $a2,s
;        and #$00f0  Not necessary with green
        ora #$cc0c
        sta $a2,s
        
        lda $a4,s
;        and #$f000
        ora #$08cc
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$ff0f
        ora #$0080
        sta $0,s
        
        lda #$448c
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$804c
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a2,s
;        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f    not necessary with green
        ora #$00c0
        sta $a4,s
        
        _spriteFooter
        rtl


spider1s entry
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
        
        lda $0,s
;        and #$0f0ff
        ora #$0800
        sta $0,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f
        ora #$0080
        sta $a2,s
        
        lda $a6,s
;        and #$0f0f
        ora #$8080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$08c0
        sta $4,s
        
        lda $6,s
;        and #$f0ff
        ora #$0800
        sta $6,s
        
        lda $a2,s
;        and #$00ff
        ora #$8400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$80c4
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$00ff
        ora #$4400
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$40c4
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$000f
        ora #$cc80
        sta $a2,s
        
        lda $a4,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a4,s
        
        lda $a6,s
;        and #$0f0f
        ora #$8080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$c408
        sta $2,s
        
        lda #$c844
        sta $4,s
        
        lda $6,s
;        and #$f0ff
        ora #$0800
        sta $6,s
        
        lda $a2,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$004c
        sta $a4,s
        
        _spriteFooter
        rtl


spider2 entry
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
        
        lda $a0,s
;        and #$00f0
        ora #$8808
        sta $a0,s
        
        lda $a4,s
;        and #$f0ff
        ora #$0800
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
;        and #$f00f
        ora #$0c80
        sta $2,s
        
        lda $4,s
;        and #$0fff
        ora #$8000
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a2,s
;        and #$00f0
        ora #$4c08
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0048
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $2,s
;        and #$ff0f
        ora #$4c04
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0044
        sta $4,s
        
        lda $a0,s
;        and #$00f0
        ora #$8808
        sta $a0,s
        
        lda $a2,s
;        and #$00f0        not necessary with pure green
        ora #$cc0c
        sta $a2,s
        
        lda $a4,s
;        and #$f000
        ora #$08cc
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
        
        lda #$448c
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$80cc
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a2,s
;        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $a4,s
        
        _spriteFooter
        rtl


spider2s entry
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
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f
        ora #$0080
        sta $a2,s
        
        lda $a6,s
;        and #$0f00
        ora #$8088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$08c0
        sta $4,s
        
        lda $6,s
;        and #$f0ff
        ora #$0800
        sta $6,s
        
        lda $a2,s
;        and #$00ff
        ora #$8400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$80c4
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $2,s
;        and #$00ff
        ora #$4400
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$40c4
        sta $4,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
;        and #$000f
        ora #$cc80
        sta $a2,s
        
        lda $a4,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a4,s
        
        lda $a6,s
;        and #$0f00
        ora #$8088
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$c408
        sta $2,s
        
        lda #$c84c
        sta $4,s
        
        lda $6,s
;        and #$f0ff
        ora #$0800
        sta $6,s
        
        lda $a2,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$004c
        sta $a4,s
        
        _spriteFooter
        rtl


spider3 entry
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
        
        lda $0,s
;        and #$00ff
        ora #$8800
        sta $0,s
        
        lda $2,s
;        and #$f00f
        ora #$0c80
        sta $2,s
        
        lda $4,s
;        and #$00ff
        ora #$8800
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda $a2,s
;        and #$00f0
        ora #$4c08
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0048
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$ff0f
        ora #$0080
        sta $0,s
        
        lda $2,s
;        and #$ff0f
        ora #$4c04
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0044
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
;        and #$00f0        not necessary with pure green
        ora #$cc0c
        sta $a2,s
        
        lda $a4,s
;        and #$f000
        ora #$08cc
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda #$c48c
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$804c
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a0,s
;        and #$ff0f
        ora #$0080
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        _spriteFooter
        rtl


spider3s entry
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
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$ff00
        ora #$0088
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$08c0
        sta $4,s
        
        lda $6,s
;        and #$ff00
        ora #$0088
        sta $6,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$8400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$80c4
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$00ff
        ora #$4400
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$40c4
        sta $4,s
        
        lda $6,s
;        and #$f0ff
        ora #$0800
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$000f
        ora #$cc80
        sta $a2,s
        
        lda $a4,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
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
;        and #$00f0
        ora #$cc08
        sta $2,s
        
        lda #$c844
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda $a2,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$004c
        sta $a4,s
        
        lda $a6,s
;        and #$f0ff
        ora #$0800
        sta $a6,s
        
        _spriteFooter
        rtl


spider4 entry
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
        
        lda $2,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $2,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda #$4c88
        sta $a2,s
        
        lda #$8848
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $2,s
;        and #$ff0f
        ora #$4c04
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0044
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda #$cc8c
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$80cc
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$ff0f
        ora #$0080
        sta $0,s
        
        lda #$c48c
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$80cc
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
;        and #$f00f
        ora #$08c0
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        _spriteFooter
        rtl


spider4s entry
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
        
        lda $4,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $4,s
        
        lda #$8488
        sta $a2,s
        
        lda #$88c4
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$00ff
        ora #$4400
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$40c4
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$00f0
        ora #$cc08
        sta $a2,s
        
        lda #$c8cc
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$cc08
        sta $2,s
        
        lda #$c84c
        sta $4,s
        
        lda $6,s
;        and #$f0ff
        ora #$0800
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$f00f
        ora #$0c80
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$004c
        sta $a4,s
        
        lda $a6,s
;        and #$ff00
        ora #$0088
        sta $a6,s
        
        _spriteFooter
        rtl


spider5 entry
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
        
        lda $0,s
;        and #$00ff
        ora #$8800
        sta $0,s
        
        lda $2,s
;        and #$f00f
        ora #$0c80
        sta $2,s
        
        lda $4,s
;        and #$00ff
        ora #$8800
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda $a2,s
;        and #$00f0
        ora #$4c08
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0048
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$ff0f
        ora #$0080
        sta $0,s
        
        lda $2,s
;        and #$ff0f
        ora #$4c04
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0044
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a0,s
;        and #$00ff
        ora #$8800
        sta $a0,s
        
        lda $a2,s
;        and #$00f0        not necessary with pure green
        ora #$cc0c
        sta $a2,s
        
        lda $a4,s
;        and #$f000
        ora #$08cc
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda #$448c
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$804c
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a0,s
;        and #$ff0f
        ora #$0080
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f        not necessary with pure green
        ora #$00c0
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        _spriteFooter
        rtl


spider5s entry
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
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$ff00
        ora #$0088
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$08c0
        sta $4,s
        
        lda $6,s
;        and #$ff00
        ora #$0088
        sta $6,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$8400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$80c4
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$00ff
        ora #$4400
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$40c4
        sta $4,s
        
        lda $6,s
;        and #$f0ff
        ora #$0800
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$000f
        ora #$cc80
        sta $a2,s
        
        lda $a4,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
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
;        and #$00f0
        ora #$c408
        sta $2,s
        
        lda #$c844
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda $a2,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$004c
        sta $a4,s
        
        lda $a6,s
;        and #$f0ff
        ora #$0800
        sta $a6,s
        
        _spriteFooter
        rtl


spider6 entry
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
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $4,s
;        and #$f0ff
        ora #$0800
        sta $4,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a4,s
;        and #$f0ff
        ora #$0800
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $2,s
;        and #$f00f
        ora #$0c80
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
        
        lda $a2,s
;        and #$00f0
        ora #$4c08
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0048
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f00f
        ora #$0880
        sta $0,s
        
        lda $2,s
;        and #$ff0f
        ora #$4c04
        sta $2,s
        
        lda $4,s
;        and #$f000
        ora #$0844
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$00f0  Not necessary with green
        ora #$cc0c
        sta $a2,s
        
        lda $a4,s
;        and #$f000
        ora #$08cc
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$0fff
        ora #$8000
        sta $0,s
        
        lda #$c48c
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$804c
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f    not necessary with green
        ora #$00c0
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        _spriteFooter
        rtl


spider6s entry
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
        
        lda $2,s
;        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a2,s
;        and #$ff0f
        ora #$0080
        sta $a2,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$08c0
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        

        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$8400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$80c4
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$000f
        ora #$4480
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$40c4
        sta $4,s
        
        lda $6,s
;        and #$f00f
        ora #$0880
        sta $6,s
        
        lda $a2,s
;        and #$000f
        ora #$cc80
        sta $a2,s
        
        lda $a4,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$00f0
        ora #$cc08
        sta $2,s
        
        lda #$c844
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$004c
        sta $a4,s
        
        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        _spriteFooter
        rtl


spider7 entry
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
        
        lda $2,s
;        and #$ff0f
        ora #$0080
        sta $2,s
        
        lda $4,s
;        and #$0fff
        ora #$8000
        sta $4,s
        
        lda $a2,s
;        and #$ff0f
        ora #$0080
        sta $a2,s
        
        lda $a4,s
;        and #$0fff
        ora #$8000
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$f00f
        ora #$0c80
        sta $2,s
        
        lda $4,s
;        and #$00ff
        ora #$8800
        sta $4,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$00f0
        ora #$4c08
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$0048
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $2,s
;        and #$ff0f
        ora #$4c04
        sta $2,s
        
        lda $4,s
;        and #$ff00
        ora #$0044
        sta $4,s
        
        lda $6,s
;        and #$fff0
        ora #$0008
        sta $6,s
        
        lda $a0,s
;        and #$f00f
        ora #$0880
        sta $a0,s
        
        lda $a2,s
;        and #$00f0  Not necessary with green
        ora #$cc0c
        sta $a2,s
        
        lda $a4,s
;        and #$f000
        ora #$08cc
        sta $a4,s

        lda $a6,s
;        and #$0fff
        ora #$8000
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda #$c48c
        sta $2,s
        
        lda #$88cc
        sta $4,s
        
        lda $a0,s
;        and #$0fff
        ora #$8000
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f    not necessary with green
        ora #$00c0
        sta $a4,s
        
        lda $a6,s
;        and #$ff0f
        ora #$0080
        sta $a6,s
        
        _spriteFooter
        rtl


spider7s entry
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
        
        lda $2,s
;        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $4,s
;        and #$f0ff
        ora #$0800
        sta $4,s
        
        lda $a2,s
;        and #$fff0
        ora #$0008
        sta $a2,s
        
        lda $a4,s
;        and #$f0ff
        ora #$0800
        sta $a4,s
        
        tsc
        adc #$140
        tcs
        
        lda $2,s
;        and #$ff00
        ora #$0088
        sta $2,s
        
        lda $4,s
;        and #$f00f
        ora #$08c0
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        

        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$00ff
        ora #$8400
        sta $a2,s
        
        lda $a4,s
;        and #$0f00
        ora #$80c4
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
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
        ora #$4400
        sta $2,s
        
        lda $4,s
;        and #$0f00
        ora #$40c4
        sta $4,s
        
        lda $6,s
;        and #$0fff
        ora #$8000
        sta $6,s

        lda $a0,s
;        and #$fff0
        ora #$0008
        sta $a0,s
        
        lda $a2,s
;        and #$000f
        ora #$cc80
        sta $a2,s
        
        lda $a4,s
;        and #$0f00        not necessary with pure green
        ora #$c0cc
        sta $a4,s
        
        lda $a6,s
;        and #$f00f
        ora #$0880
        sta $a6,s
        
        tsc
        adc #$140
        tcs
        
        lda #$cc88
        sta $2,s
        
        lda #$c84c
        sta $4,s
        
        lda $6,s
;        and #$ff0f
        ora #$0080
        sta $6,s
        
        lda $a0,s
;        and #$f0ff
        ora #$0800
        sta $a0,s
        
        lda $a2,s
;        and #$f0ff        not necessary with pure green
        ora #$0c00
        sta $a2,s
        
        lda $a4,s
;        and #$ff00
        ora #$004c
        sta $a4,s
        
        lda $a6,s
;        and #$fff0
        ora #$0008
        sta $a6,s
        
        _spriteFooter
        rtl

        end
