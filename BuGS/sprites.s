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
        lda #$1100
        tcd             ; Black, Black, Green, Green
        txa
        tcs
        ldx #$2010      ; Green, Black, Red, Black
        ldy #$0011      ; Green, Green, Black, Black
        clc
        
        phy
        phd
        
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
        
        phy
        phd
        
        _spriteFooter


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
        lda #$1100
        tcd             ; Black, Black, Green, Green
        txa
        tcs
        ldx #$2010      ; Green, Black, Red, Black
        ldy #$0011      ; Green, Green, Black, Black
        clc
        
        phy
        phd
        
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
        
        phy
        phd
        
        _spriteFooter


symbolDot entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x15)
;         #$0030 - Off-white, Black, Black, Black (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        pea $0030
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter
        

symbolColon entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$0020 - Red, Black, Black, Black (x4)
;         #$0200 - Black, Black, Black, Red (x4)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0020      ; Red, Black, Black, Black
        ldy #$0200      ; Black, Black, Black, Red
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
        
        phd
        phd
        
        adc #$00a0
        tcs
        
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
        
        phd
        phd
        
        _spriteFooter
        

solid0  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x16)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter
        

solid1  entry
        _spriteHeader
        
; Colours #$1111 - Green, Green, Green, Green  (x16)
;
        lda #$1111
        tcd             ; Green, Green, Green, Green
        txa
        tcs
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter


solid2  entry
        _spriteHeader
        
; Colours #$2222 - Red, Red, Red, Red (x16)
;
        lda #$2222
        tcd             ; Red, Red, Red, Red
        txa
        tcs
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter


solid3  entry
        _spriteHeader
        
; Colours #$3333 - Off-white, Off-white,  Off-white,  Off-white (x16)
;
        lda #$3333
        tcd             ; Off-white, Off-white,  Off-white,  Off-white
        txa
        tcs
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phd
        phd
        
        _spriteFooter


number0  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x2)
;         #$0020 - Red, Black, Black, Black (x2)
;         #$2200 - Black, Black, Red, Red (x2)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2002 - Black, Red, Red, Black (x4)
;         #$0002 - Black, Red, Black, Black (x2)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2002      ; Black, Red, Red, Black
        clc
        
        phd
        phd
        
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


number1  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x8)
;         #$2200 - Black, Black, Red, Red (x5)
;         #$0022 - Red, Red, Black, Black (x1)
;         #$2202 - Black, Red, Red, Red (x1)
;         #$2222 - Red, Red, Red, Red (x1)
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
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phd
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
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        pea $0022
        pea $2222
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2022      ; Red, Red, Red, Black
        clc
        
        phd
        phd
        
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
        
        phy
        phd
        
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
        
        phd
        phy
        
        adc #$00a0
        tcs
        
        phy
        pea $2222
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2202      ; Black, Red, Red, Red
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        pea $2022
        phy
        
        adc #$00a0
        tcs
        
        phx
        phd
        
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
        phd
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        phx
        phy
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        clc
        
        phd
        phd
        
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
        phd
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        _spriteFooter


number5  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x5)
;         #$0022 - Red, Red, Black, Black (x5)
;         #$2222 - Red, Red, Red, Red (x2)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$2202 - Black, Red, Red, Red (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2002      ; Black, Red, Red, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        phd
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2222
        
        adc #$00a0
        tcs
        
        phy
        phd
        
        adc #$00a0
        tcs
        
        phy
        phd
        
        adc #$00a0
        tcs
        
        phy
        phx
        
        adc #$00a0
        tcs
        
        phx
        pea $2202
        
        _spriteFooter


