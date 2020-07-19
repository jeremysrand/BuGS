;
;  random.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-19.
;Copyright © 2020 Jeremy Rand. All rights reserved.
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
        rtl


; Returns a number from 1 to 31
rand32  entry
        lda seed32
        lsr a
        bcc skipEor32
        eor #$0014
skipEor32 anop
        sta seed32
        rtl
        
; returns a number from 0 to 24
rand25  entry
        jsl rand32
        dec a
        cmp #25
        bge rand25
        rtl


; Returns a number from 1 to 65535
rand65535 entry
        lda seed65535
        lsr a
        bcc skipEor65535
        eor #$b400
skipEor65535 anop
        sta seed65535
        rtl
        
        
seed65535 dc i2'0'
seed32    dc i2'0'
        end
