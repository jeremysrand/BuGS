;
;  numbers.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy numbers.macros
        keep numbers

numbers start


number0  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0020 - Red, Black, Black, Black (x2)
;         #$2200 - Black, Black, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$0002 - Black, Red, Black, Black (x2)
;
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2002      ; Black, Red, Red, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2200
        
        adc #$00a0
        tcs
        
        phx
        pea $0002
        
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
        
        pea $0002
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2200
        
        _spriteFooter
        rtl


number1  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$2200 - Black, Black, Red, Red (x5)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$2202 - Black, Red, Red, Red (x1)
;         #$2222 - Red, Red, Red, Red (x1)
;
        ldx #$2200      ; Black, Black, Red, Red
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
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
        
        pea $0022
        pea $2222
        
        _spriteFooter
        rtl


number2  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2202 - Black, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x1)
;         #$2022 - Red, Red, Red, Black (x3)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$2222 - Red, Red, Red, Red (x1)
;
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phx
        pea $2202
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        pea $2022
        phy
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2202
        
        adc #$00a0
        tcs
        
        phy
        pea $2022
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2222
        
        _spriteFooter
        rtl


number3  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2202 - Black, Red, Red, Red (x2)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$0200 - Black, Black, Black, Red (x1)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$2002 - Black, Red, Red, Black (x2)
;
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2202
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $0200
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2202
        
        _spriteFooter
        rtl


number4  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$0200 - Black, Black, Black, Red (x1)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$2002 - Black, Red, Red, Black (x1)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phx
        pea $0200
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
        adc #$00a0
        tcs
        
        phx
        pea $2002
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2222
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        _spriteFooter
        rtl


number5  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x5)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$2202 - Black, Red, Red, Red (x1)
;
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2202
        
        _spriteFooter
        rtl


number6  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2202 - Black, Red, Red, Red (x1)
;
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
        adc #$00a0
        tcs
        
        phy
        pea $2002
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2202
        
        _spriteFooter
        rtl


number7  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x6)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$2002 - Black, Red, Red, Black (x1)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$0200 - Black, Black, Black, Red (x1)
;         #$2200 - Black, Black, Red, Red (x3)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$2200      ; Black, Black, Red, Red
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $2002
        pea $0022
        
        adc #$00a0
        tcs
        
        pea $0022
        phx
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $0200
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        _spriteFooter
        rtl


number8  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0020 - Red, Black, Black, Black (x3)
;         #$2202 - Black, Red, Red, Red (x3)
;         #$0002 - Black, Red, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$2022 - Red, Red, Red, Black (x2)
;         #$2002 - Black, Red, Red, Black (x1)
;         #$0220 - Red, Black, Black, Red (x1)
;
        ldx #$0020      ; Red, Black, Black, Black
        ldy #$2202      ; Black, Red, Red, Red
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        pea $0002
        pea $0022
        
        adc #$00a0
        tcs
        
        pea $0002
        pea $2022
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $0220
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        pea $0022
        phy
        
        _spriteFooter
        rtl


number9  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2202 - Black, Red, Red, Red (x3)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phx
        pea $2202
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2202
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2202
        
        _spriteFooter
        rtl


backupStack dc i2'0'

        end