number6  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$0022 - Red, Red, Black, Black (x6)
;         #$2200 - Black, Black, Red, Red (x1)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$2222 - Red, Red, Red, Red (x1)
;         #$2202 - Black, Red, Red, Red (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2002      ; Black, Red, Red, Black
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phx
        pea $2200
        
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
        
        phx
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
        
        phx
        pea $2202
        
        _spriteFooter


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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2200      ; Black, Black, Red, Red
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        pea $2022
        pea $2222
        
        adc #$00a0
        tcs
        
        pea $2002
        phx
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        adc #$00a0
        tcs
        
        pea $0020
        pea $0200
        
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
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0020      ; Red, Black, Black, Black
        ldy #$2202      ; Black, Red, Red, Red
        clc
        
        phd
        phd
        
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


number9  entry
        _spriteHeader
        
; Colours #$0000 - Black, Black, Black, Black (x4)
;         #$0022 - Red, Red, Black, Black (x4)
;         #$2202 - Black, Red, Red, Red (x3)
;         #$2002 - Black, Red, Red, Black (x3)
;         #$2022 - Red, Red, Red, Black (x1)
;         #$0020 - Red, Black, Black, Black (x1)
;
        lda #$0000
        tcd             ; Black, Black, Black, Black
        txa
        tcs
        ldx #$0022      ; Red, Red, Black, Black
        ldy #$2202      ; Black, Red, Red, Red
        clc
        
        phd
        phd
        
        adc #$00a0
        tcs
        
        phx
        phy
        
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
        phy
        
        adc #$00a0
        tcs
        
        pea $2002
        phd
        
        adc #$00a0
        tcs
        
        phx
        phd
        
        adc #$00a0
        tcs
        
        pea $0020
        phy
        
        _spriteFooter


flea1  entry
        _spriteHeader
 
; $a - Green
; $b - Red
; $c - Off-white
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
        lda #$cccc
        tcd             ; Off-white, Off-white, Off-white, Off-white
        dex
        dex
        dex
        dex
        txa
        tcs
        clc
        
        lda $1,s
        and #$00ff
        ora #$cc00
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$00c0
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$cc0b
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $ccbb
        lda $3,s
        and #$0f00
        ora #$c0cc
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        phd
        phd
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$a0cc
        sta $a1,s
        
        tsc
        adc #$00a4
        tcs
        pea $ccac
        
        lda $9f,s
        and #$0fff
        ora #$a000
        sta $9f,s
        
        lda $a1,s
        and #$000f
        ora #$cca0
        sta $a1,s
        
        tsc
        adc #$013e
        tcs
        
        lda $1,s
        and #$0fff
        ora #$a000
        sta $1,s
        
        lda $3,s
        and #$0f0f
        ora #$a0a0
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0a0a
        sta $a1,s
        
        lda $a3,s
        and #$f0ff
        ora #$0a00
        sta $a3,s
        
        _spriteFooter
        

flea2  entry
        _spriteHeader
 
; $a - Green
; $b - Red
; $c - Off-white
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
        lda #$cccc
        tcd             ; Off-white, Off-white, Off-white, Off-white
        dex
        dex
        dex
        dex
        txa
        tcs
        clc
        
        lda $1,s
        and #$00ff
        ora #$cc00
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$00c0
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$cc0b
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $ccbb
        lda $3,s
        and #$0f00
        ora #$c0cc
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        phd
        phd
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        lda $a1,s
        and #$f000
        ora #$0acc
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$cc0c
        sta $a3,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$0fff
        ora #$a000
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$cc0a
        sta $3,s
        
        tsc
        adc #$00a0
        tcs
        
        lda $1,s
        and #$fff0
        ora #$000a
        sta $1,s
        
        lda $3,s
        and #$f00f
        ora #$0aa0
        sta $3,s
        
        lda $a1,s
        and #$f0f0
        ora #$0a0a
        sta $a1,s
        
        lda $a3,s
        and #$0fff
        ora #$a000
        sta $a3,s
        
        _spriteFooter
        

flea3  entry
        _spriteHeader
 
