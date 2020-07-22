;
;  mushrooms.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-02.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy mushrooms.macros
        keep mushrooms

mushrooms start
        using globalData

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

        end
