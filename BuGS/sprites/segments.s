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

segments start spriteSeg
        using globalData

; IMPORTANT!!!! - It is critical that the X register is preserved in all of these
; draw routines.  The caller to this uses the X register to hold the head/segment
; number that is being drawn.  If the X register is changed in any way, the draw
; routine will fail.

leftHead1 entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _leftHead
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl


leftHead1s entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _leftHeadShift
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl


leftHead2 entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _leftHead
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftHead2s entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _leftHeadShift
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl


leftHead3 entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _leftHead
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftHead3s entry
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
        
        lda $2,s
        and #$0fff
        ora #$8000
        sta $2,s
        
        _leftHeadShift
        
        lda $a2,s
        and #$0fff
        ora #$8000
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftHead4 entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _leftHead
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl
        

leftHead4s entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _leftHeadShift
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl
        

leftHead5 entry
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
        
        lda $0,s
        and #$fff0
        ora #$0008
        sta $0,s
        
        _leftHead
        
        lda $a0,s
        and #$fff0
        ora #$0008
        sta $a0,s
        
        _spriteFooter
        rtl
        

leftHead5s entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _leftHeadShift
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl


leftBody1 entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _leftBody
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl


leftBody1s entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _leftBodyShift
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl


leftBody2 entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _leftBody
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftBody2s entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _leftBodyShift
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl


leftBody3 entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _leftBody
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftBody3s entry
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
        
        lda $2,s
        and #$0fff
        ora #$8000
        sta $2,s
        
        _leftBodyShift
        
        lda $a2,s
        and #$0fff
        ora #$8000
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftBody4 entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _leftBody
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl
        

leftBody4s entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _leftBodyShift
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl
        

leftBody5 entry
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
        
        lda $0,s
        and #$fff0
        ora #$0008
        sta $0,s
        
        _leftBody
        
        lda $a0,s
        and #$fff0
        ora #$0008
        sta $a0,s
        
        _spriteFooter
        rtl
        

leftBody5s entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _leftBodyShift
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl


rightHead1 entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _rightHead
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl


rightHead1s entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _rightHeadShift
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl


rightHead2 entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _rightHead
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl


rightHead2s entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _rightHeadShift
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl
        

rightHead3 entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _rightHead
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl


rightHead3s entry
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
        
        lda $0,s
        and #$fff0
        ora #$0008
        sta $0,s
        
        _rightHeadShift
        
        lda $a0,s
        and #$fff0
        ora #$0008
        sta $a0,s
        
        _spriteFooter
        rtl


rightHead4 entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _rightHead
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl


rightHead4s entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _rightHeadShift
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl
        

rightHead5 entry
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
        
        lda $2,s
        and #$0fff
        ora #$8000
        sta $2,s
        
        _rightHead
        
        lda $a2,s
        and #$0fff
        ora #$8000
        sta $a2,s
        
        _spriteFooter
        rtl


rightHead5s entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _rightHeadShift
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl
        

rightBody1 entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _rightBody
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl


rightBody1s entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _rightBodyShift
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl


rightBody2 entry
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
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        _rightBody
        
        lda $a0,s
        and #$f0ff
        ora #$0800
        sta $a0,s
        
        _spriteFooter
        rtl


rightBody2s entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _rightBodyShift
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl
        

rightBody3 entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        _rightBody
        
        lda $a0,s
        and #$0fff
        ora #$8000
        sta $a0,s
        
        _spriteFooter
        rtl


rightBody3s entry
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
        
        lda $0,s
        and #$fff0
        ora #$0008
        sta $0,s
        
        _rightBodyShift
        
        lda $a0,s
        and #$fff0
        ora #$0008
        sta $a0,s
        
        _spriteFooter
        rtl


rightBody4 entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _rightBody
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl


rightBody4s entry
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
        
        lda $2,s
        and #$ff0f
        ora #$0080
        sta $2,s
        
        _rightBodyShift
        
        lda $a2,s
        and #$ff0f
        ora #$0080
        sta $a2,s
        
        _spriteFooter
        rtl
        

