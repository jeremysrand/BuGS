;
;  sprites.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-06-16.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;
;
; Performance of two approaches
;       ldx #$abcd   3 cycles
;       phx          4 cycles (per push)
;
; Vs
;       pea $abcd    5 cycles
;
; When the pattern $abcd appears just once:
;       - ldx/phx takes 7 cycles
;       - pea takes 5 cycles (***)
;
; When the pattern $abcd appears twice:
;       - ldx/phx/phx takes 11 cycles
;       - pea/pea takes 10 cycles (***)
;
; When the pattern $abcd appears three times:
;       - ldx/phx/phx/phx takes 15 cycles
;       - pea/pea/pea takes 15 cycles
;
; When the pattern $abcd appears four times:
;       - ldx/phx/phx/phx takes 19 cycles (***)
;       - pea/pea/pea takes 20 cycles
;
; So, if a pattern appears four or more times, it is worth using a
; register for the pattern.  If it appears exactly three times,
; a register can be used but it buys nothing.  If it appears two
; or fewer times, a register for the pattern should not be used.
;

        case on
        mcopy sprites.macros
        keep sprites

sprites start

mushroom1 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$1102 - Black, Red, Green, Green (x1)
;         #$2011 - Green, Green, Red, Black (x1)
;         #$1121 - Red, Green, Green, Green (x2)
;         #$1211 - Green, Green, Green, Red (x2)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2100 - Black, Black, Red, Green (x2)
;         #$0012 - Green, Red, Black, Black (x2)
;
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2011
        pea $1102
        
        adc #$00a0
        tcs
        
        pea $1211
        pea $1121
        
        adc #$00a0
        tcs
        
        pea $1211
        pea $1121
        
        adc #$00a0
        tcs
        
        pea $2222
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $0012
        pea $2100
        
        adc #$00a0
        tcs
        
        pea $0012
        pea $2100
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2200
        
        _spriteFooter
        rtl


mushroom2 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$1102 - Black, Red, Green, Green (x1)
;         #$2011 - Green, Green, Red, Black (x1)
;         #$1121 - Red, Green, Green, Green (x2)
;         #$1211 - Green, Green, Green, Red (x2)
;         #$2220 - Red, Black, Red, Red (x1)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2100 - Black, Black, Red, Green (x1)
;         #$0012 - Green, Red, Black, Black (x1)
;         #$0100 - Black, Black, Black, Green (x1)
;         #$0000 - Black, Black, Black, Black (x3)
;
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2011
        pea $1102
        
        adc #$00a0
        tcs
        
        pea $1211
        pea $1121
        
        adc #$00a0
        tcs
        
        pea $1211
        pea $1121
        
        adc #$00a0
        tcs
        
        pea $2222
        pea $2220
        
        adc #$00a0
        tcs
        
        pea $0012
        pea $2100
        
        adc #$00a0
        tcs
        
        pea $0000
        pea $0100
        
        adc #$00a0
        tcs
        
        pea $0000
        pea $0000
        
        _spriteFooter
        rtl


mushroom3 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$1102 - Black, Red, Green, Green (x1)
;         #$2011 - Green, Green, Red, Black (x1)
;         #$1121 - Red, Green, Green, Green (x2)
;         #$1211 - Green, Green, Green, Red (x2)
;         #$2020 - Red, Black, Red, Black (x2)
;         #$2000 - Black, Black, Red, Black (x1)
;         #$0000 - Black, Black, Black, Black (x5)
;
        ldx #$0000      ; Black, Black, Black, Black
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2011
        pea $1102
        
        adc #$00a0
        tcs
        
        pea $1211
        pea $1121
        
        adc #$00a0
        tcs
        
        pea $1211
        pea $1121
        
        adc #$00a0
        tcs
        
        pea $2020
        pea $2020
        
        adc #$00a0
        tcs
        
        phx
        pea $2000
        
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


mushroom4 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$1102 - Black, Red, Green, Green (x1)
;         #$2011 - Green, Green, Red, Black (x1)
;         #$1021 - Red, Green, Green, Black (x1)
;         #$1211 - Green, Green, Green, Red (x1)
;         #$1020 - Red, Black, Green, Black (x1)
;         #$1210 - Green, Black, Green, Red (x1)
;         #$0000 - Black, Black, Black, Black (x8)
;
        ldx #$0000      ; Black, Black, Black, Black
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2011
        pea $1102
        
        adc #$00a0
        tcs
        
        pea $1211
        pea $1021
        
        adc #$00a0
        tcs
        
        pea $1210
        pea $1020
        
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


poisonedMushroom1 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$3302 - Black, Red, Off-white, Off-white (x1)
;         #$2033 - Off-white, Off-white, Red, Black (x1)
;         #$3323 - Red, Off-white, Off-white, Off-white (x2)
;         #$3233 - Off-white, Off-white, Off-white, Red (x2)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2300 - Black, Black, Red, Off-white (x2)
;         #$0032 - Off-white, Red, Black, Black (x2)
;
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2033
        pea $3302
        
        adc #$00a0
        tcs
        
        pea $3233
        pea $3323
        
        adc #$00a0
        tcs
        
        pea $3233
        pea $3323
        
        adc #$00a0
        tcs
        
        pea $2222
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $0032
        pea $2300
        
        adc #$00a0
        tcs
        
        pea $0032
        pea $2300
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2200
        
        _spriteFooter
        rtl


