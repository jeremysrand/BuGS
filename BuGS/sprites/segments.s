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


leftBody1 entry
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
; .GGG|G...
; GGGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GG..
; .GGG|G...
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        _leftBody
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl


leftBody1s entry
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
; ..GG|GG..
; .GGG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGG.
; ..GG|GG..
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        _leftBodyShift
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl


leftBody2 entry
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
; .GGG|G...
; GGGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GG..
; .GGG|G...
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        _leftBody
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftBody2s entry
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
; ..GG|GG..
; .GGG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGG.
; ..GG|GG..
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _leftBodyShift
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl


leftBody3 entry
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
; .GGG|G...
; GGGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GG..
; .GGG|G...
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _leftBody
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftBody3s entry
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
; ..GG|GG..
; .GGG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGG.
; ..GG|GG..
; ....|..O.
        
        lda $3,s
        and #$0fff
        ora #$8000
        sta $3,s
        
        _leftBodyShift
        
        lda $a3,s
        and #$0fff
        ora #$8000
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftBody4 entry
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
; .GGG|G...
; GGGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GG..
; .GGG|G...
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _leftBody
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl
        

leftBody4s entry
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
; ..GG|GG..
; .GGG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGG.
; ..GG|GG..
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        _leftBodyShift
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl
        

leftBody5 entry
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
; .GGG|G...
; GGGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GG..
; .GGG|G...
; .O..|....
        
        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        _leftBody
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        _spriteFooter
        rtl
        

leftBody5s entry
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
; ..GG|GG..
; .GGG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGG.
; ..GG|GG..
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _leftBodyShift
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl


rightHead1 entry
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
; ...G|GRR.
; ..GG|GRRG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GRRG
; ...G|GRR.
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        _rightHead
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl


rightHead1s entry
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
; ..GG|RR..
; .GGG|RRG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|RRG.
; ..GG|RR..
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        _rightHeadShift
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl


rightHead2 entry
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
; ...G|GRR.
; ..GG|GRRG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GRRG
; ...G|GRR.
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        _rightHead
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl


rightHead2s entry
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
; ..GG|RR..
; .GGG|RRG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|RRG.
; ..GG|RR..
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _rightHeadShift
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl
        

rightHead3 entry
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
; ...G|GRR.
; ..GG|GRRG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GRRG
; ...G|GRR.
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _rightHead
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl


rightHead3s entry
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
; ..GG|RR..
; .GGG|RRG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|RRG.
; ..GG|RR..
; .O..|....
        
        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        _rightHeadShift
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        _spriteFooter
        rtl


rightHead4 entry
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
; ...G|GRR.
; ..GG|GRRG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GRRG
; ...G|GRR.
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _rightHead
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl


rightHead4s entry
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
; ..GG|RR..
; .GGG|RRG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|RRG.
; ..GG|RR..
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        _rightHeadShift
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl
        

rightHead5 entry
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
; ...G|GRR.
; ..GG|GRRG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GRRG
; ...G|GRR.
; ....|..O.
        
        lda $3,s
        and #$0fff
        ora #$8000
        sta $3,s
        
        _rightHead
        
        lda $a3,s
        and #$0fff
        ora #$8000
        sta $a3,s
        
        _spriteFooter
        rtl


rightHead5s entry
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
; ..GG|RR..
; .GGG|RRG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|RRG.
; ..GG|RR..
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _rightHeadShift
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl
        

rightBody1 entry
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
; ...G|GGG.
; ..GG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGGG
; ...G|GGG.
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        _rightBody
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl


rightBody1s entry
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
; ..GG|GG..
; .GGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GGG.
; ..GG|GG..
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        _rightBodyShift
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl


rightBody2 entry
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
; ...G|GGG.
; ..GG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGGG
; ...G|GGG.
; ...O|....
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        _rightBody
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        _spriteFooter
        rtl


rightBody2s entry
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
; ..GG|GG..
; .GGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GGG.
; ..GG|GG..
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _rightBodyShift
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl
        

rightBody3 entry
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
; ...G|GGG.
; ..GG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGGG
; ...G|GGG.
; ..O.|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        _rightBody
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        _spriteFooter
        rtl


rightBody3s entry
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
; ..GG|GG..
; .GGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GGG.
; ..GG|GG..
; .O..|....
        
        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        _rightBodyShift
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        _spriteFooter
        rtl


rightBody4 entry
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
; ...G|GGG.
; ..GG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGGG
; ...G|GGG.
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _rightBody
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl


rightBody4s entry
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
; ..GG|GG..
; .GGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GGG.
; ..GG|GG..
; ....|O...
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        _rightBodyShift
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        _spriteFooter
        rtl
        

rightBody5 entry
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
; ...G|GGG.
; ..GG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGGG
; ...G|GGG.
; ....|..O.
        
        lda $3,s
        and #$0fff
        ora #$8000
        sta $3,s
        
        _rightBody
        
        lda $a3,s
        and #$0fff
        ora #$8000
        sta $a3,s
        
        _spriteFooter
        rtl


