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

explosions start spriteSeg
        using globalData

explosion1 entry
        _spriteHeader
 
; $1 - Green (c)
; $2 - Red (4)
; $3 - Off-white (8)
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
        
        lda $0,s
        and #$00ff
        ora #$2200
        sta $0,s
        
        lda $2,s
        and #$fff0
        ora #$0002
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$1203
        sta $a0,s
        
        lda $a2,s
        and #$ff0f
        ora #$0010
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$ff0f
        ora #$1101
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$2011
        sta $2,s
        
        lda #$1121
        sta $a0,s
        
        lda $a2,s
        and #$0f00
        ora #$3011
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$0f00
        ora #$1021
        sta $0,s
        
        lda $2,s
        and #$fff0
        ora #$1011
        sta $2,s

        lda #$1131
        sta $a0,s
        
        lda #$3111
        sta $a0,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$1103
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$3021
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$3202
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0102
        sta $a2,s
        
        _spriteFooter
        rtl


explosion2 entry
        _spriteHeader
 
; $1 - Green
; $2 - Red
; $3 - Off-white
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

        lda $0,s
        and #$00ff
        ora #$1200
        sta $0,s
        
        lda $2,s
        and #$0f0f
        ora #$2010
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$1101
        sta $a0,s
        
        lda #$2111
        sta $a2,s
        
        tsc
        adc #$143
        tcs
        
        pea $1311
        pea $1131
        
        adc #$a0
        tcs
        
        pea $1131
        pea $1331
        
        adc #$a0
        tcs
        
        pea $1331
        pea $1331
        
        adc #$a0
        tcs
        
        pea $1111
        pea $1131
        
        adc #$a0
        tcs
        
        pea $1311
        pea $1231
        
        lda $a1,s
        and #$f0f0
        ora #$0201
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0001
        sta $a3,s
        
        _spriteFooter
        rtl


explosion3 entry
        _spriteHeader
 
; $1 - Green
; $2 - Red
; $3 - Off-white
;
; .GOG|RG..
; G.GG|GGGR
; GGGO|GOG.
; RGO.|.GGG
; GG..|.G..
; GRRG|RGGG
; RGGG|GGG.
; .OG.|.G.O
        
        lda $0,s
        and #$00f0
        ora #$3101
        sta $0,s
        
        lda $2,s
        and #$ff00
        ora #$0021
        sta $2,s
        
        lda $a0,s
        and #$000f
        ora #$1110
        sta $a0,s
        
        lda #$1211
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda #$1311
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$1013
        sta $2,s
        

        lda $a0,s
        and #$0f00
        ora #$3021
        sta $a0,s
        
        lda $a2,s
        and #$00f0
        ora #$1101
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$ff00
        ora #$0011
        sta $0,s
        
        lda $2,s
        and #$fff0
        ora #$0001
        sta $2,s

        lda #$2112
        sta $a0,s
        
        lda #$1121
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda #$1121
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$1011
        sta $2,s
        
        lda $a0,s
        and #$0ff0
        ora #$1003
        sta $a0,s
        
        lda $a2,s
        and #$f0f0
        ora #$0301
        sta $a2,s
        
        _spriteFooter
        rtl


explosion4 entry
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

        lda $0,s
        and #$000f
        ora #$1310
        sta $0,s
        
        lda $2,s
        and #$f0f0
        ora #$0102
        sta $2,s
        
        lda $a0,s
        and #$f0f0
        ora #$0103
        sta $a0,s
        
        lda $a2,s
        and #$0f0f
        ora #$1010
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$f000
        ora #$0221
        sta $0,s
        
        lda $2,s
        and #$f0f0
        ora #$0203
        sta $2,s
        
        lda $a0,s
        and #$0f0f
        ora #$2010
        sta $a0,s
        
        lda $a2,s
        and #$0fff
        ora #$1000
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$ff00
        ora #$0011
        sta $0,s
        
        lda $2,s
        and #$f0ff
        ora #$0300
        sta $2,s
        
        lda $a0,s
        and #$f0f0
        ora #$0202
        sta $a0,s
        
        lda $a2,s
        and #$00f0
        ora #$1302
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$0f0f
        ora #$2030
        sta $0,s
        
        lda $2,s
        and #$000f
        ora #$1220
        sta $2,s
        
        lda $a0,s
        and #$f000
        ora #$0121
        sta $a0,s
        
        lda $a2,s
        and #$0f00
        ora #$3011
        sta $a2,s
        
        _spriteFooter
        rtl