; $a - Green
; $b - Red
; $c - Off-white
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
        lda #$cccc
        tcd             ; Off-white, Off-white, Off-white, Off-white
        dex
        dex
        dex
        dex
        txa
        tcs
        clc
        
        lda $1,s
        and #$00ff
        ora #$cc00
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$00c0
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$cc0b
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $ccbb
        lda $3,s
        and #$0f00
        ora #$c0cc
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        phd
        phd
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        lda $a1,s
        and #$f000
        ora #$0acc
        sta $a1,s
        
        lda $a3,s
        and #$00f0
        ora #$cc0c
        sta $a3,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$0fff
        ora #$a000
        sta $1,s
        
        lda $3,s
        and #$000f
        ora #$cca0
        sta $3,s
        
        tsc
        adc #$00a0
        tcs
        
        lda $1,s
        and #$0fff
        ora #$a000
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0a0a
        sta $3,s
        
        lda $a1,s
        and #$f0ff
        ora #$0a00
        sta $a1,s
        
        lda $a3,s
        and #$0fff
        ora #$a000
        sta $a3,s
        
        _spriteFooter
        

flea4  entry
        _spriteHeader
 
; $a - Green
; $b - Red
; $c - Off-white
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
        lda #$cccc
        tcd             ; Off-white, Off-white, Off-white, Off-white
        dex
        dex
        dex
        dex
        txa
        tcs
        clc
        
        lda $1,s
        and #$00ff
        ora #$cc00
        sta $1,s
        
        lda $3,s
        and #$ff0f
        ora #$00c0
        sta $3,s
        
        lda $a1,s
        and #$00f0
        ora #$cc0b
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$00cc
        sta $a3,s
        
        tsc
        adc #$0142
        tcs
        
        pea $ccbb
        lda $3,s
        and #$0f00
        ora #$c0cc
        sta $3,s
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        tsc
        adc #$00a4
        tcs
        phd
        phd
        
        lda $9f,s
        and #$f0ff
        ora #$0c00
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$a0cc
        sta $a1,s
        
        tsc
        adc #$00a4
        tcs
        pea $ccac
        
        lda $9f,s
        and #$0fff
        ora #$a000
        sta $9f,s
        
        lda $a1,s
        and #$000f
        ora #$cca0
        sta $a1,s
        
        tsc
        adc #$013e
        tcs
        
        lda $1,s
        and #$0fff
        ora #$a000
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0a0a
        sta $3,s
        
        lda $a1,s
        and #$f0ff
        ora #$0a00
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0a0a
        sta $a3,s
        
        _spriteFooter


score300 entry
        _spriteHeader
 
; $7 - Green
; $8 - Red
; $9 - Off-white
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
        
        clc
        txa
        adc #$013a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$9909
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$9909
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0900
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0909
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0909
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0909
        sta $3,s
        
        lda $5,s
        and #$f0f0
        ora #$0909
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0900
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0909
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0909
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$9909
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$9909
        sta $5,s
        
        _spriteFooter


score600 entry
        _spriteHeader
 
; $7 - Green
; $8 - Red
; $9 - Off-white
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
        
        clc
        txa
        adc #$013a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$9909
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$9909
        sta $5,s
        
        lda $a1,s
        and #$fff0
        ora #$0009
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0909
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0909
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0909
        sta $3,s
        
        lda $5,s
        and #$f0f0
        ora #$0909
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0909
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0909
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0909
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$9909
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$9909
        sta $5,s
        
        _spriteFooter


score900 entry
        _spriteHeader
 
; $7 - Green
; $8 - Red
; $9 - Off-white
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
        
        clc
        txa
        adc #$013a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$9909
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$9909
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0909
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0909
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0909
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$f0f0
        ora #$0909
        sta $3,s
        
        lda $5,s
        and #$f0f0
        ora #$0909
        sta $5,s
        
        lda $a1,s
        and #$f0ff
        ora #$0900
        sta $a1,s
        
        lda $a3,s
        and #$f0f0
        ora #$0909
        sta $a3,s
        
        lda $a5,s
        and #$f0f0
        ora #$0909
        sta $a5,s
        
        tsc
        adc #$0140
        tcs
        
        lda $1,s
        and #$00f0
        ora #$9909
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$9909
        sta $3,s
        
        lda $5,s
        and #$00f0
        ora #$9909
        sta $5,s
        
        _spriteFooter


