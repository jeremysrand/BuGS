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
; .R..
; .R..
; .R..
        
		lda $0,s
		and #$fff0
		ora #$0004
		sta $0,s
        
        lda $a0,s
        and #$fff0
        ora #$0004
        sta $a0,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        and #$fff0
        ora #$0004
        sta $0,s
        
        _spriteFooter
        rtl
        
        
drawHalfShotShift entry
        _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; R...
; R...
; R...

		lda $0,s
		and #$ff0f
		ora #$0040
		sta $0,s

        lda $a0,s
        and #$ff0f
        ora #$0040
        sta $a0,s

        tsc
        adc #$140
        tcs

        lda $0,s
        and #$ff0f
        ora #$0040
        sta $0,s
        
        _spriteFooter
        rtl
        
    
drawShot entry
        _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; .R..
; .R..
; .R..
; .R..
; .R..
; .R..
; ....
; ....
        
		lda #0
		sta >collision
        
        lda $0,s
        _collision #$00ff,#$0
        and #$fff0
        ora #$0004
        sta $0,s
        
        lda $a0,s
        _collision #$00ff,#$a0
        and #$fff0
        ora #$0004
        sta $a0,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        _collision #$00ff,#$0
        and #$fff0
        ora #$0004
        sta $0,s
        
        lda $a0,s
        _collision #$00ff,#$a0
        and #$fff0
        ora #$0004
        sta $a0,s
        
        tsc
        adc #$140
        tcs
        
        lda $0,s
        _collision #$00ff,#$0
        and #$fff0
        ora #$0004
        sta $0,s
        
        lda $a0,s
        _collision #$00ff,#$a0
        and #$fff0
        ora #$0004
        sta $a0,s
		
		tsc
		adc #$140
		tcs

		lda $0,s
		_collision #$00ff,#$0

		lda $a0,s
		_collision #$00ff,#$a0
        
        _spriteFooter
		
		lda >collisionAddr
		tax
        lda >collision
        rtl
        
        
drawShotShift entry
        _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; R...
; R...
; R...
; R...
; R...
; R...
; ....
; ....

		lda #0
		sta >collision

        lda $0,s
        _collision #$00ff,#$0
        and #$ff0f
        ora #$0040
        sta $0,s

        lda $a0,s
        _collision #$00ff,#$a0
        and #$ff0f
        ora #$0040
        sta $a0,s
        
        tsc
        adc #$140
        tcs

        lda $0,s
        _collision #$00ff,#$0
        and #$ff0f
        ora #$0040
        sta $0,s

        lda $a0,s
        _collision #$00ff,#$a0
        and #$ff0f
        ora #$0040
        sta $a0,s

        tsc
        adc #$140
        tcs

        lda $0,s
        _collision #$00ff,#$0
        and #$ff0f
        ora #$0040
        sta $0,s

        lda $a0,s
        _collision #$00ff,#$a0
        and #$ff0f
        ora #$0040
        sta $a0,s

		tsc
		adc #$140
		tcs

		lda $0,s
		_collision #$00ff,#$0

		lda $a0,s
		_collision #$00ff,#$a0
        
        _spriteFooter

		lda >collisionAddr
		tax
        lda >collision
        rtl

        end
