;
;  sprites.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-06-16.
;Copyright © 2020 Jeremy Rand. All rights reserved.
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
        lda #$2200
        tcd             ; Black, Black, Red, Red
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2222      ; Red, Red, Red, Red
        clc
        
        phx
        phd
        
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
        
        phy
        phy
        
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
        
        phx
        phd
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$1121      ; Red, Green, Green, Green
        ldy #$1211      ; Green, Green, Green, Red
        clc
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2011
        pea $1102
        
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
        
        pea $2222
        pea $2220
        
        adc #$00a0
        tcs
        
        pea $0012
        pea $2100
        
        adc #$00a0
        tcs
        
        phd
        pea $0100
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$1121      ; Red, Green, Green, Green
        ldy #$1211      ; Green, Green, Green, Red
        clc
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2011
        pea $1102
        
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
        
        pea $2020
        pea $2020
        
        adc #$00a0
        tcs
        
        phd
        pea $2000
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter


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
        txa
        tcs
        ldx #$0000      ; Black, Black, Black, Black
        clc
        
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
        lda #$2200
        tcd             ; Black, Black, Red, Red
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2222      ; Red, Red, Red, Red
        clc
        
        phx
        phd
        
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
        
        phy
        phy
        
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
        
        phx
        phd
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$3323      ; Red, Off-white, Off-white, Green
        ldy #$3233      ; Off-white, Off-white, Off-white, Red
        clc
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2033
        pea $3302
        
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
        
        pea $2222
        pea $2220
        
        adc #$00a0
        tcs
        
        pea $0032
        pea $2300
        
        adc #$00a0
        tcs
        
        phd
        pea $0300
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$3323      ; Red, Off-white, Off-white, Off-white
        ldy #$3233      ; Off-white, Off-white, Off-white, Red
        clc
        
        pea $0022
        pea $2200
        
        adc #$00a0
        tcs
        
        pea $2033
        pea $3302
        
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
        
        pea $2020
        pea $2020
        
        adc #$00a0
        tcs
        
        phd
        pea $2000
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter


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
        txa
        tcs
        ldx #$0000      ; Black, Black, Black, Black
        clc
        
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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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


letterB entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2222 - Red, Red, Red, Red (x3)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2022 - Red, Red, Red, Black (x1)
;
        lda #$2222
        tcd             ; Red, Red, Red, Red
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        pea $0022
        phd
        
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
        phd
        
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
        phd
        
        _spriteFooter


letterC entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x5)
;         #$2200 - Black, Black, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$2002 - Black, Red, Red, Black (x4)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phy
        pea $2200
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2200
        
        _spriteFooter


letterD entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0020 - Red, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x3)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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


letterE entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x6)
;         #$2222 - Red, Red, Red, Red (x3)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2222      ; Red, Red, Red, Red
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        pea $0020
        phx
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        pea $2022
        phx
        
        _spriteFooter


letterF entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x7)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$0022 - Red, Red, Black, Black (x6)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2222      ; Red, Red, Red, Red
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        pea $2022
        phx
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        _spriteFooter
        

letterG entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2200 - Black, Black, Red, Red (x2)
;         #$2022 - Red, Red, Red, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$0022 - Red, Red, Black, Black (x3)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2200
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        pea $2022
        phy
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        phx
        phx
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2200
        
        _spriteFooter
     

letterH entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$2002 - Black, Red, Red, Black (x6)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2222 - Red, Red, Red, Red (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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


letterI entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x7)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$2200 - Black, Black, Red, Red (x5)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2200      ; Black, Black, Red, Red
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        _spriteFooter
        

letterJ entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x6)
;         #$0022 - Red, Red, Black, Black (x2)
;         #$2202 - Black, Red, Red, Red (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        adc #$00a0
        tcs
        
        phy
        pea $2202
        
        _spriteFooter
    

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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0222      ; Red, Red, Black, Red
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        phx
        
        adc #$00a0
        tcs
        
        phd
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        pea $2022
        phy
        
        _spriteFooter
        
 
letterL entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2022 - Red, Red, Red, Black (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2222
        
        _spriteFooter
        

         
letterM entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0222 - Red, Red, Black, Red (x1)
;
        lda #$2002
        tcd             ; Black, Red, Red, Black
        txa
        tcs
        ldx #$2022      ; Red, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phd
        phy
        
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
        
        phd
        pea $0222
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        _spriteFooter
        
     
letterN entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0222 - Red, Red, Black, Red (x1)
;
        lda #$2002
        tcd             ; Black, Red, Red, Black
        txa
        tcs
        ldx #$2022      ; Red, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        pea $0000
        pea $0000
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
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
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        _spriteFooter
        
     
letterO entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$2202 - Black, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x5)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        
     
letterP entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2202 - Black, Red, Red, Red (x3)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
    

letterS entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$2202 - Black, Red, Red, Red (x3)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2002 - Black, Red, Red, Black (x2)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2202      ; Black, Red, Red, Red
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        pea $0020
        phx
        
        adc #$00a0
        tcs
        
        phy
        phy
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        pea $2002
        phd
        
        adc #$00a0
        tcs
        
        pea $2002
        phy
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        _spriteFooter
   
   
letterT entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$2200 - Black, Black, Red, Red (x6)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2200      ; Black, Black, Red, Red
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2222
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        _spriteFooter


letterU entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x7)
;         #$2002 - Black, Red, Red, Black (x6)
;         #$2202 - Black, Red, Red, Red (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        
        phd
        pea $0200
        
        _spriteFooter
        

letterW entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0022 - Red, Red, Black, Black (x3)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$2022 - Red, Red, Red, Black (x4)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$0222 - Red, Red, Black, Red (x1)
;
        lda #$2022
        tcd             ; Red, Red, Red, Black
        txa
        tcs
        ldx #$2002      ; Black, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
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
        pea $0222
        
        adc #$00a0
        tcs
        
        phd
        pea $2222
        
        adc #$00a0
        tcs
        
        phd
        pea $2222
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        _spriteFooter
        

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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2022      ; Red, Red, Red, Black
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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


letterY entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x5)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2202 - Black, Red, Red, Red (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;         #$2200 - Black, Black, Red, Red (x3)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2200      ; Black, Black, Red, Red
        ldy #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        _spriteFooter
        

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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$2222      ; Red, Red, Red, Red
        ldy #$2022      ; Red, Red, Red, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phy
        phd
        
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
        
        phd
        pea $2202
        
        adc #$00a0
        tcs
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        _spriteFooter


backupStack dc i2'0'

        end