scorpion1 entry
        _spriteHeader
 
; $d - Green
; $e - Red
; $f - Off-white
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
        
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        txa
        tcs
        ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
        ldx #$feee          ; Red, Red, Off-white, Red
        clc
        
        lda $1,s
        and #$0f0f
        ora #$f0f0
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$fe0e
        sta $3,s
        
        lda $5,s
        and #$0fff
        ora #$f000
        sta $5,s
        
        lda $7,s
        and #$ff0f
        ora #$00f0
        sta $7,s
        
        lda $a1,s
        and #$fff0
        ora #$000f
        sta $a1,s
        
        tsc
        adc #$a4
        tcs
        
        phx
        
        lda $3,s
        and #$f00f
        ora #$0fe0
        sta $3,s
        
        lda $9f,s
        and #$0ff0
        ora #$f00f
        sta $9f,s
        
        lda $a1,s
        and #$00f0
        ora #$ff0f
        sta $a1,s
        
        lda $a3,s
        and #$00ff
        ora #$ff00
        sta $a3,s
        
        lda $a5,s
        and #$00f0
        ora #$ff0f
        sta $a5,s
        
        tsc
        adc #$142
        tcs
        
        phy
        
        tsc
        dec a
        dec a
        tcs
        
        lda $1,s
        and #$00ff
        ora #$ff00
        sta $1,s
        
        lda $5,s
        and #$0f00
        ora #$f0ff
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0f0f
        sta $7,s
        
        lda $a3,s
        and #$00f0
        ora #$ff0f
        sta $a3,s
        
        lda $a5,s
        and #$ff0f
        ora #$00f0
        sta $a5,s
        
        lda $a7,s
        and #$f0ff
        ora #$0f00
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $3,s
        and #$00f0
        ora #$ff0f
        sta $3,s
        
        lda $5,s
        and #$ff0f
        ora #$00f0
        sta $5,s
        
        lda $7,s
        and #$00ff
        ora #$ff00
        sta $7,s
        
        lda $a3,s
        and #$00f0
        ora #$ff0f
        sta $a3,s
        
        tsc
        adc #$a8
        tcs
        
        phy
        phy
        
        lda $9f,s
        and #$00ff
        ora #$ff00
        sta $9f,s
        
        lda $a3,s
        and #$0f00
        ora #$f0ff
        sta $a3,s
        
        
        tsc
        adc #$a2
        tcs
        
        phy
        
        _spriteFooter
        

scorpion1s entry
        _spriteHeader
 
; $d - Green
; $e - Red
; $f - Off-white
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
        txa
        tcs
        ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
        ldx #$eeef          ; Red, Off-white, Red, Red
        clc
        
        lda $1,s
        and #$f0ff
        ora #$0f00
        sta $1,s
        
        lda $3,s
        and #$fff0
        ora #$000f
        sta $3,s
        
        lda $5,s
        and #$0f00
        ora #$e0ef
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0f0f
        sta $7,s
        
        lda $a3,s
        and #$f00f
        ora #$0ef0
        sta $a3,s
        
        lda $a7,s
        and #$0fff
        ora #$f000
        sta $a7,s
        
        tsc
        adc #$a6
        tcs
        
        phx
        
        lda $9f,s
        and #$ff00
        ora #$00ff
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$f0ff
        sta $a1,s
        
        lda $a3,s
        and #$0ff0
        ora #$f00f
        sta $a3,s
        
        lda $a5,s
        and #$0f00
        ora #$f0ff
        sta $a5,s
        
        tsc
        adc #$142
        tcs
        
        phy
        
        tsc
        dec a
        dec a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$ff0f
        sta $1,s
        
        lda $5,s
        and #$ff00
        ora #$00ff
        sta $5,s
        
        lda $7,s
        and #$0f0f
        ora #$f0f0
        sta $7,s
        
        lda $a7,s
        and #$0fff
        ora #$f000
        sta $a7,s
        
        tsc
        adc #$a4
        tcs
        
        phy
        
        lda $a5,s
        and #$0ff0
        ora #$f00f
        sta $a5,s
        
        tsc
        adc #$a2
        tcs
        
        phy
        
        lda $a5,s
        and #$0f00
        ora #$f0ff
        sta $a5,s
        
        tsc
        adc #$a4
        tcs
        
        phy
        phy
        
        lda $a1,s
        and #$00f0
        ora #$ff0f
        sta $a1,s
        
        lda $a5,s
        and #$ff00
        ora #$00ff
        sta $a5,s
        
        tsc
        adc #$a4
        tcs
        
        phy
        
        _spriteFooter
        