poisonedMushroom2 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$3302 - Black, Red, Off-white, Off-white (x1)
;         #$2033 - Off-white, Off-white, Red, Black (x1)
;         #$3323 - Red, Off-white, Off-white, Off-white (x2)
;         #$3233 - Off-white, Off-white, Off-white, Red (x2)
;         #$2220 - Red, Black, Red, Red (x1)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2300 - Black, Black, Red, Off-white (x1)
;         #$0032 - Off-white, Red, Black, Black (x1)
;         #$0300 - Black, Black, Black, Off-white (x1)
;         #$0000 - Black, Black, Black, Black (x3)
;
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2033
        pea $3302
        
        adc #$00a0
        tcs
        
        pea $3233
        pea $3323
        
        adc #$00a0
        tcs
        
        pea $3233
        pea $3323
        
        adc #$00a0
        tcs
        
        pea $2222
        pea $2220
        
        adc #$00a0
        tcs
        
        pea $0032
        pea $2300
        
        adc #$00a0
        tcs
        
        pea $0000
        pea $0300
        
        adc #$00a0
        tcs
        
        pea $0000
        pea $0000
        
        _spriteFooter
        rtl


poisonedMushroom3 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$3302 - Black, Red, Off-white, Off-white (x1)
;         #$2033 - Off-white, Off-white, Red, Black (x1)
;         #$3323 - Red, Off-white, Off-white, Off-white (x2)
;         #$3233 - Off-white, Off-white, Off-white, Red (x2)
;         #$2020 - Red, Black, Red, Black (x2)
;         #$2000 - Black, Black, Red, Black (x1)
;         #$0000 - Black, Black, Black, Black (x5)
;
        ldx #$0000      ; Black, Black, Black, Black
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2033
        pea $3302
        
        adc #$00a0
        tcs
        
        pea $3233
        pea $3323
        
        adc #$00a0
        tcs
        
        pea $3233
        pea $3323
        
        adc #$00a0
        tcs
        
        pea $2020
        pea $2020
        
        adc #$00a0
        tcs
        
        phx
        pea $2000
        
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


poisonedMushroom4 entry
        _spriteHeader
        
; Colours #$2200 - Black, Black, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$3302 - Black, Red, Off-white, Off-white (x1)
;         #$2033 - Off-white, Off-white, Red, Black (x1)
;         #$3023 - Red, Off-white, Off-white, Black (x1)
;         #$3233 - Off-white, Off-white, Off-white, Red (x1)
;         #$3020 - Red, Black, Off-white, Black (x1)
;         #$3230 - Off-white, Black, Off-white, Red (x1)
;         #$0000 - Black, Black, Black, Black (x8)
;
        ldx #$0000      ; Black, Black, Black, Black
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2033
        pea $3302
        
        adc #$00a0
        tcs
        
        pea $3233
        pea $3023
        
        adc #$00a0
        tcs
        
        pea $3230
        pea $3020
        
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


flea1  entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OOG.|GOOO
; ....|..G.|G.OO
; ....|..G.|G.G.
; ....|.G.G|...G
;
        
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $8844
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$c088
        sta $a1,s
        
        tsc
        adc #$00a4
        tcs
        pea $88c8
        
        lda $9f,s
        ora #$c000
        sta $9f,s
        
        lda $a1,s
        and #$000f
        ora #$88c0
        sta $a1,s
        
        tsc
        adc #$013e
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        ora #$c0c0
        sta $3,s
        
        lda $a1,s
        ora #$0c0c
        sta $a1,s
        
        lda $a3,s
        ora #$0c00
        sta $a3,s
        
        _spriteFooter
        rtl
        

flea2  entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OO.G|.OOO
; ....|..G.|.GOO
; ....|.G..|G..G
; ....|.G.G|..G.
;
        
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $8844
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        lda $a1,s
        and #$f000
        ora #$0c88
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$880c
        sta $3,s
        
        tsc
        adc #$00a0
        tcs
        
        lda $1,s
        ora #$000c
        sta $1,s
        
        lda $3,s
        ora #$0cc0
        sta $3,s
        
        lda $a1,s
        ora #$0c0c
        sta $a1,s
        
        lda $a3,s
        ora #$c000
        sta $a3,s
        
        _spriteFooter
        rtl
        

flea3  entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OO.G|.OOO
; ....|..G.|G.OO
; ....|..G.|.G.G
; ....|...G|..G.
;
        
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $8844
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        lda $a1,s
        and #$f000
        ora #$0c88
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        and #$000f
        ora #$88c0
        sta $3,s
        
        tsc
        adc #$00a0
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        ora #$0c0c
        sta $3,s
        
        lda $a1,s
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        ora #$c000
        sta $a3,s
        
        _spriteFooter
        rtl
        