explosion5 entry
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
        
        lda $0,s
        and #$000f
        ora #$0001
        sta $0,s
        
        lda $2,s
        and #$f0f0
        ora #$1010
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$3102
        sta $a0,s
        
        lda $a2,s
        and #$0ff0
        ora #$1002
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$ff00
        ora #$0013
        sta $0,s
        
        lda $2,s
        and #$f00f
        ora #$0310
        sta $2,s
        
        lda $a0,s
        and #$fff0
        ora #$0002
        sta $a0,s
        
        lda $a2,s
        and #$0fff
        ora #$2000
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$0f0f
        ora #$2010
        sta $0,s
        
        lda $2,s
        and #$f0f0
        ora #$0202
        sta $2,s
        
        lda $a0,s
        and #$f0f0
        ora #$0103
        sta $a0,s
        
        lda $a2,s
        and #$0ff0
        ora #$3001
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$0f00
        ora #$2021
        sta $0,s
        
        lda $2,s
        and #$0fff
        ora #$1000
        sta $2,s
        
        lda $a0,s
        and #$f0f0
        ora #$0101
        sta $a0,s
        
        lda $a2,s
        and #$ff00
        ora #$0032
        sta $a2,s
        
        _spriteFooter
        rtl
        

explosion6 entry
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
        
        lda $0,s
        and #$f0f0
        ora #$0103
        sta $0,s
        
        lda $2,s
        and #$0fff
        ora #$1000
        sta $2,s
        
        lda $a0,s
        and #$0f0f
        ora #$1020
        sta $a0,s
        
        lda $a2,s
        and #$f000
        ora #$0232
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $a0,s
        and #$ff0f
        ora #$0010
        sta $a0,s
        
        lda $a2,s
        and #$0fff
        ora #$1000
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$fff0
        ora #$0003
        sta $0,s
        
        lda $2,s
        and #$f0ff
        ora #$0100
        sta $2,s
        
        lda $a0,s
        and #$fff0
        ora #$0003
        sta $a0,s
        
        lda $a2,s
        and #$0fff
        ora #$3000
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$0f0f
        ora #$1020
        sta $0,s
        
        lda $2,s
        and #$f0ff
        ora #$0100
        sta $2,s
        
        lda $a0,s
        and #$f0f0
        ora #$0303
        sta $a0,s
        
        lda $a2,s
        and #$0f0f
        ora #$2020
        sta $a2,s
        
        _spriteFooter
        rtl


shipExplosion1 entry
		_spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; .G..|.G..|.G..|.G..
