;
;  letters.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy letters.macros
        keep letters

letters start
        using globalData

letterA entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$2002 - Black, Red, Red, Black (x5)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2200
        
        adc #$00a0
        tcs
        
        phy
        phx
        
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


letterB entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2222 - Red, Red, Red, Red (x3)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2022 - Red, Red, Red, Black (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2222
        
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
        
        pea $0022
        pea $2222
        
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
        
        pea $0022
        pea $2222
        
        _spriteFooter
        rtl


letterC entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x5)
;         #$2200 - Black, Black, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$2002 - Black, Red, Red, Black (x4)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2002
        pea $2002
        
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
        
        adc #$00a0
        tcs
        
        pea $2002
        pea $2002
        
        adc #$00a0
        tcs
        
        phy
        pea $2200
        
        _spriteFooter
        rtl


letterD entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0020 - Red, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x3)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        phy
        
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
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2222
        
        _spriteFooter
        rtl


letterE entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x6)
;         #$2222 - Red, Red, Red, Red (x3)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
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
        
        pea $0020
        pea $2222
        
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
        
        pea $2022
        pea $2222
        
        _spriteFooter
        rtl


letterF entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x7)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$0022 - Red, Red, Black, Black (x6)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
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
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
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
        

letterG entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2200 - Black, Black, Red, Red (x2)
;         #$2022 - Red, Red, Red, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$0022 - Red, Red, Black, Black (x3)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2200
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $0022
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $0022
        
        adc #$00a0
        tcs
        
        phx
        pea $0022
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2200
        
        _spriteFooter
        rtl
     

letterH entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$2002 - Black, Red, Red, Black (x6)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2222 - Red, Red, Red, Red (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
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
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        _spriteFooter
        rtl


letterI entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x7)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$2200 - Black, Black, Red, Red (x5)
;
        ldx #$2200      ; Black, Black, Red, Red
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2222
        
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
        
        pea $0022
        pea $2222
        
        _spriteFooter
        rtl
        

letterJ entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x6)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$2202 - Black, Red, Red, Red (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
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
        pea $0022
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2202
        
        _spriteFooter
        rtl
    

letterK entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x3)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$2002 - Black, Red, Red, Black (x1)
;         #$0222 - Red, Red, Black, Red (x2)
;         #$0020 - Red, Black, Black, Black (x2)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2022 - Red, Red, Red, Black (x1)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $0222
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        pea $0222
        
        adc #$00a0
        tcs
        
        pea $2022
        phy
        
        _spriteFooter
        rtl
        
 
letterL entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        phx
        phx
        
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
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2222
        
        _spriteFooter
        rtl
        

         
letterM entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0222 - Red, Red, Black, Red (x1)
;
        ldx #$2022      ; Red, Red, Red, Black
        ldy #$2002      ; Black, Red, Red, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phy
        pea $0022
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        pea $0222
        
        adc #$00a0
        tcs
        
        phy
        pea $0022
        
        adc #$00a0
        tcs
        
        phy
        pea $0022
        
        _spriteFooter
        rtl
        
     
letterN entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0222 - Red, Red, Black, Red (x1)
;
        ldx #$2022      ; Red, Red, Red, Black
        ldy #$2002      ; Black, Red, Red, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phy
        pea $0022
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        phx
        pea $0222
        
        adc #$00a0
        tcs
        
        phx
        pea $0022
        
        adc #$00a0
        tcs
        
        phy
        pea $0022
        
        _spriteFooter
        rtl
        
     
letterO entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2202 - Black, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x5)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
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
        
        phy
        pea $2202
        
        _spriteFooter
        rtl
        
     
letterP entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x3)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phy
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
        phy
        
        adc #$00a0
        tcs
        
        phy
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


letterQ entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2202 - Black, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$0222 - Red, Red, Black, Red (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$2020 - Red, Black, Red, Black (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
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
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $0222
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $2020
        pea $2202
        
        _spriteFooter
        rtl
      

letterR entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x2)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$0222 - Red, Red, Black, Red (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phy
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
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        pea $0222
        
        adc #$00a0
        tcs
        
        pea $2022
        phy
        
        _spriteFooter
        rtl
    

letterS entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2202 - Black, Red, Red, Red (x3)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2002 - Black, Red, Red, Black (x2)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2202
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
        _spriteFooter
        rtl
   
   
letterT entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$2200 - Black, Black, Red, Red (x6)
;
        ldx #$2200      ; Black, Black, Red, Red
        ldy #$0000      ; Black, Black, Black, Black
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2222
        
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


letterU entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x6)
;         #$2202 - Black, Red, Red, Red (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
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
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
        _spriteFooter
        rtl


letterV entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x3)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$2022 - Red, Red, Red, Black (x2)
;         #$2202 - Black, Red, Red, Red (x1)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$0200 - Black, Black, Black, Red (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
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
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2022
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $0000
        pea $0200
        
        _spriteFooter
        rtl
        

letterW entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0222 - Red, Red, Black, Red (x1)
;
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$2022      ; Red, Red, Red, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phx
        pea $0022
        
        adc #$00a0
        tcs
        
        phx
        pea $0022
        
        adc #$00a0
        tcs
        
        phx
        pea $0222
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phx
        pea $0022
        
        _spriteFooter
        rtl
        

letterX entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2002 - Black, Red, Red, Black (x2)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$2202 - Black, Red, Red, Red (x2)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;
        ldx #$2022      ; Red, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2200
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        _spriteFooter
        rtl


letterY entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x5)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2202 - Black, Red, Red, Red (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$2200 - Black, Black, Red, Red (x3)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$0022      ; Red, Red, Black, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2202
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
        _spriteFooter
        rtl
        

letterZ entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x5)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$0200 - Black, Black, Black, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$2202 - Black, Red, Red, Red (x1)
;
        ldx #$0000      ; Black, Black, Black, Black
        ldy #$2022      ; Red, Red, Red, Black
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $0200
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2200
        
        adc #$00a0
        tcs
        
        phx
        pea $2202
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        _spriteFooter
        rtl

        end