flea4  entry
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..OO|O...
; ....|.ROO|OO..
; ....|RROO|OOO.
; ...O|OOOO|OOOO
; ...O|OOG.|GOOO
; ....|..G.|G.OO
; ....|..G.|.G.G
; ....|...G|.G.G
;
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$8804
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $8844
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        pea $8888
        pea $8888
        
        lda $9f,s
        and #$f0ff
        ora #$0800
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$c088
        sta $a1,s
        
        tsc
        adc #$00a4
        tcs
        pea $88c8
        
        lda $9f,s
        ora #$c000
        sta $9f,s
        
        lda $a1,s
        and #$000f
        ora #$88c0
        sta $a1,s
        
        tsc
        adc #$013e
        tcs
        
        lda $1,s
        ora #$c000
        sta $1,s
        
        lda $3,s
        ora #$0c0c
        sta $3,s
        
        lda $a1,s
        ora #$0c00
        sta $a1,s
        
        lda $a3,s
        ora #$0c0c
        sta $a3,s
        
        _spriteFooter
        rtl


score300 entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|....
; ....|....|....
; .OOO|.OOO|.OOO
; ...O|.O.O|.O.O
; .OOO|.O.O|.O.O
; ...O|.O.O|.O.O
; .OOO|.OOO|.OOO
; ....|....|....
;
        tsc
        adc #$013a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        _spriteFooter
        rtl


score600 entry
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|....
; ....|....|....
; .OOO|.OOO|.OOO
; .O..|.O.O|.O.O
; .OOO|.O.O|.O.O
; .O.O|.O.O|.O.O
; .OOO|.OOO|.OOO
; ....|....|....
;
        
        tsc
        adc #$013a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        _spriteFooter
        rtl


score900 entry
        _spriteHeader
 
; $7 c - Green
; $8 4 - Red
; $9 8 - Off-white
;
; ....|....|....
; ....|....|....
; .OOO|.OOO|.OOO
; .O.O|.O.O|.O.O
; .OOO|.O.O|.O.O
; ...O|.O.O|.O.O
; .OOO|.OOO|.OOO
; ....|....|....
;

        tsc
        adc #$013a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0808
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0808
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        _spriteFooter
        rtl


left_scorpion1 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|.ROR|..O.|O...
; .O..|RROR|R..O|....
; .OO.|.OOO|..OO|.OOO
; ..OO|OOOO|OOO.|.O.O
; ....|.OOO|O...|...O
; ....|.OOO|O...|..OO
; ....|.OOO|OOOO|OOOO
; ....|..OO|OOOO|OOO.
;
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8404
        sta $3,s
        
        lda $5,s
        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $7,s
        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda #$8444
        sta $a3,s
        
        lda $a5,s
        and #$f00f
        ora #$0840
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
        and #$00f0
        ora #$8808
        sta $7,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        lda $a7,s
        and #$f0f0
        ora #$0808
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$0080
        sta $3,s
        
        lda $5,s
        and #$f0ff
        ora #$0800
        sta $5,s
        
        lda $a1,s
        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a5,s
        and #$00ff
        ora #$8800
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        tya
        sta $3,s
        sta $5,s
        sta $a3,s
        
        _spriteFooter
        rtl
        

left_scorpion1s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O|....
; ....|O..R|RORR|..O.|....
; ....|OO..|OOO.|.OO.|OOO.
; ....|.OOO|OOOO|OO..|O.O.
; ....|....|OOOO|....|..O.
; ....|....|OOOO|....|.OO.
; ....|....|OOOO|OOOO|OOO.
; ....|....|.OOO|OOOO|OO..
;

        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a3,s
        and #$f00f
        ora #$0480
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
        and #$ff00
        ora #$0088
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $5,s
        and #$0ff0
        ora #$8008
        sta $5,s
        
        lda $7,s
        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a1,s
        and #$00f0
        ora #$8808
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
        and #$ff00
        ora #$0088
        sta $a5,s
        
        lda $a7,s
        and #$0f0f
        ora #$8080
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        tya
        sta $1,s
        sta $a1,s
        
        lda $5,s
        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $a5,s
        and #$0ff0
        ora #$8008
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $5,s
        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a5,s
        and #$ff00
        ora #$0088
        sta $a5,s
        
        tya
        sta $1,s
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl
        

left_scorpion2 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|.ROR|..O.|O...
; .O..|RROR|R..O|....
; .OO.|.OOO|..OO|.OOO
; ..OO|.OOO|.OO.|.O.O
; ...O|OOOO|OO..|.O..
; ....|.OOO|....|OO..
; ....|.OOO|OOOO|OO..
; ....|..OO|OOOO|O...
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8404
        sta $3,s
        
        lda $5,s
        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $7,s
        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
        and #$fff0
        ora #$0008
        sta $a1,s
        
        lda #$8444
        sta $a3,s
        
        lda $a5,s
        and #$f00f
        ora #$0840
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        lda $5,s
        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
        and #$00f0
        ora #$8808
        sta $7,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        lda $a5,s
        and #$0ff0
        ora #$8008
        sta $a5,s
        
        lda $a7,s
        and #$f0f0
        ora #$0808
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        tya
        sta $3,s
        
        lda $5,s
        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $7,s
        and #$fff0
        ora #$0008
        sta $7,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        lda $a7,s
        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $5,s
        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
        and #$ff0f
        ora #$0080
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