; GRG.|GRG.|GGR.|GRG.
; .GWG|RRRG|GRRR|GGWG
; ..GR|RRRR|RRRR|RGG.
; .GWG|RRRG|GRRR|GG..
; GRGG|RGRG|GRGR|WGG.
; .GRG|.GWG|.GWG|.GRG
; ..G.|..G.|..G.|..G.
;
		
		lda $0,s
		ora #$000c
		sta $0,s
		
		lda $2,s
		ora #$000c
		sta $2,s
		
		lda $4,s
		ora #$000c
		sta $4,s
		
		lda $6,s
		ora #$000c
		sta $6,s
		
		lda $a0,s
		and #$0f00
		ora #$c0c4
		sta $a0,s
		
		lda $a2,s
		and #$0f00
		ora #$c0c4
		sta $a2,s
		
		lda $a4,s
		and #$0f00
		ora #$40cc
		sta $a4,s
		
		lda $a6,s
		and #$0f00
		ora #$c0c4
		sta $a6,s
		
		tsc
		adc #$140
		tcs
		
		lda $0,s
		and #$00f0
		ora #$8c0c
		sta $0,s
		
		lda #$4c44
		sta $2,s
		
		lda #$44c4
		sta $4,s
		
		lda #$8ccc
		sta $6,s

		lda $a0,s
        and #$00ff
		ora #$c400
		sta $a0,s
		
		lda #$4444
		sta $a2,s
		
		sta $a4,s
		
		lda $a6,s
        and #$0f00
		ora #$c04c
		sta $a6,s
		
		tsc
		adc #$140
		tcs
		
		lda $0,s
		and #$00f0
		ora #$8c0c
		sta $0,s
		
		lda #$4c44
		sta $2,s
		
		lda #$44c4
		sta $4,s
		
		lda $6,s
		ora #$00cc
		sta $6,s
		
		lda #$ccc4
		sta $a0,s
		
		lda #$4c4c
		sta $a2,s
		
		lda #$c4c4
		sta $a4,s
		
		lda $a6,s
		and #$0f00
		ora #$c08c
		sta $a6,s
		
		tsc
		adc #$140
		tcs

		lda $0,s
		and #$00f0
		ora #$4c0c
		sta $0,s
		
		lda $2,s
        and #$00f0
		ora #$8c0c
		sta $2,s
		
		lda $4,s
		and #$00f0
		ora #$8c0c
		sta $4,s
		
		lda $6,s
		and #$00f0
		ora #$4c0c
		sta $6,s
		
		lda $a0,s
		ora #$c000
		sta $a0,s
		
		lda $a2,s
		ora #$c000
		sta $a2,s
		
		lda $a4,s
		ora #$c000
		sta $a4,s
		
		lda $a6,s
		ora #$c000
		sta $a6,s
		
		_spriteFooter
		rtl
		

shipExplosion2 entry
		_spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ..G.|...G|G...|.G..
; .GRG|..GG|RG..|GRG.
; GRRR|GGGR|RRGG|RRRG
; RRWR|RGRR|WRRR|RWRR
; GRRR|GGGR|RRGG|RRRG
; GRGR|G.GR|GRGG|RGRG
; .GGG|...G|GG..|GGG.
; ..G.|....|G...|.G..
;
	  
		lda $0,s
		ora #$c000
		sta $0,s
	  
		lda $2,s
		ora #$0c00
		sta $2,s
	  
		lda $4,s
		ora #$00c0
		sta $4,s
	  
		lda $6,s
		ora #$000c
		sta $6,s
	  
		lda $a0,s
		and #$00f0
		ora #$4c0c
		sta $a0,s
	  
		lda $a2,s
		ora #$cc00
		sta $a2,s
	  
		lda $a4,s
		and #$ff00
		ora #$004c
		sta $a4,s
	  
		lda $a6,s
		and #$0f00
		ora #$c0c4
		sta $a6,s
	  
		tsc
		adc #$140
		tcs
	  
		lda #$44c4
		sta $0,s
	  
		lda #$c4cc
		sta $2,s
	  
		lda #$cc44
		sta $4,s
	  
		lda #$4c44
		sta $6,s

		lda #$8444
		sta $a0,s
	  
		lda #$444c
		sta $a2,s
		
		lda #$4484
		sta $a4,s
	  
		lda #$4448
		sta $a6,s
	  
		tsc
		adc #$140
		tcs
	  
		lda #$44c4
		sta $0,s
	  
		lda #$c4cc
		sta $2,s
	  
		lda #$cc44
		sta $4,s
	  
		lda #$4c44
		sta $6,s
	  
		lda #$c4c4
		sta $a0,s
		
		lda $a2,s
		and #$000f
		ora #$c4c0
		sta $a2,s
		
		lda #$ccc4
		sta $a4,s
	  
		lda #$4c4c
		sta $a6,s
	  
		tsc
		adc #$140
		tcs

		lda $0,s
		ora #$cc0c
		sta $0,s
	  
		lda $2,s
		ora #$0c00
		sta $2,s
	  
		lda $4,s
		ora #$00cc
		sta $4,s
	  
		lda $6,s
		ora #$c0cc
		sta $6,s
	  
		lda $a0,s
		ora #$c000
		sta $a0,s
	  
		lda $a4,s
		ora #$00c0
		sta $a4,s
	  
		lda $a6,s
		ora #$000c
		sta $a6,s
	  
		_spriteFooter
		rtl


