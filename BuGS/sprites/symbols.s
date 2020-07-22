;
;  symbols.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy symbols.macros
        keep symbols

symbols start
        using globalData

symbolC entry
        _spriteHeader
        
; Colours #$1100 - Black, Black, Green, Green (x2)
;         #$0011 - Green, Green, Black, Black (x2)
;         #$0201 - Black, Green, Black, Red (x2)
;         #$1020 - Red, Black, Green, Black (x2)
;         #$2010 - Green, Black, Red, Black (x4)
;         #$0102 - Black, Red, Black, Green (x2)
;         #$0100 - Black, Black, Black, Green (x2)
;
        ldx #$2010      ; Green, Black, Red, Black
        
        pea $0011
        pea $1100
        
        adc #$00a0
        tcs
        
        pea $1020
        pea $0201
        
        adc #$00a0
        tcs
        
        pea $0102
        phx
        
        adc #$00a0
        tcs
        
        pea $0100
        phx
        
        adc #$00a0
        tcs
        
        pea $0100
        phx
        
        adc #$00a0
        tcs
        
        pea $0102
        phx
        
        adc #$00a0
        tcs
        
        pea $1020
        pea $0201
        
        adc #$00a0
        tcs
        
        pea $0011
        pea $1100
        
        _spriteFooter
        rtl


symbolP entry
        _spriteHeader
        
; Colours #$1100 - Black, Black, Green, Green (x2)
;         #$0011 - Green, Green, Black, Black (x2)
;         #$0201 - Black, Green, Black, Red (x1)
;         #$1020 - Red, Black, Green, Black (x1)
;         #$2010 - Green, Black, Red, Black (x3)
;         #$0102 - Black, Red, Black, Green (x2)
;         #$2210 - Green, Black, Red, Red (x1)
;         #$0120 - Red, Black, Black, Green (x1)
;         #$0100 - Black, Black, Black, Green (x1)
;         #$2001 - Black, Green, Red, Black (x1)
;         #$1000 - Black, Black, Green, Black (x1)
;
        ldx #$2010      ; Green, Black, Red, Black
        
        pea $0011
        pea $1100
        
        adc #$00a0
        tcs
        
        pea $1020
        pea $0201
        
        adc #$00a0
        tcs
        
        pea $0102
        phx
        
        adc #$00a0
        tcs
        
        pea $0102
        phx
        
        adc #$00a0
        tcs
        
        pea $0120
        pea $2210
        
        adc #$00a0
        tcs
        
        pea $0100
        phx
        
        adc #$00a0
        tcs
        
        pea $1000
        pea $2001
        
        adc #$00a0
        tcs
        
        pea $0011
        pea $1100
        
        _spriteFooter
        rtl


symbolDot entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x15)
;         #$0030 - Off-white, Black, Black, Black (x1)
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
        
        pea $0030
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
        

symbolColon entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$0020 - Red, Black, Black, Black (x4)
;         #$0200 - Black, Black, Black, Red (x4)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0200      ; Black, Black, Black, Red
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $0020
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        phy
        
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
        
        pea $0020
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        phy
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        _spriteFooter
        rtl

        end