left_scorpion2s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
       _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O|....
; ....|O..R|RORR|..O.|....
; ....|OO..|OOO.|.OO.|OOO.
; ....|.OO.|OOO.|OO..|O.O.
; ....|..OO|OOOO|O...|O...
; ....|....|OOO.|...O|O...
; ....|....|OOOO|OOOO|O...
; ....|....|.OOO|OOOO|....
;
       ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
       lda $1,s
       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
       and #$fff0
       ora #$0008
       sta $3,s
        
       lda $5,s
       and #$0f00
       ora #$4048
       sta $5,s
        
       lda $7,s
       and #$f0f0
       ora #$0808
       sta $7,s
       
       lda $a3,s
       and #$f00f
       ora #$0480
       sta $a3,s
       
       lda #$4448
       sta $a5,s
       
       lda $a7,s
       and #$0fff
       ora #$8000
       sta $a7,s
       
       tsc
       adc #$142
       tcs
       
       lda $1,s
       and #$ff00
       ora #$0088
       sta $1,s
       
       lda $3,s
       and #$0f00
       ora #$8088
       sta $3,s
       
       lda $5,s
       and #$0ff0
       ora #$8008
       sta $5,s
       
       lda $7,s
       and #$0f00
       ora #$8088
       sta $7,s
       
       lda $a1,s
       and #$0ff0
       ora #$8008
       sta $a1,s
       
       lda $a3,s
       and #$0f00
       ora #$8088
       sta $a3,s
       
       lda $a5,s
       and #$ff00
       ora #$0088
       sta $a5,s
       
       lda $a7,s
       and #$0f0f
       ora #$8080
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
       and #$00ff
       ora #$8800
       sta $1,s
       
       tya
       sta $3,s
       
       lda $5,s
       and #$ff0f
       ora #$0080
       sta $5,s
       
       lda $7,s
       and #$ff0f
       ora #$0080
       sta $7,s
       
       lda $a3,s
       and #$0f00
       ora #$8088
       sta $a3,s
       
       lda $a5,s
       and #$f0ff
       ora #$0800
       sta $a5,s
       
       lda $a7,s
       and #$ff0f
       ora #$0080
       sta $a7,s
       
       tsc
       adc #$142
       tcs
       
       lda $5,s
       and #$ff0f
       ora #$0080
       sta $5,s
       
       lda $a1,s
       and #$00f0
       ora #$8808
       sta $a1,s
       
       tya
       sta $1,s
       sta $3,s
       sta $a3,s
       
       _spriteFooter
       rtl


left_scorpion3 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|ROR.|O.O.|....
; .O.R|RORR|.O..|....
; .OO.|OOO.|OO..|..OO
; ..OO|OOOO|O...|.O.O
; ....|OOO.|....|OO.O
; ....|OOO.|..OO|O..O
; ....|OOOO|OOOO|..O.
; ....|.OOO|OOO.|....
;
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$4048
        sta $3,s
        
        lda $5,s
        and #$0f0f
        ora #$8080
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0408
        sta $a1,s
        
        lda #$4448
        sta $a3,s
        
        lda $a5,s
        and #$fff0
        ora #$0008
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $5,s
        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $7,s
        and #$00ff
        ora #$8800
        sta $7,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
        and #$ff0f
        ora #$0080
        sta $a5,s
        
        lda $a7,s
        and #$f0f0
        ora #$0808
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $5,s
        and #$f000
        ora #$0888
        sta $5,s
        
        lda $a1,s
        and #$0f00
        ora #$8088
        sta $a1,s
        
        lda $a3,s
        and #$00ff
        ora #$8800
        sta $a3,s
        
        lda $a5,s
        and #$f00f
        ora #$0880
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $5,s
        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $a1,s
        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$8088
        sta $a3,s
        
        tya
        sta $1,s
        sta $3,s
        
        _spriteFooter
        rtl


left_scorpion3s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
       _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O.R|OR.O|.O..|....