rightBody5s entry
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
; ..GG|GG..
; .GGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GGG.
; ..GG|GG..
; ....|.O..
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        _rightBodyShift
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftDownHead1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; O.GG|G...
; .GGG|GG..
; GGGG|GGG.
; RRGG|GGG.
; RRGG|GGG.
; .GRR|GG..
; ..RR|G.O.
        
        lda $a1,s
        and #$000f
        ora #$cc80
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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
        
        pea $cc44

        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s

        lda #$cc44
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$440c
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a1,s
        and #$00ff
        ora #$4400
        sta $a1,s
        
        lda $a3,s
        and #$0f0f
        ora #$80c0
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftDownHead1s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; .O.G|GG..
; ..GG|GGG.
; .GGG|GGGG
; .RRG|GGGG
; .RRG|GGGG
; ..GR|RGG.
; ...R|RG.O
        
        lda $a1,s
        and #$f0f0
        ora #$0c08
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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
        and #$00f0
        ora #$4c04
        sta $1,s

        lda #$cccc
        sta $3,s

        lda $a1,s
        and #$00f0
        ora #$4c04
        sta $a1,s

        lda #$cccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00ff
        ora #$c400
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$c04c
        sta $3,s
        
        lda $a1,s
        and #$f0ff
        ora #$0400
        sta $a1,s
        
        lda $a3,s
        and #$f000
        ora #$084c
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftDownHead2 entry
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
; ..GG|G...
; .GGG|GG..
; GGGG|GGG.
; RRGG|GGG.
; RRGG|GGG.
; .GRR|GG.O
; ..RR|G...

        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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
        
        pea $cc44

        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s

        lda #$cc44
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$440c
        sta $1,s
        
        lda $3,s
        and #$f000
        ora #$08cc
        sta $3,s
        
        lda $a1,s
        and #$00ff
        ora #$4400
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftDownHead2s entry
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
; ...G|GG..
; ..GG|GGG.
; .GGG|GGGG
; .RRG|GGGG
; .RRG|GGGG
; ..GR|RGG.|O...
; ...R|RG..
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $a1,s
        and #$f0ff
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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
        and #$00f0
        ora #$4c04
        sta $1,s

        lda #$cccc
        sta $3,s

        lda $a1,s
        and #$00f0
        ora #$4c04
        sta $a1,s

        lda #$cccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00ff
        ora #$c400
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$c04c
        sta $3,s
        
        lda $5,s
        and #$ff0f
        ora #$0080
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0400
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$004c
        sta $a3,s
        
        _spriteFooter
        rtl
   

leftDownBody1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; O.GG|G...
; .GGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GG..
; ..GG|G.O.
        
        lda $a1,s
        and #$000f
        ora #$cc80
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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

        lda #$cccc
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
        and #$0f0f
        ora #$80c0
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftDownBody1s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; .O.G|GG..
; ..GG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGG.
; ...G|GG.O
        
        lda $a1,s
        and #$f0f0
        ora #$0c08
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s

        lda #$cccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        and #$f000
        ora #$08cc
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftDownBody2 entry
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
; ..GG|G...
; .GGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GG.O
; ..GG|G...

        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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

        lda #$cccc
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
        and #$f000
        ora #$08cc
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        _spriteFooter
        rtl
        

leftDownBody2s entry
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
; ...G|GG..
; ..GG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGG.|O...
; ...G|GG..
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $a1,s
        and #$f0ff
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s

        lda #$cccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $5,s
        and #$ff0f
        ora #$0080
        sta $5,s
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl


rightDownHead1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ..GG|G.O.
; .GGG|GG..
; GGGG|GGG.
; GGGG|GRR.
; GGGG|GRR.
; .GGR|RG..
; O.GR|R...
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
        and #$0f0f
        ora #$80c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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
        and #$0f00
        ora #$40c4
        sta $3,s

        lda #$cccc
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$40c4
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$c40c
        sta $1,s
        
        lda $3,s
        and #$ff00
        ora #$004c
        sta $3,s
        
        lda $a1,s
        and #$000f
        ora #$c480
        sta $a1,s
        
        lda $a3,s
        and #$ff0f
        ora #$0040
        sta $a3,s
        
        _spriteFooter
        rtl
        

rightDownHead1s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|GG.O
; ..GG|GGG.
; .GGG|GGGG
; .GGG|GGRR
; .GGG|GGRR
; ..GG|RRG.
; .O.G|RR..
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        and #$f000
        ora #$08cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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

        lda #$44cc
        sta $3,s

        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s

        lda #$44cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$c044
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0c08
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0044
        sta $a3,s
        
        _spriteFooter
        rtl