shipExplosion3 entry
		_spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...G|...R|R...|G...
; ..GR|G.RR|RR.G|RG..
; GGRR|RGGW|WGGR|RRGG
; RRRR|RRRG|GRRR|RRRR
; GWRG|RWGG|GGWR|GRWG
; .RRG|RRWG|GWRR|GRR.
; RRGG|GRR.|.RRG|GGRR
; .G.G|.G..|..G.|G.G.
;
		
		lda $0,s
		ora #$0c00
		sta $0,s
		
		lda $2,s
		and #$f0ff
		ora #$0400
		sta $2,s
		
		lda $4,s
		and #$ff0f
		ora #$0040
		sta $4,s
		
		lda $6,s
		ora #$00c0
		sta $6,s
		
		lda $a0,s
		and #$00ff
		ora #$c400
		sta $a0,s
		
		lda $a2,s
		and #$fff0
		ora #$44c0
		sta $a2,s
		
		lda $a4,s
		and #$f000
		ora #$0c44
		sta $a4,s
		
		lda $a6,s
		and #$ff00
		ora #$004c
		sta $a6,s
		
		tsc
		adc #$140
		tcs
		
		lda #$44cc
		sta $0,s
		
		lda #$c84c
		sta $2,s
		
		lda #$c48c
		sta $4,s
		
		lda #$cc44
		sta $6,s

		lda #$4444
		sta $a0,s
		
		lda #$4c44
		sta $a2,s
		  
		lda #$44c4
		sta $a4,s
		
		lda #$4444
		sta $a6,s
		
		tsc
		adc #$140
		tcs
		
		lda #$4cc8
		sta $0,s
		
		lda #$cc48
		sta $2,s
		
		lda #$84cc
		sta $4,s
		
		lda #$8cc4
		sta $6,s
		
		lda $a0,s
		and #$00f0
		ora #$4c04
		sta $a0,s
		  
		lda #$8c44
		sta $a2,s
		  
		lda #$44c8
		sta $a4,s
		
		lda $a6,s
		and #$0f00
		ora #$40c4
		sta $a6,s
		
		tsc
		adc #$140
		tcs

		lda #$cc44
		sta $0,s
		
		lda $2,s
		and #$0f00
		ora #$40c4
		sta $2,s
		
		lda $4,s
		and #$00f0
		ora #$4c04
		sta $4,s
		
		lda #$44cc
		sta $6,s
		
		lda $a0,s
		ora #$0c0c
		sta $a0,s
		
		lda $a2,s
		ora #$000c
		sta $a2,s
		
		lda $a4,s
		ora #$c000
		sta $a4,s
		
		lda $a6,s
		ora #$c0c0
		sta $a6,s
		
		_spriteFooter
		rtl


shipExplosion4 entry
		_spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...G|..G.|.G..|G...