; ....|O.RR|ORR.|O...|....
; ....|OO.O|OO.O|O...|.OO.
; ....|.OOO|OOOO|....|O.O.
; ....|...O|OO..|...O|O.O.
; ....|...O|OO..|.OOO|..O.
; ....|...O|OOOO|OOO.|.O..
; ....|....|OOOO|OO..|....
;
       ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
       lda $1,s
       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
       and #$f0f0
       ora #$0408
       sta $3,s
        
       lda $5,s
       and #$f000
       ora #$0884
       sta $5,s
        
       lda $7,s
       and #$fff0
       ora #$0008
       sta $7,s
       
       lda $a3,s
       and #$000f
       ora #$4480
       sta $a3,s
       
       lda $a5,s
       and #$0f0
       ora #$4084
       sta $a5,s
       
       lda $a7,s
       and #$ff0f
       ora #$0080
       sta $a7,s
    
       tsc
       adc #$142
       tcs
        
       lda $1,s
       and #$f000
       ora #$0888
       sta $1,s
       
       lda $3,s
       and #$f000
       ora #$0888
       sta $3,s
        
       lda $5,s
       and #$ff0f
       ora #$0080
       sta $5,s
        
       lda $7,s
       and #$0ff0
       ora #$8008
       sta $7,s
       
       lda $a1,s
       and #$00f0
       ora #$8808
       sta $a1,s
       
       tya
       sta $a3,s
       
       lda $a7,s
       and #$0f0f
       ora #$8080
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
       and #$ff00
       ora #$0088
       sta $3,s
       
       lda $5,s
       and #$f0ff
       ora #$0800
       sta $5,s
       
       lda $7,s
       and #$0f0f
       ora #$8080
       sta $7,s
       
       lda $a1,s
       and #$f0ff
       ora #$0800
       sta $a1,s
       
       lda $a3,s
       and #$ff00
       ora #$088
       sta $a3,s
       
       lda $a5,s
       and #$00f0
       ora #$8808
       sta $a5,s
       
       lda $a7,s
       and #$0fff
       ora #$8000
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $5,s
       and #$0f00
       ora #$8088
       sta $5,s
       
       lda $7,s
       and #$fff0
       ora #$0008
       sta $7,s
       
       lda $a5,s
       and #$ff00
       ora #$0088
       sta $a5,s
       
       tya
       sta $3,s
       sta $a3,s
       
       _spriteFooter
       rtl


left_scorpion4 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; O.O.|ROR.|O.O.|....
; .O.R|RORR|.O..|O...
; .OO.|OOO.|OO.O|.OO.
; ..OO|OOOO|O..O|..OO
; ....|OOO.|....|O..O
; ....|OOO.|....|...O
; ....|OOOO|OOOO|OOOO
; ....|.OOO|OOOO|OOO.
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$4048
        sta $3,s
        
        lda $5,s
        and #$0f0f
        ora #$8080
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0408
        sta $a1,s
        
        lda #$4448
        sta $a3,s
        
        lda $a5,s
        and #$fff0
        ora #$0008
        sta $a5,s
        
        lda $a7,s
        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$8088
        sta $3,s
        
        lda $5,s
        and #$f000
        ora #$0888
        sta $5,s
        
        lda $7,s
        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
        and #$f00f
        ora #$0880
        sta $a5,s
        
        lda $a7,s
        and #$00ff
        ora #$8800
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $5,s
        and #$f00f
        ora #$0880
        sta $5,s
        
        lda $a1,s
        and #$0f00
        ora #$8088
        sta $a1,s
        
        lda $a5,s
        and #$f0ff
        ora #$0800
        sta $a5,s
        
        tsc
        adc #$146
        tcs
        
        phy
        phy
        phy
        
        lda $a1,s
        and #$00f0
        ora #$8808
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        _spriteFooter
        rtl


left_scorpion4s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
       _spriteHeader

; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O.R|OR.O|.O..|....
; ....|O.RR|ORR.|O..O|....
; ....|OO.O|OO.O|O.O.|OO..
; ....|.OOO|OOOO|..O.|.OO.
; ....|...O|OO..|...O|..O.
; ....|...O|OO..|....|..O.
; ....|...O|OOOO|OOOO|OOO.
; ....|....|OOOO|OOOO|OO..
;

       ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
       lda $1,s
       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
       and #$f0f0
       ora #$0408
       sta $3,s
        
       lda $5,s
       and #$f000
       ora #$0884
       sta $5,s
        
       lda $7,s
       and #$fff0
       ora #$0008
       sta $7,s
       
       lda $a3,s
       and #$000f
       ora #$4480
       sta $a3,s
       
       lda $a5,s
       and #$0f0
       ora #$4084
       sta $a5,s
       
       lda $a7,s
       and #$f00f
       ora #$0880
       sta $a7,s
    
       tsc
       adc #$142
       tcs
        
       lda $1,s
       and #$f000
       ora #$0888
       sta $1,s
       
       lda $3,s
       and #$f000
       ora #$0888
       sta $3,s
        
       lda $5,s
       and #$0f0f
       ora #$8080
       sta $5,s
        
       lda $7,s
       and #$ff00
       ora #$0088
       sta $7,s
       
       lda $a1,s
       and #$00f0
       ora #$8808
       sta $a1,s
       
       tya
       sta $a3,s
       
       lda $a5,s
       and #$0fff
       ora #$8000
       sta $a5,s
       
       lda $a7,s
       and #$0ff0
       ora #$8008
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $3,s
       and #$ff00
       ora #$0088
       sta $3,s
       
       lda $5,s
       and #$f0ff
       ora #$0800
       sta $5,s
       
       lda $7,s
       and #$0fff
       ora #$8000
       sta $7,s
       
       lda $a1,s
       and #$f0ff
       ora #$0800
       sta $a1,s
       
       lda $a3,s
       and #$ff00
       ora #$0088
       sta $a3,s
       
       lda $a7,s
       and #$0fff
       ora #$8000
       sta $a7,s
       
       tsc
       adc #$140
       tcs
       
       lda $1,s
       and #$f0ff
       ora #$0800
       sta $1,s
       
       lda $7,s
       and #$0f00
       ora #$8088
       sta $7,s
       
       lda $a7,s
       and #$ff00
       ora #$0088
       sta $a7,s
       
       tya
       sta $3,s
       sta $5,s
       sta $a3,s
       sta $a5,s
       
       _spriteFooter
       rtl


