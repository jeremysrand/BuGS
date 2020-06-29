;
;  colour.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-06-15.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy colour.macros
        keep colour

colour start

setColour entry
        asl a               ; x 2
        asl a               ; x 4
        asl a               ; x 8
        asl a               ; x 16
        asl a               ; x 32
        tay
        ldx #0
loop    lda colour1,y
        sta $e19e00,x
        inx
        inx
        iny
        iny
        cpx #32
        bne loop
        rtl
        
        
colour1 anop
        dc i2'$0000'        ; $0 - 0000 - Black
        dc i2'$00f0'        ; $1 - 0001 - Green    Mushrooms ($1 to $3)
        dc i2'$0f00'        ; $2 - 0010 - Red
        dc i2'$0ffc'        ; $3 - 0011 - Off-white
        dc i2'$0f00'        ; $4 - 0100 - Red
        dc i2'$0f00'        ; $5 - 0101 - Red
        dc i2'$0f00'        ; $6 - 0110 - Red
        dc i2'$0f00'        ; $7 - 0111 - Red
        dc i2'$0ffc'        ; $8 - 1000 - Off-white
        dc i2'$0ffc'        ; $9 - 1001 - Off-white
        dc i2'$0ffc'        ; $a - 1010 - Off-white
        dc i2'$0ffc'        ; $b - 1011 - Off-white
        dc i2'$00f0'        ; $c - 1100 - Green
        dc i2'$00f0'        ; $d - 1101 - Green
        dc i2'$00f0'        ; $e - 1110 - Green
        dc i2'$00f0'        ; $f - 1111 - Green
        

colour2 anop
        dc i2'$0000'        ; Black
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f0f'        ; Violet
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        
        
colour3 anop
        dc i2'$0000'        ; Black
        dc i2'$0f0f'        ; Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        
        
colour4 anop
        dc i2'$0000'        ; Black
        dc i2'$0f0c'        ; Light Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0f0c'        ; Light Violet
        dc i2'$0f0c'        ; Light Violet
        dc i2'$0f0c'        ; Light Violet
        dc i2'$0f0c'        ; Light Violet
        
        
colour5 anop
        dc i2'$0000'        ; Black
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$00ff'        ; Tourquiose
        dc i2'$00ff'        ; Tourquiose
        dc i2'$00ff'        ; Tourquiose
        dc i2'$00ff'        ; Tourquiose

colour6 anop
        dc i2'$0000'        ; Black
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange

colour7 anop
        dc i2'$0000'        ; Black
        dc i2'$0f00'        ; Red
        dc i2'$000f'        ; Blue
        dc i2'$0ff0'        ; Yellow
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red

colour8 anop
        dc i2'$0000'        ; Black
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red

colour9 anop
        dc i2'$0000'        ; Black
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        
colour10 anop
        dc i2'$0000'        ; Black
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$0ffc'        ; Off-white
        dc i2'$0ffc'        ; Off-white
        dc i2'$0ffc'        ; Off-white
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        
colour11 anop
        dc i2'$0000'        ; Black
        dc i2'$0ffc'        ; Off-white
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$0ffc'        ; Off-white
        dc i2'$0ffc'        ; Off-white
        dc i2'$0ffc'        ; Off-white
        dc i2'$0ffc'        ; Off-white
        
colour12 anop
        dc i2'$0000'        ; Black
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
        dc i2'$0fc0'        ; Orange
         anop
colour13 anop
        dc i2'$0000'        ; Black
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$0ff0'        ; Yellow
        dc i2'$00ff'        ; Tourquiose
        dc i2'$00ff'        ; Tourquiose
        dc i2'$00ff'        ; Tourquiose
        dc i2'$00ff'        ; Tourquiose
        
colour14 anop
        dc i2'$0000'        ; Black
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f00'        ; Red
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f0f'        ; Violet
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$0f00'        ; Red
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green
        dc i2'$00f0'        ; Green

        end