; .GGR|G.GG|GGWG|RGG.
; .GRG|WGRG|GRGW|GRGG
; GRGW|GWGR|RGWG|WGR.
; .RGG|WRGW|WGRW|GGRG
; GGRR|GRWG|GWRG|RRG.
; .GGW|RGGR|RGGR|.GG.
; ..G.|G...|...G|.G..
;

		lda $0,s
		ora #$0c00
		sta $0,s

		lda $2,s
		ora #$c000
		sta $2,s

		lda $4,s
		ora #$000c
		sta $4,s

		lda $6,s
		ora #$00c0
		sta $6,s

		lda $a0,s
		and #$00f0
		ora #$c40c
		sta $a0,s

		lda $a2,s
		ora #$ccc0
		sta $a2,s

		lda #$8ccc
		sta $a4,s

		lda $a6,s
		and #$0f00
		ora #$c04c
		sta $a6,s

		tsc
		adc #$140
		tcs

		lda $0,s
		and #$00f0
		ora #$4c0c
		sta $0,s

		lda #$4c8c
		sta $2,s

		lda #$c8c4
		sta $4,s

		lda #$ccc4
		sta $6,s

		lda #$c8c4
		sta $a0,s

		lda #$c4c8
		sta $a2,s

		lda #$8c4c
		sta $a4,s

		lda $a6,s
		and #$0f00
		ora #$408c
		sta $a6,s

		tsc
		adc #$140
		tcs

		lda $0,s
		and #$00f0
		ora #$cc04
		sta $0,s

		lda #$c884
		sta $2,s

		lda #$488c
		sta $4,s

		lda #$4ccc
		sta $6,s

		lda #$44cc
		sta $a0,s

		lda #$8cc4
		sta $a2,s

		lda #$4cc8
		sta $a4,s

		lda $a6,s
		and #$0f00
		ora #$c044
		sta $a6,s

		tsc
		adc #$140
		tcs

		lda $0,s
		and #$00f0
		ora #$c80c
		sta $0,s

		lda #$c44c
		sta $2,s

		lda #$c44c
		sta $4,s

		lda $6,s
		ora #$c00c
		sta $6,s

		lda $a0,s
		ora #$c000
		sta $a0,s

		lda $a2,s
		ora #$00c0
		sta $a2,s

		lda $a4,s
		ora #$0c00
		sta $a4,s

		lda $a6,s
		ora #$000c
		sta $a6,s

		_spriteFooter
		rtl


shipExplosion5 entry
		_spriteHeader
		
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|...G|G...|....
; ..G.|..GR|RG..|.G..
; .GRG|GGGG|WRGG|GRG.
; ..WR|RWGR|WGWR|RW..
; ..RW|GRWG|RRWG|WR..
; .GRG|G.GW|GG.G|GRG.
; ..G.|...G|G...|.G..
; ....|....|....|....
;
		
		lda $2,s
		ora #$0c00
		sta $2,s
		
		lda $4,s
		ora #$00c0
		sta $4,s
		
		lda $a0,s
		ora #$c000
		sta $a0,s
		
		lda $a2,s
		and #$00ff
		ora #$c400
		sta $a2,s
		
		lda $a4,s
		and #$ff00
		ora #$004c
		sta $a4,s
		
		lda $a6,s
		ora #$000c
		sta $a6,s
		
		tsc
		adc #$140
		tcs
		
		lda $0,s
		and #$00f0
		ora #$4c0c
		sta $0,s
		
		lda #$cccc
		sta $2,s
		
		lda #$cc84
		sta $4,s
		
		lda $6,s
		and #$0f00
		ora #$c0c4
		sta $6,s
		
		lda $a0,s
		and #$00ff
		ora #$8400
		sta $a0,s
		
		lda #$c448
		sta $a2,s
		
		lda #$848c
		sta $a4,s
		
		lda $a6,s
		and #$ff00
		ora #$0048
		sta $a6,s
		
		tsc
		adc #$140
		tcs
	
		lda $0,s
		and #$00ff
		ora #$4800
		sta $0,s
		
		lda #$8cc4
		sta $2,s
		
		lda #$8c44
		sta $4,s
		
		lda $6,s
		and #$ff00
		ora #$0084
		sta $6,s
		
		lda $a0,s
		and #$00f0
		ora #$4c0c
		sta $a0,s
		
		lda $a2,s
		and #$000f
		ora #$c8c0
		sta $a2,s
		
		lda $a4,s
		ora #$0ccc
		sta $a4,s
		
		lda $a6,s
		and #$0f00
		ora #$c0c4
		sta $a6,s
		
		tsc
		adc #$140
		tcs
		
		lda $0,s
		ora #$c000
		sta $0,s
		
		lda $2,s
		ora #$0c00
		sta $2,s
		
		lda $4,s
		ora #$00c0
		sta $4,s
		
		lda $6,s
		ora #$000c
		sta $6,s
		
		_spriteFooter
		rtl

		