right_scorpion1 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O
; ....|O..R|RORR|..O.
; OOO.|OO..|OOO.|.OO.
; O.O.|.OOO|OOOO|OO..
; O...|...O|OOO.|....
; OO..|...O|OOO.|....
; OOOO|OOOO|OOO.|....
; .OOO|OOOO|OO..|....
;

        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a3,s
        and #$f00f
        ora #$0480
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $3,s
        and #$ff00
        ora #$0088
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $7,s
        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
        and #$0f0f
        ora #$8080
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        tya
        sta $a5,s
        
        lda $a7,s
        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda $3,s
        and #$f0ff
        ora #$0800
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
        and #$ff00
        ora #$0088
        sta $a1,s
        
        lda $a3,s
        and #$f0ff
        ora #$0800
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        tsc
        adc #$144
        tcs
        
        phy
        phy
        
        lda $5,s
        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
        and #$00f0
        ora #$8808
        sta $a1,s
        
        tya
        sta $a3,s
        
        lda $a5,s
        and #$ff00
        ora #$0088
        sta $a5,s
        
        _spriteFooter
        rtl


right_scorpion1s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..O.|O..R|OR..|O.O.
; ....|...O|..RR|ORR.|.O..
; ...O|OO.O|O..O|OO..|OO..
; ...O|.O..|OOOO|OOOO|O...
; ...O|....|..OO|OO..|....
; ...O|O...|..OO|OO..|....
; ...O|OOOO|OOOO|OO..|....
; ....|OOOO|OOOO|O...|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
        and #$f00f
        ora #$0480
        sta $3,s
        
        lda $5,s
        and #$ff00
        ora #$0084
        sta $5,s
        
        lda $7,s
        and #$0f0f
        ora #$8080
        sta $7,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$00ff
        ora #$4400
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$4084
        sta $a5,s
        
        lda $a7,s
        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$f000
        ora #$0888
        sta $3,s
        
        lda $5,s
        and #$f00f
        ora #$0880
        sta $5,s
        
        lda $7,s
        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $9,s
        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        tya
        sta $a5,s
        sta $a7,s
        
        lda $a9,s
        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $5,s
        and #$00ff
        ora #$8800
        sta $5,s
        
        lda $7,s
        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$ff0f
        ora #$0080
        sta $a3,s
        
        lda $a5,s
        and #$00ff
        ora #$8800
        sta $a5,s
        
        lda $a7,s
        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $7,s
        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $a7,s
        and #$ff0f
        ora #$0080
        sta $a7,s
        
        tya
        sta $3,s
        sta $5,s
        sta $a3,s
        sta $a5,s
        
        _spriteFooter
        rtl


right_scorpion2 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ...O|.O..|ROR.|.O.O
; ....|O..R|RORR|..O.
; OOO.|OO..|OOO.|.OO.
; O.O.|.OO.|OOO.|OO..
; ..O.|..OO|OOOO|O...
; ..OO|....|OOO.|....
; ..OO|OOOO|OOO.|....
; ...O|OOOO|OO..|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$fff0
        ora #$0008
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a3,s
        and #$f00f
        ora #$0480
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
        and #$0fff
        ora #$8000
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $3,s
        and #$ff00
        ora #$0088
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $7,s
        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
        and #$0f0f
        ora #$8080
        sta $a1,s
        
        lda $a3,s
        and #$0ff0
        ora #$8008
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        lda $a7,s
        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
        and #$00ff
        ora #$8800
        sta $3,s
        
        tya
        sta $5,s
        
        lda $7,s
        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00ff
        ora #$8800
        sta $1,s
        
        lda $5,s
        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a5,s
        and #$ff00
        ora #$0088
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


