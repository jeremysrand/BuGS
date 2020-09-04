;
;  shot.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-09.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy shot.macros
        keep shot

shot start spriteSeg
        using globalData

drawHalfShot entry
        _spriteHeader
        
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ....|....
; ....|....
; ....|....
; ....|....
; ...R|....
; ...R|....
; ...R|....
        
        tsc
        adc #$280
        tcs
        
        lda $a0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $a0,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $0,s
        
        lda $a0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $a0,s
        
        _spriteFooter
        
        lda collision
        rtl
        
        
drawHalfShotShift entry
        _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ....|....
; ....|....
; ....|....
; ....|....
; ....|R...
; ....|R...
; ....|R...

        tsc
        adc #$280
        tcs

        lda $a2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $a2,s

        tsc
        adc #$140
        tcs

        lda $2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $2,s

        lda $a2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $a2,s
        
        _spriteFooter

        lda collision
        rtl
        
    
drawShot entry
        _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ....|....
; ...R|....
; ...R|....
; ...R|....
; ...R|....
; ...R|....
; ...R|....
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $0,s
        
        lda $a0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $a0,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $0,s
        
        lda $a0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $a0,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $0,s
        
        lda $a0,s
        _collision #$0f00
        and #$f0ff
        ora #$0400
        sta $a0,s
        
        _spriteFooter

        lda collision
        rtl
        
        
drawShotShift entry
        _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....
; ....|....
; ....|R...
; ....|R...
; ....|R...
; ....|R...
; ....|R...
; ....|R...

        tsc
        adc #$140
        tcs

        lda $2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $2,s

        lda $a2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $a2,s
        
        tsc
        adc #$140
        tcs

        lda $2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $2,s

        lda $a2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $a2,s

        tsc
        adc #$140
        tcs

        lda $2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $2,s

        lda $a2,s
        _collision #$00f0
        and #$ff0f
        ora #$0040
        sta $a2,s
        
        _spriteFooter

        lda collision
        rtl
        
        
collision   dc i2'0'

        end