shipExplosion6 entry
		_spriteHeader
		
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..W.|....|....
; ....|.G.R|G.R.|....
; ....|GWRW|WGWR|....
; ..GR|WW.R|WGGG|GR..
; ..RG|GGGW|RWWW|RG..
; ....|RWGW|WRWG|....
; ....|.R.G|R.G.|....
; ....|....|....|....
;
		
		lda $2,s
		and #$0fff
		ora #$8000
		sta $2,s
		
		lda $a2,s
		and #$f0f0
		ora #$040c
		sta $a2,s
		
		lda $a4,s
		and #$0f0f
		ora #$40c0
		sta $a4,s
		
		tsc
		adc #$140
		tcs
		
		lda #$48c8
		sta $2,s
		
		lda #$848c
		sta $4,s
		
		lda $a0,s
		and #$00ff
		ora #$c400
		sta $a0,s
		
		lda $a2,s
		and #$f000
		ora #$0488
		sta $a2,s
		
		lda #$cc8c
		sta $a4,s
		
		lda $a6,s
		and #$ff00
		ora #$00c4
		sta $a6,s
		
		tsc
		adc #$140
		tcs
		
		lda $0,s
		and #$00ff
		ora #$4c00
		sta $0,s
		
		lda #$c8cc
		sta $2,s
		
		lda #$8848
		sta $4,s
		
		lda $6,s
		and #$ff00
		ora #$004c
		sta $6,s
		
		lda #$c848
		sta $a2,s
		
		lda #$8c84
		sta $a4,s
		
		tsc
		adc #$140
		tcs
		
		lda $2,s
		and #$f0f0
		ora #$0c04
		sta $2,s
		
		lda $4,s
		and #$0f0f
		ora #$c040
		sta $4,s
		
		_spriteFooter
		rtl
		

shipExplosion7 entry
		_spriteHeader
		
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|..R.|....
; ....|...R|.G..|....
; ....|..GW|GW.G|....
; ....|RRGW|WG.R|....
; ....|G.WG|WG..|....
; ....|..G.|R...|....
; ....|....|....|....
; ....|....|....|....
;
		
		lda $4,s
		and #$0fff
		ora #$4000
		sta $4,s
		
		lda $a2,s
		and #$f0ff
		ora #$0400
		sta $a2,s
		
		lda $a4,s
		ora #$000c
		sta $a4,s
		
		tsc
		adc #$140
		tcs
		
		lda $2,s
		and #$00ff
		ora #$c800
		sta $2,s
		
		lda $4,s
		and #$f000
		ora #$0cc8
		sta $4,s
		
		lda #$c844
		sta $a2,s
		
		lda $a4,s
		and #$f000
		ora #$048c
		sta $a4,s
		
		tsc
		adc #$140
		tcs
		
		lda $2,s
		and #$000f
		ora #$8cc0
		sta $2,s
		
		lda $4,s
		and #$ff00
		ora #$008c
		sta $4,s
		
		lda $a2,s
		ora #$c000
		sta $a2,s
		
		lda $a4,s
		and #$ff0f
		ora #$0040
		sta $a4,s
		
		_spriteFooter
		rtl
		

shipExplosion8 entry
		_spriteHeader
		
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|....|....
; ....|....|....|....
; ....|....|....|....
; ....|..G.|G...|....
; ....|.RRG|WR..|....
; ....|..RG|G...|....
; ....|....|....|....
; ....|....|....|....
;
		
		tsc
		adc #$140
		tcs
		
		lda $a2,s
		ora #$c000
		sta $a2,s
		
		lda $a4,s
		ora #$00c0
		sta $a4,s
		
		tsc
		adc #$140
		tcs
		
		lda $2,s
		and #$00f0
		ora #$4c04
		sta $2,s
		
		lda $4,s
		and #$ff00
		ora #$0084
		sta $4,s
		
		lda $a2,s
		and #$00ff
		ora #$4c00
		sta $a2,s
		
		lda $a4,s
		ora #$00c0
		sta $a4,s
		
		_spriteFooter
		rtl
		
		
		end