right_scorpion2s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|..O.|O..R|OR..|O.O.
; ....|...O|..RR|ORR.|.O..
; ...O|OO.O|O..O|OO..|OO..
; ...O|.O..|OO.O|OO.O|O...
; ....|.O..|.OOO|OOOO|....
; ....|.OO.|...O|OO..|....
; ....|.OOO|OOOO|OO..|....
; ....|..OO|OOOO|O...|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
        and #$f00f
        ora #$0480
        sta $3,s
        
        lda $5,s
        and #$ff00
        ora #$0084
        sta $5,s
        
        lda $7,s
        and #$0f0f
        ora #$8080
        sta $7,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$00ff
        ora #$4400
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$4084
        sta $a5,s
        
        lda $a7,s
        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$f000
        ora #$0888
        sta $3,s
        
        lda $5,s
        and #$f00f
        ora #$0880
        sta $5,s
        
        lda $7,s
        and #$ff00
        ora #$0088
        sta $7,s
        
        lda $9,s
        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        lda $a5,s
        and #$f000
        ora #$0888
        sta $a5,s
        
        lda $a7,s
        and #$f000
        ora #$0888
        sta $a7,s
        
        lda $a9,s
        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8808
        sta $3,s
        
        tya
        sta $5,s
        
        lda $a1,s
        and #$0ff0
        ora #$8008
        sta $a1,s
        
        lda $a3,s
        and #$f0ff
        ora #$0800
        sta $a3,s
        
        lda $a5,s
        and #$ff00
        ora #$0088
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$8808
        sta $1,s
        
        lda $5,s
        and #$ff00
        ora #$0088
        sta $5,s
        
        lda $a1,s
        and #$00ff
        ora #$8800
        sta $a1,s
        
        lda $a5,s
        and #$ff0f
        ora #$0080
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


right_scorpion3 entry
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|.O.O|.ROR|.O.O
; ....|..O.|RROR|R.O.
; OOO.|..OO|.OOO|.OO.
; O.O.|...O|OOOO|OO..
; O.OO|....|.OOO|....
; O..O|OO..|.OOO|....
; .O..|OOOO|OOOO|....
; ....|.OOO|OOO.|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$f0f0
        ora #$0808
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$8404
        sta $3,s
        
        lda $5,s
        and #$f0f0
        ora #$0808
        sta $5,s
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda #$8444
        sta $a3,s
        
        lda $a5,s
        and #$0f0f
        ora #$8040
        sta $a5,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
        and #$0f00
        ora #$8088
        sta $1,s
        
        lda $3,s
        and #$00ff
        ora #$8800
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $7,s
        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
        and #$0f0f
        ora #$8080
        sta $a1,s
        
        lda $a3,s
        and #$f0ff
        ora #$0800
        sta $a3,s
        
        tya
        sta $a5,s
        
        lda $a7,s
        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$000f
        ora #$8880
        sta $1,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
        and #$f00f
        ora #$0880
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$0088
        sta $a3,s
        
        lda $a5,s
        and #$00f0
        ora #$8808
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$fff0
        ora #$0008
        sta $1,s
        
        lda $a3,s
        and #$00f0
        ora #$8808
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        tya
        sta $3,s
        sta $5,s
        
        _spriteFooter
        rtl


right_scorpion3s entry
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|O.O.|ROR.|O.O.
; ....|....|.O.R|RORR|.O..
; ...O|OO..|.OO.|OOO.|OO..
; ...O|.O..|..OO|OOOO|O...
; ...O|.OO.|....|OOO.|....
; ...O|..OO|O...|OOO.|....
; ....|O..O|OOOO|OOO.|....
; ....|....|OOOO|OO..|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $1,s
        and #$0f0f
        ora #$8080
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$4048
        sta $3,s
        
        lda $5,s
        and #$0f0f
        ora #$8080
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0408
        sta $a1,s
        
        lda #$4448
        sta $a3,s
        
        lda $a5,s
        and #$fff0
        ora #$0008
        sta $a5,s
        
        tsc
        adc #$13c
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$ff00
        ora #$0088
        sta $3,s
        
        lda $5,s
        and #$0ff0
        ora #$8008
        sta $5,s
        
        lda $7,s
        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $9,s
        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$fff0
        ora #$0008
        sta $a3,s
        
        lda $a5,s
        and #$00ff
        ora #$8800
        sta $a5,s
        
        tya
        sta $a7,s
        
        lda $a9,s
        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$0ff0
        ora #$8008
        sta $3,s
        
        lda $7,s
        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$00ff
        ora #$8800
        sta $a3,s
        
        lda $a5,s
        and #$ff0f
        ora #$0080
        sta $a5,s
        
        lda $a7,s
        and #$0f00
        ora #$8088
        sta $a7,s
        
        tsc
        adc #$142
        tcs
        
        lda $1,s
        and #$f00f
        ora #$0880
        sta $1,s
        
        lda $5,s
        and #$0f00
        ora #$8088
        sta $5,s
        
        lda $a5,s
        and #$ff00
        ora #$0088
        sta $a5,s
        
        tya
        sta $3,s
        sta $a3,s
        
        _spriteFooter
        rtl