rightBody5 entry
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
        
        lda $2,s
        and #$0fff
        ora #$8000
        sta $2,s
        
        _rightBody
        
        lda $a2,s
        and #$0fff
        ora #$8000
        sta $a2,s
        
        _spriteFooter
        rtl


rightBody5s entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        _rightBodyShift
        
        lda $a2,s
        and #$fff0
        ora #$0008
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftDownHead1 entry
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
        
        lda $a0,s
        and #$000f
        ora #$cc80
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$141
        tcs
        
        lda $0,s
        and #$00f0
        ora #$440c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda $a0,s
        and #$00ff
        ora #$4400
        sta $a0,s
        
        lda $a2,s
        and #$0f0f
        ora #$80c0
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftDownHead1s entry
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
        
        lda $a0,s
        and #$f0f0
        ora #$0c08
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$00f0
        ora #$4c04
        sta $0,s

        lda #$cccc
        sta $2,s

        lda $a0,s
        and #$00f0
        ora #$4c04
        sta $a0,s

        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$00ff
        ora #$c400
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$c04c
        sta $2,s
        
        lda $a0,s
        and #$f0ff
        ora #$0400
        sta $a0,s
        
        lda $a2,s
        and #$f000
        ora #$084c
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftDownHead2 entry
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

        lda $0,s
        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$141
        tcs
        
        lda $0,s
        and #$00f0
        ora #$440c
        sta $0,s
        
        lda $2,s
        and #$f000
        ora #$08cc
        sta $2,s
        
        lda $a0,s
        and #$00ff
        ora #$4400
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftDownHead2s entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $a0,s
        and #$f0ff
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$00f0
        ora #$4c04
        sta $0,s

        lda #$cccc
        sta $2,s

        lda $a0,s
        and #$00f0
        ora #$4c04
        sta $a0,s

        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$00ff
        ora #$c400
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$c04c
        sta $2,s
        
        lda $4,s
        and #$ff0f
        ora #$0080
        sta $4,s
        
        lda $a0,s
        and #$f0ff
        ora #$0400
        sta $a0,s
        
        lda $a2,s
        and #$ff00
        ora #$004c
        sta $a2,s
        
        _spriteFooter
        rtl
   

leftDownBody1 entry
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
        
        lda $a0,s
        and #$000f
        ora #$cc80
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$141
        tcs
        
        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
        and #$0f0f
        ora #$80c0
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftDownBody1s entry
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
        
        lda $a0,s
        and #$f0f0
        ora #$0c08
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s

        lda #$cccc
        sta $2,s

        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s

        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
        and #$f000
        ora #$08cc
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftDownBody2 entry
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

        lda $0,s
        and #$fff0
        ora #$0008
        sta $0,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$141
        tcs
        
        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
        and #$f000
        ora #$08cc
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        _spriteFooter
        rtl
        

leftDownBody2s entry
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
        
        lda $0,s
        and #$0fff
        ora #$8000
        sta $0,s
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s

        lda #$cccc
        sta $2,s

        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s

        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $4,s
        and #$ff0f
        ora #$0080
        sta $4,s
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        _spriteFooter
        rtl


rightDownHead1 entry
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
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
        and #$0f0f
        ora #$80c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$141
        tcs
        
        lda $0,s
        and #$00f0
        ora #$c40c
        sta $0,s
        
        lda $2,s
        and #$ff00
        ora #$004c
        sta $2,s
        
        lda $a0,s
        and #$000f
        ora #$c480
        sta $a0,s
        
        lda $a2,s
        and #$ff0f
        ora #$0040
        sta $a2,s
        
        _spriteFooter
        rtl
        

rightDownHead1s entry
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
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
        and #$f000
        ora #$08cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s

        lda #$44cc
        sta $2,s

        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s

        lda #$44cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$c044
        sta $2,s
        
        lda $a0,s
        and #$f0f0
        ora #$0c08
        sta $a0,s
        
        lda $a2,s
        and #$ff00
        ora #$0044
        sta $a2,s
        
        _spriteFooter
        rtl


