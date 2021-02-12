;
;  solid.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case  on
        mcopy solid.macros
        keep solid

solid start spriteSeg
        using globalData

solid0  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x16)
;
        ldx #$0000      ; Black, Black, Black, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        _spriteFooter
        rtl
        

solid1  entry
        _spriteHeader
        
; Colours #$1111 - Green, Green, Green, Green  (x16)
;
        ldx #$1111      ; Green, Green, Green, Green
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        _spriteFooter
        rtl


solid2  entry
        _spriteHeader
        
; Colours #$2222 - Red, Red, Red, Red (x16)
;
        ldx #$2222      ; Red, Red, Red, Red
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        _spriteFooter
        rtl


solid3  entry
        _spriteHeader
        
; Colours #$3333 - Off-white, Off-white,  Off-white,  Off-white (x16)
;
        ldx #$3333      ; Off-white, Off-white,  Off-white,  Off-white
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        _spriteFooter
        rtl
		
		
rightBar entry
		_spriteHeader
		
		ldx #$0000
		ldy #$2002
		
		phy
		phx
		
		adc #$00a0
		tcs
		
		phy
		phx
		
		adc #$00a0
		tcs
		
		phy
		phx
		
		adc #$00a0
		tcs
		
		phy
		phx
		
		adc #$00a0
		tcs
		
		phy
		phx
		
		adc #$00a0
		tcs
		
		phy
		phx
		
		adc #$00a0
		tcs
		
		phy
		phx
		
		adc #$00a0
		tcs
		
		phy
		phx
		
		_spriteFooter
		rtl
		
		
leftBar entry
		_spriteHeader
		
		ldx #$2002
		ldy #$0000

		phy
		phx

		adc #$00a0
		tcs

		phy
		phx

		adc #$00a0
		tcs

		phy
		phx

		adc #$00a0
		tcs

		phy
		phx

		adc #$00a0
		tcs

		phy
		phx

		adc #$00a0
		tcs

		phy
		phx

		adc #$00a0
		tcs

		phy
		phx

		adc #$00a0
		tcs

		phy
		phx

		_spriteFooter
		rtl

        end
