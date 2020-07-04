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

leftHead1 entry
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
        
        _leftHead
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl


leftHead1s entry
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
        
        _leftHeadShift
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl


leftHead2 entry
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
; .RRG|G...
; GRRG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GRRG|GG..
; .RRG|G...
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        _leftHead
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftHead2s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|.O..
; ..RR|GG..
; .GRR|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GRR|GGG.
; ..RR|GG..
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _leftHeadShift
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl


leftHead3 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|.O..
; .RRG|G...
; GRRG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GRRG|GG..
; .RRG|G...
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _leftHead
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftHead3s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..O.
; ..RR|GG..
; .GRR|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GRR|GGG.
; ..RR|GG..
; ....|..O.
        
        lda $3,s
        and #$0fff
        ora #$8000
        sta $3,s
        
        _leftHeadShift
        
        lda $a3,s
        and #$0fff
        ora #$8000
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftHead4 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ..O.|....
; .RRG|G...
; GRRG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GRRG|GG..
; .RRG|G...
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _leftHead
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl
        

leftHead4s entry
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
; ..RR|GG..
; .GRR|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GRR|GGG.
; ..RR|GG..
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        _leftHeadShift
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl
        

leftHead5 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; .O..|....
; .RRG|G...
; GRRG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GRRG|GG..
; .RRG|G...
; .O..|....
        
        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        _leftHead
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        _spriteFooter
        rtl
        

leftHead5s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ..O.|....
; ..RR|GG..
; .GRR|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GRR|GGG.
; ..RR|GG..
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _leftHeadShift
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'

        end