scorpion2 entry
        _spriteHeader
 
; $d - Green
; $e - Red
; $f - Off-white
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
        
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        txa
        tcs
        ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
        ldx #$feee          ; Red, Red, Off-white, Red
        clc
        
        lda $1,s
        and #$0f0f
        ora #$f0f0
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$fe0e
        sta $3,s
        
        lda $5,s
        and #$0fff
        ora #$f000
        sta $5,s
        
        lda $7,s
        and #$ff0f
        ora #$00f0
        sta $7,s
        
        lda $a1,s
        and #$fff0
        ora #$000f
        sta $a1,s
        
        tsc
        adc #$a4
        tcs
        
        phx
        
        lda $3,s
        and #$f00f
        ora #$0fe0
        sta $3,s
        
        lda $9f,s
        and #$0ff0
        ora #$f00f
        sta $9f,s
        
        lda $a1,s
        and #$00f0
        ora #$ff0f
        sta $a1,s
        
        lda $a3,s
        and #$00ff
        ora #$ff00
        sta $a3,s
        
        lda $a5,s
        and #$00f0
        ora #$ff0f
        sta $a5,s
        
        tsc
        adc #$13e
        tcs
        
        lda $1,s
        and #$00ff
        ora #$ff00
        sta $1,s
        
        lda $3,s
        and #$00f0
        ora #$ff0f
        sta $3,s
        
        lda $5,s
        and #$0ff0
        ora #$f00f
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0f0f
        sta $7,s
        
        lda $a1,s
        and #$f0ff
        ora #$0f00
        sta $a1,s
        
        lda $a5,s
        and #$ff00
        ora #$00ff
        sta $a5,s
        
        lda $a7,s
        and #$fff0
        ora #$000f
        sta $a7,s
        
        tsc
        adc #$a4
        tcs
        
        phy
        
        lda $a1,s
        and #$00f0
        ora #$ff0f
        sta $a1,s
        
        lda $a5,s
        and #$ff00
        ora #$00ff
        sta $a5,s
        
        tsc
        adc #$144
        tcs
        
        phy
        
        tsc
        dec a
        dec a
        tcs
        
        lda $1,s
        and #$00f0
        ora #$ff0f
        sta $1,s
        
        lda $5,s
        and #$ff00
        ora #$00ff
        sta $5,s
        
        lda $a1,s
        and #$00ff
        ora #$ff00
        sta $a1,s
        
        lda $a5,s
        and #$ff0f
        ora #$00f0
        sta $a5,s
        
        tsc
        adc #$a4
        tcs
        
        phy
        
        _spriteFooter


scorpion2s entry
       _spriteHeader
 