rightDownHead2 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|.O..
; ....|..GG|G...
; ....|.GGG|GG..
; ....|GGGG|GGG.
; ....|GGGG|GRR.
; ....|GGGG|GRR.
; ...O|.GGR|RG..
; ....|..GR|R...
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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
        and #$0f00
        ora #$40c4
        sta $3,s

        lda #$cccc
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$40c4
        sta $a3,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$c40c
        sta $3,s
        
        lda $5,s
        and #$ff00
        ora #$004c
        sta $5,s
        
        lda $a3,s
        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
        and #$ff0f
        ora #$0040
        sta $a5,s
        
        _spriteFooter
        rtl


rightDownHead2s entry
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
; ...G|GG..
; ..GG|GGG.
; .GGG|GGGG
; .GGG|GGRR
; .GGG|GGRR
; O.GG|RRG.
; ...G|RR..

        lda $3,s
        and #$0fff
        ora #$8000
        sta $3,s
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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

        lda #$44cc
        sta $3,s

        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s

        lda #$44cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$000f
        ora #$cc80
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$c044
        sta $3,s
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0044
        sta $a3,s
        
        _spriteFooter
        rtl


rightDownBody1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ..GG|G.O.
; .GGG|GG..
; GGGG|GGG.
; GGGG|GGG.
; GGGG|GGG.
; .GGG|GG..
; O.GG|G...
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
        and #$0f0f
        ora #$80c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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

        lda #$cccc
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a1,s
        and #$000f
        ora #$cc80
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        _spriteFooter
        rtl
        

rightDownBody1s entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|GG.O
; ..GG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; ..GG|GGG.
; .O.G|GG..
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        and #$f000
        ora #$08cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s

        lda #$cccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0c08
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl


rightDownBody2 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|.O..
; ....|..GG|G...
; ....|.GGG|GG..
; ....|GGGG|GGG.
; ....|GGGG|GGG.
; ....|GGGG|GGG.
; ...O|.GGG|GG..
; ....|..GG|G...
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
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

        lda #$cccc
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $3,s
        
        lda $5,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $5,s
        
        lda $a3,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a3,s
        
        lda $a5,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a5,s
        
        _spriteFooter
        rtl


rightDownBody2s entry
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
; ...G|GG..
; ..GG|GGG.
; .GGG|GGGG
; .GGG|GGGG
; .GGG|GGGG
; O.GG|GGG.
; ...G|GG..

        lda $3,s
        and #$0fff
        ora #$8000
        sta $3,s
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
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
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s

        lda #$cccc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$000f
        ora #$cc80
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl


downHead1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|G...
; ..GG|GG..
; .GGG|GGG.
; OGGG|GGGO
; .RRG|GRR.
; .RRG|GRR.
; ..GG|GG..

        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$144
        tcs
        
        pea $c8cc
        pea $cc8c

        lda $a1,s
        and #$00f0
        ora #$4c04
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$40c4
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$4c04
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$40c4
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl
        

downHead2 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|G...
; O.GG|GG.O
; .GGG|GGG.
; .GGG|GGG.
; .RRG|GRR.
; .RRG|GRR.
; ..GG|GG..

        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
        and #$000f
        ora #$cc80
        sta $1,s
        
        lda $3,s
        and #$f000
        ora #$08cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$4c04
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$40c4
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$4c04
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$40c4
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl


downHead3 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|G...
; ..GG|GG..
; .GGG|GGG.
; .GGG|GGG.
; .RRG|GRR.
; ORRG|GRRO
; ..GG|GG..

        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$4c04
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$40c4
        sta $a3,s
        
        tsc
        adc #$144
        tcs
        
        pea $48c4
        pea $4c84
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl
        

downBody1 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|G...
; ..GG|GG..
; .GGG|GGG.
; OGGG|GGGO
; .GGG|GGG.
; .GGG|GGG.
; ..GG|GG..

        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$144
        tcs
        
        pea $c8cc
        pea $cc8c

        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl
        

downBody2 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|G...
; O.GG|GG.O
; .GGG|GGG.
; .GGG|GGG.
; .GGG|GGG.
; .GGG|GGG.
; ..GG|GG..

        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
        and #$000f
        ora #$cc80
        sta $1,s
        
        lda $3,s
        and #$f000
        ora #$08cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl


downBody3 entry
        dex
        dex
        dex
        dex
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ...G|G...
; ..GG|GG..
; .GGG|GGG.
; .GGG|GGG.
; .GGG|GGG.
; OGGG|GGGO
; ..GG|GG..

        lda $a1,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $1,s
        
        lda $3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$140
        tcs

        lda $1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $1,s
        
        lda $3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $3,s
        
        lda $a1,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a1,s
        
        lda $a3,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a3,s
        
        tsc
        adc #$144
        tcs
        
        pea $c8cc
        pea $cc8c
        
        lda $a1,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a1,s
        
        lda $a3,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a3,s
        
        _spriteFooter
        rtl
  

backupStack dc i2'0'

        end