rightDownHead2 entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$13f
        tcs
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
        and #$00f0
        ora #$c40c
        sta $2,s
        
        lda $4,s
        and #$ff00
        ora #$004c
        sta $4,s
        
        lda $a2,s
        and #$00ff
        ora #$c400
        sta $a2,s
        
        lda $a4,s
        and #$ff0f
        ora #$0040
        sta $a4,s
        
        _spriteFooter
        rtl


rightDownHead2s entry
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

        lda $2,s
        and #$0fff
        ora #$8000
        sta $2,s
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s

        lda #$44cc
        sta $2,s

        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s

        lda #$44cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$000f
        ora #$cc80
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$c044
        sta $2,s
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
        and #$ff00
        ora #$0044
        sta $a2,s
        
        _spriteFooter
        rtl


rightDownBody1 entry
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
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
        and #$0f0f
        ora #$80c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$141
        tcs
        
        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda $a0,s
        and #$000f
        ora #$cc80
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        _spriteFooter
        rtl
        

rightDownBody1s entry
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
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
        and #$f000
        ora #$08cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s

        lda #$cccc
        sta $2,s

        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s

        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
        and #$f0f0
        ora #$0c08
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        _spriteFooter
        rtl


rightDownBody2 entry
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
        
        lda $2,s
        and #$fff0
        ora #$0008
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda #$cccc
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$141
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
        adc #$13f
        tcs
        
        lda $0,s
        and #$f0ff
        ora #$0800
        sta $0,s
        
        lda $2,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $2,s
        
        lda $4,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $4,s
        
        lda $a2,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a2,s
        
        lda $a4,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a4,s
        
        _spriteFooter
        rtl


rightDownBody2s entry
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

        lda $2,s
        and #$0fff
        ora #$8000
        sta $2,s
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s

        lda #$cccc
        sta $2,s

        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s

        lda #$cccc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$000f
        ora #$cc80
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        _spriteFooter
        rtl


downHead1 entry
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

        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$143
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
        adc #$141
        tcs
        
        lda $0,s
        and #$00f0
        ora #$4c04
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$40c4
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        _spriteFooter
        rtl
        

downHead2 entry
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

        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$000f
        ora #$cc80
        sta $0,s
        
        lda $2,s
        and #$f000
        ora #$08cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$4c04
        sta $a0,s
        
        lda $a2,s
        and #$0f00
        ora #$40c4
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$00f0
        ora #$4c04
        sta $0,s
        
        lda $2,s
        and #$0f00
        ora #$40c4
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        _spriteFooter
        rtl


downHead3 entry
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

        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
        and #$00f0
        ora #$4c04
        sta $a0,s
        
        lda $a2,s
        and #$0f00
        ora #$40c4
        sta $a2,s
        
        tsc
        adc #$143
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

        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$143
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
        adc #$141
        tcs
        
        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        _spriteFooter
        rtl
        

downBody2 entry
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

        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        and #$000f
        ora #$cc80
        sta $0,s
        
        lda $2,s
        and #$f000
        ora #$08cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $a0,s
        
        lda $a2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $a2,s
        
        _spriteFooter
        rtl


downBody3 entry
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

        lda $a0,s
;        and #$f0ff     not necessary with pure green
        ora #$0c00
        sta $a0,s
        
        lda $a2,s
;        and #$ff0f     not necessary with pure green
        ora #$00c0
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00ff     not necessary with pure green
        ora #$cc00
        sta $0,s
        
        lda $2,s
;        and #$ff00     not necessary with pure green
        ora #$00cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $0,s
        
        lda $2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $2,s
        
        lda $a0,s
;        and #$00f0     not necessary with pure green
        ora #$cc0c
        sta $a0,s
        
        lda $a2,s
;        and #$0f00     not necessary with pure green
        ora #$c0cc
        sta $a2,s
        
        tsc
        adc #$143
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

        end