right_scorpion4 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|.O.O|.ROR|.O.O
; ...O|..O.|RROR|R.O.
; .OO.|O.OO|.OOO|.OO.
; OO..|O..O|OOOO|OO..
; O..O|....|.OOO|....
; O...|....|.OOO|....
; OOOO|OOOO|OOOO|....
; .OOO|OOOO|OOO.|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $3,s
        and #$f0f0
        ora #$0808
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8404
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0808
        sta $7,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$0fff
        ora #$8000
        sta $a3,s
        
        lda #$8444
        sta $a5,s
        
        lda $a7,s
        and #$0f0f
        ora #$8040
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0ff0
        ora #$8008
        sta $1,s
        
        lda $3,s
        and #$000f
        ora #$8880
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $7,s
        and #$0ff0
        ora #$8008
        sta $7,s
        
        lda $a1,s
        and #$ff00
        ora #$0088
        sta $a1,s
        
        lda $a3,s
        and #$f00f
        ora #$0880
        sta $a3,s
        
        tya
        sta $a5,s
        
        lda $a7,s
        and #$ff00
        ora #$0088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f00f
        ora #$0880
        sta $1,s
        
        lda $5,s
        and #$00f0
        ora #$8808
        sta $5,s
        
        lda $a1,s
        and #$ff0f
        ora #$0080
        sta $a1,s
        
        lda $a5,s
        and #$00f0
        ora #$8808
        sta $a5,s
        
        tsc
        adc #$146
        tcs
        
        phy
        phy
        phy
        
        lda $a1,s
        and #$00f0
        ora #$8808
        sta $a1,s
        
        lda $a5,s
        and #$0f00
        ora #$8088
        sta $a5,s
        
        tya
        sta $a3,s
        
        _spriteFooter
        rtl
        

right_scorpion4s entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ....|....|O.O.|ROR.|O.O.
; ....|..O.|.O.R|RORR|.O..
; ....|OO.O|.OO.|OOO.|OO..
; ...O|O..O|..OO|OOOO|O...
; ...O|..O.|....|OOO.|....
; ...O|....|....|OOO.|....
; ...O|OOOO|OOOO|OOO.|....
; ....|OOOO|OOOO|OO..|....
;
        
        ldy #$8888          ; Off-white, Off-white, Off-white, Off-white
        
        lda $3,s
        and #$0f0f
        ora #$8080
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$4048
        sta $5,s
        
        lda $7,s
        and #$0f0f
        ora #$8080
        sta $7,s
        
        lda $a1,s
        and #$0fff
        ora #$8000
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0408
        sta $a3,s
        
        lda #$4448
        sta $a5,s
        
        lda $a7,s
        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$13e
        tcs
        
        lda $3,s
        and #$f000
        ora #$0888
        sta $3,s
        
        lda $5,s
        and #$0ff0
        ora #$8008
        sta $5,s
        
        lda $7,s
        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $9,s
        and #$ff00
        ora #$0088
        sta $9,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a3,s
        and #$f00f
        ora #$0880
        sta $a3,s
        
        lda $a5,s
        and #$00ff
        ora #$8800
        sta $a5,s
        
        tya
        sta $a7,s
        
        lda $a9,s
        and #$ff0f
        ora #$0080
        sta $a9,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $3,s
        and #$0fff
        ora #$8000
        sta $3,s
        
        lda $7,s
        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a1,s
        and #$f0ff
        ora #$0800
        sta $a1,s
        
        lda $a7,s
        and #$0f00
        ora #$8088
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$f0ff
        ora #$0800
        sta $1,s
        
        lda $7,s
        and #$0f00
        ora #$8088
        sta $7,s
        
        lda $a7,s
        and #$ff00
        ora #$0088
        sta $a7,s
        
        tya
        sta $3,s
        sta $a3,s
        sta $5,s
        sta $a5,s
        
        _spriteFooter
        rtl


spider1 entry
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        _spriteHeader
 
; $c - Green
; $4 - Red
; $8 - Off-white
;
; ..O.|....|....|O...
; .O.O|....|...O|.O.
; O...|O..G|..O.|..O.
; ....|.ORG|RO..|....
; ..O.|.RRG|RR..|O...
; .O.O|.GGG|GG.O|.O..
; O...|OGRR|RGO.|..O.
; ....|..GR|G...|....
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $7,s
        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a5,s
        and #$f0ff
        ora #$0800
        sta $a5,s
        
        lda $a7,s
        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda $3,s
        and #$f00f
        ora #$0c80
        sta $3,s
        
        lda $5,s
        and #$0fff
        ora #$8000
        sta $5,s
        
        lda $7,s
        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a3,s
        and #$00f0
        ora #$4c08
        sta $a3,s
        
        lda $a5,s
        and #$ff00
        ora #$0048
        sta $a5,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$0fff
        ora #$8000
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$4c04
        sta $3,s
        
        lda $5,s
        and #$ff00
        ora #$0044
        sta $5,s
        
        lda $7,s
        and #$ff0f
        ora #$0080
        sta $7,s
        
        lda $a1,s
        and #$f0f0
        ora #$0808
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$cc0c
        sta $a3,s
        
        lda $a5,s
        and #$f000
        ora #$08cc
        sta $a5,s
        
        lda $a7,s
        and #$fff0
        ora #$0008
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $1,s
        and #$ff0f
        ora #$0080
        sta $1,s
        
        lda #$448c
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$804c
        sta $5,s
        
        lda $7,s
        and #$0fff
        ora #$8000
        sta $7,s
        
        lda $a3,s
        and #$00ff
        ora #$c400
        sta $a3,s
        
        lda $a5,s
        and #$ff0f
        ora #$00c0
        sta $a5,s
        
        _spriteFooter
        rtl


backupStack dc i2'0'

        end