; $d - Green
; $e - Red
; $f - Off-white
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
       txa
       tcs
       ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
       ldx #$eeef          ; Red, Off-white, Red, Red
       clc
        
       lda $1,s
       and #$f0ff
       ora #$0f00
       sta $1,s
       
       lda $3,s
       and #$fff0
       ora #$000f
       sta $3,s
        
       lda $5,s
       and #$0f00
       ora #$e0ef
       sta $5,s
        
       lda $7,s
       and #$f0f0
       ora #$0f0f
       sta $7,s
       
       lda $a3,s
       and #$f00f
       ora #$0ef0
       sta $a3,s
       
       lda $a7,s
       and #$0fff
       ora #$f000
       sta $a7,s
       
       tsc
       adc #$a6
       tcs
       
       phx
       
       lda $9f,s
       and #$ff00
       ora #$00ff
       sta $9f,s
       
       lda $a1,s
       and #$0f00
       ora #$f0ff
       sta $a1,s
       
       lda $a3,s
       and #$0ff0
       ora #$f00f
       sta $a3,s
       
       lda $a5,s
       and #$0f00
       ora #$f0ff
       sta $a5,s
       
       tsc
       adc #$13e
       tcs
       
       lda $1,s
       and #$0ff0
       ora #$f00f
       sta $1,s
       
       lda $3,s
       and #$0f00
       ora #$f0ff
       sta $3,s
       
       lda $5,s
       and #$ff00
       ora #$00ff
       sta $5,s
       
       lda $7,s
       and #$0f0f
       ora #$f0f0
       sta $7,s
       
       lda $a1,s
       and #$00ff
       ora #$ff00
       sta $a1,s
       
       lda $a5,s
       and #$ff0f
       ora #$00f0
       sta $a5,s
       
       lda $a7,s
       and #$ff0f
       ora #$00f0
       sta $a7,s
       
       tsc
       adc #$a4
       tcs
       
       phy
       
       lda $a1,s
       and #$0f00
       ora #$f0ff
       sta $a1,s
       
       lda $a3,s
       and #$f0ff
       ora #$0f00
       sta $a3,s
       
       lda $a5,s
       and #$ff0f
       ora #$00f0
       sta $a5,s
       
       tsc
       adc #$144
       tcs
       
       phy
       phy
       
       lda $5,s
       and #$ff0f
       ora #$00f0
       sta $5,s
       
       lda $a1,s
       and #$00f0
       ora #$ff0f
       sta $a1,s
       
       tsc
       adc #$a4
       tcs
       
       phy
       
       _spriteFooter


scorpion3 entry
        _spriteHeader
 
; $d - Green
; $e - Red
; $f - Off-white
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
        
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        txa
        tcs
        ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
        ldx #$eeef          ; Red, Off-white, Red, Red
        clc
        
        lda $1,s
        and #$0f0f
        ora #$f0f0
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$e0ef
        sta $3,s
        
        lda $5,s
        and #$0f0f
        ora #$f0f0
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0e0f
        sta $a1,s
        
        tsc
        adc #$a4
        tcs
        
        phx
        
        lda $3,s
        and #$fff0
        ora #$000f
        sta $3,s
        
        lda $9f,s
        and #$0ff0
        ora #$f00f
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$f0ff
        sta $a1,s
        
        lda $a3,s
        and #$ff00
        ora #$00ff
        sta $a3,s
        
        lda $a5,s
        and #$00ff
        ora #$ff00
        sta $a5,s
        
        tsc
        adc #$142
        tcs
        
        phy
        
        tsc
        dec a
        dec a
        tcs
        
        lda $1,s
        and #$00ff
        ora #$ff00
        sta $1,s
        
        lda $5,s
        and #$ff0f
        ora #$00f0
        sta $5,s
        
        lda $7,s
        and #$f0f0
        ora #$0f0f
        sta $7,s
        
        lda $a3,s
        and #$0f00
        ora #$f0ff
        sta $a3,s
        
        lda $a7,s
        and #$f000
        ora #$0fff
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $3,s
        and #$0f00
        ora #$f0ff
        sta $3,s
        
        lda $5,s
        and #$00ff
        ora #$ff00
        sta $5,s
        
        lda $7,s
        and #$f00f
        ora #$0ff0
        sta $7,s
        
        lda $a7,s
        and #$0fff
        ora #$f000
        sta $a7,s
        
        tsc
        adc #$a6
        tcs
        
        phy
        phy
        
        lda $a1,s
        and #$00f0
        ora #$ff0f
        sta $a1,s
        
        lda $a3,s
        and #$0f00
        ora #$f0ff
        sta $a3,s
        
        _spriteFooter


