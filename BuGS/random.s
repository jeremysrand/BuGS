;
;  random.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-19.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;
;
; This code was suggested by John Brooks
;
; If you need a random range less than 16 bits, here the smaller EOR constants:
;   BITS EOR_CONST
;     2  $0003
;     3  $0006
;     4  $000C
;     5  $0014
;     6  $0030
;     7  $0060
;     8  $00B8
;     9  $0110
;    10  $0240
;    11  $0500
;    12  $0CA0
;    13  $1B00
;    14  $3500
;    15  $6000
;    16  $B400
;

        case on
        mcopy random.macros
        keep random

random start

randInit entry
        lda randomSeed
        sta seed65535
        
        and #$1f
        bne randInit_store32
        lda #$1f
randInit_store32 anop
        sta seed32
        
        and #$f
        bne randInit_store16
        lda #$f
randInit_store16 anop
        sta seed16
        
        rtl


; Returns a number from 0 to 14
rand0_to_14  entry
        lda seed16
        lsr a
        bcc skipEor16
        eor #$000c
skipEor16 anop
        sta seed16
        dec a
        rtl
        
; Returns a number from 0 to N-1 where N is <= 15, arrives in the accumulator
randN entry
        cmp #2
        blt randN_ret0
        cmp #2
        beq randN_power2
        cmp #4
        beq randN_power2
        cmp #8
        beq randN_power2
        bra randN_doit

randN_power2 anop
        dec a
        sta upperLimit
        jsl rand0_to_65534
        and upperLimit
        rtl
        
randN_ret0 anop
        lda #0
        rtl
        
randN_doit anop
        sta upperLimit
randN_retry anop
        jsl rand0_to_14
        cmp upperLimit
        bge randN_retry
        rtl


; Returns a number from 0 to 30
rand0_to_30 entry
        lda seed32
        lsr a
        bcc skipEor32
        eor #$0014
skipEor32 anop
        sta seed32
        dec a
        rtl
        
; returns a number from 0 to 24
rand25  entry
        jsl rand0_to_30
        cmp #25
        bge rand25
        rtl


; Returns a number from 0 to 65534
rand0_to_65534 entry
        lda seed65535
        lsr a
        bcc skipEor65535
        eor #$b400
skipEor65535 anop
        sta seed65535
        dec a
        rtl
        
        
seed65535   dc i2'0'
seed32      dc i2'0'
seed16      dc i2'0'

upperLimit  dc i2'0'
        end