scorpion3s entry
       _spriteHeader

; $d - Green
; $e - Red
; $f - Off-white
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
       txa
       tcs
       ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
       clc
        
       lda $1,s
       and #$f0ff
       ora #$0f00
       sta $1,s
       
       lda $3,s
       and #$f0f0
       ora #$0e0f
       sta $3,s
        
       lda $5,s
       and #$f000
       ora #$0ffe
       sta $5,s
        
       lda $7,s
       and #$fff0
       ora #$000f
       sta $7,s
       
       lda $a3,s
       and #$000f
       ora #$eef0
       sta $a3,s
       
       lda $a5,s
       and #$0f0
       ora #$e0fe
       sta $a5,s
       
       lda $a7,s
       and #$ff0f
       ora #$00f0
       sta $a7,s
    
       tsc
       adc #$142
       tcs
        
       lda $1,s
       and #$f000
       ora #$0fff
       sta $1,s
       
       lda $3,s
       and #$f000
       ora #$0fff
       sta $3,s
        
       lda $5,s
       and #$ff0f
       ora #$00f0
       sta $5,s
        
       lda $7,s
       and #$0ff0
       ora #$f00f
       sta $7,s
       
       lda $a1,s
       and #$00f0
       ora #$ff0f
       sta $a1,s
       
       lda $a7,s
       and #$0f0f
       ora #$f0f0
       sta $a7,s
       
       tsc
       adc #$a4
       tcs
       
       phy
       
       lda $9f,s
       and #$f0ff
       ora #$0f00
       sta $9f,s
       
       lda $a1,s
       and #$ff00
       ora #$00ff
       sta $a1,s
       
       lda $a3,s
       and #$f0ff
       ora #$0f00
       sta $a3,s
       
       lda $a5,s
       and #$0f0f
       ora #$f0f0
       sta $a5,s
       
       tsc
       adc #$13e
       tcs
       
       lda $1,s
       and #$f0ff
       ora #$0f00
       sta $1,s
       
       lda $3,s
       and #$ff00
       ora #$00ff
       sta $3,s
       
       lda $5,s
       and #$00f0
       ora #$ff0f
       sta $5,s
       
       lda $7,s
       and #$0fff
       ora #$f000
       sta $7,s
       
       lda $a1,s
       and #$f0ff
       ora #$0f00
       sta $a1,s
       
       lda $a5,s
       and #$0f00
       ora #$f0ff
       sta $a5,s
       
       lda $a7,s
       and #$fff0
       ora #$000f
       sta $a7,s
       
       tsc
       adc #$a4
       tcs
       
       phy
       
       lda $a3,s
       and #$ff00
       ora #$00ff
       sta $a3,s
       
       tsc
       adc #$a2
       tcs
       
       phy
       
       _spriteFooter


scorpion4 entry
        _spriteHeader
 
; $d - Green
; $e - Red
; $f - Off-white
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
        
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        dex
        txa
        tcs
        ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
        ldx #$eeef          ; Red, Off-white, Red, Red
        clc
        
        lda $1,s
        and #$0f0f
        ora #$f0f0
        sta $1,s
        
        lda $3,s
        and #$0f00
        ora #$e0ef
        sta $3,s
        
        lda $5,s
        and #$0f0f
        ora #$f0f0
        sta $5,s
        
        lda $a1,s
        and #$f0f0
        ora #$0e0f
        sta $a1,s
        
        tsc
        adc #$a4
        tcs
        
        phx
        
        lda $3,s
        and #$fff0
        ora #$000f
        sta $3,s
        
        lda $5,s
        and #$ff0f
        ora #$00f0
        sta $5,s
        
        lda $9f,s
        and #$0ff0
        ora #$f00f
        sta $9f,s
        
        lda $a1,s
        and #$0f00
        ora #$f0ff
        sta $a1,s
        
        lda $a3,s
        and #$f000
        ora #$0fff
        sta $a3,s
        
        lda $a5,s
        and #$0ff0
        ora #$f00f
        sta $a5,s
        
        tsc
        adc #$142
        tcs
        
        phy
        
        tsc
        dec a
        dec a
        tcs
        
        lda $1,s
        and #$00ff
        ora #$ff00
        sta $1,s
        
        lda $5,s
        and #$f00f
        ora #$0ff0
        sta $5,s
        
        lda $7,s
        and #$00ff
        ora #$ff00
        sta $7,s
        
        lda $a3,s
        and #$0f00
        ora #$f0ff
        sta $a3,s
        
        lda $a7,s
        and #$f00f
        ora #$0ff0
        sta $a7,s
        
        tsc
        adc #$140
        tcs
        
        lda $3,s
        and #$0f00
        ora #$f0ff
        sta $3,s
        
        lda $7,s
        and #$f0ff
        ora #$0f00
        sta $7,s
        
        tsc
        adc #$a8
        tcs
        
        phy
        phy
        phy
        
        lda $a1,s
        and #$00f0
        ora #$ff0f
        sta $a1,s
        
        lda $a5,s
        and #$0f00
        ora #$f0ff
        sta $a5,s
        
        tsc
        adc #$a4
        tcs
        
        phy
        
        _spriteFooter


scorpion4s entry
       _spriteHeader

; $d - Green
; $e - Red
; $f - Off-white
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
       txa
       tcs
       ldy #$ffff          ; Off-white, Off-white, Off-white, Off-white
       clc
        
       lda $1,s
       and #$f0ff
       ora #$0f00
       sta $1,s
       
       lda $3,s
       and #$f0f0
       ora #$0e0f
       sta $3,s
        
       lda $5,s
       and #$f000
       ora #$0ffe
       sta $5,s
        
       lda $7,s
       and #$fff0
       ora #$000f
       sta $7,s
       
       lda $a3,s
       and #$000f
       ora #$eef0
       sta $a3,s
       
       lda $a5,s
       and #$0f0
       ora #$e0fe
       sta $a5,s
       
       lda $a7,s
       and #$f00f
       ora #$0ff0
       sta $a7,s
    
       tsc
       adc #$142
       tcs
        
       lda $1,s
       and #$f000
       ora #$0fff
       sta $1,s
       
       lda $3,s
       and #$f000
       ora #$0fff
       sta $3,s
        
       lda $5,s
       and #$0f0f
       ora #$f0f0
       sta $5,s
        
       lda $7,s
       and #$ff00
       ora #$00ff
       sta $7,s
       
       lda $a1,s
       and #$00f0
       ora #$ff0f
       sta $a1,s
       
       lda $a5,s
       and #$0fff
       ora #$f000
       sta $a5,s
       
       lda $a7,s
       and #$0ff0
       ora #$f00f
       sta $a7,s
       
       tsc
       adc #$a4
       tcs
       
       phy
       
       lda $9f,s
       and #$f0ff
       ora #$0f00
       sta $9f,s
       
       lda $a1,s
       and #$ff00
       ora #$00ff
       sta $a1,s
       
       lda $a3,s
       and #$f0ff
       ora #$0f00
       sta $a3,s
       
       lda $a5,s
       and #$0fff
       ora #$f000
       sta $a5,s
       
       tsc
       adc #$13e
       tcs
       
       lda $1,s
       and #$f0ff
       ora #$0f00
       sta $1,s
       
       lda $3,s
       and #$ff00
       ora #$00ff
       sta $3,s
       
       lda $7,s
       and #$0fff
       ora #$f000
       sta $7,s
       
       lda $a1,s
       and #$f0ff
       ora #$0f00
       sta $a1,s
       
       lda $a7,s
       and #$0f00
       ora #$f0ff
       sta $a7,s
       
       tsc
       adc #$a6
       tcs
       
       phy
       phy
       
       tsc
       adc #$a4
       tcs
       
       phy
       phy
       
       lda $5,s
       and #$ff00
       ora #$00ff
       sta $5,s
       
       _spriteFooter


backupStack dc i2'0'

        end
