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
        dc i2'$0000'        ; Black
        dc i2'$00f0'        ; Green         ; Mushrooms ($1 to $3)
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00f0'        ; Green         ; Centipedes ($4 to $6)
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00f0'        ; Green         ; Spiders ($7 to $9)
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00f0'        ; Green         ; Fleas ($a to $c)
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00f0'        ; Green         ; Scorpions ($d to $f)
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        

colour2 anop
        dc i2'$0000'        ; Black
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f0f'        ; Violet
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f0f'        ; Violet
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f0f'        ; Violet
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f0f'        ; Violet
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f0f'        ; Violet
        dc i2'$0ff0'        ; Yellow
        
        
colour3 anop
        dc i2'$0000'        ; Black
        dc i2'$0f0f'        ; Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0f0f'        ; Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0f0f'        ; Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0f0f'        ; Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0f0f'        ; Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        
        
colour4 anop
        dc i2'$0000'        ; Black
        dc i2'$0f0c'        ; Light Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$0f0c'        ; Light Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$0f0c'        ; Light Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$0f0c'        ; Light Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$0f0c'        ; Light Violet
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        
        
colour5 anop
        dc i2'$0000'        ; Black
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue

colour6 anop
        dc i2'$0000'        ; Black
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose

colour7 anop
        dc i2'$0000'        ; Black
        dc i2'$0f00'        ; Red
        dc i2'$000f'        ; Blue
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f00'        ; Red
        dc i2'$000f'        ; Blue
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f00'        ; Red
        dc i2'$000f'        ; Blue
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f00'        ; Red
        dc i2'$000f'        ; Blue
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f00'        ; Red
        dc i2'$000f'        ; Blue
        dc i2'$0ff0'        ; Yellow

colour8 anop
        dc i2'$0000'        ; Black
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00fc'        ; Light Tourquiose

colour9 anop
        dc i2'$0000'        ; Black
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ff0'        ; Yellow
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        
colour10 anop
        dc i2'$0000'        ; Black
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ffc'        ; Off-white
        
colour11 anop
        dc i2'$0000'        ; Black
        dc i2'$0ffc'        ; Off-white
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ffc'        ; Off-white
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ffc'        ; Off-white
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ffc'        ; Off-white
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        dc i2'$0ffc'        ; Off-white
        dc i2'$0f0f'        ; Violet
        dc i2'$00f0'        ; Green
        
colour12 anop
        dc i2'$0000'        ; Black
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
        dc i2'$0fc0'        ; Orange
        dc i2'$000f'        ; Blue
        dc i2'$00fc'        ; Light Tourquiose
         anop
colour13 anop
        dc i2'$0000'        ; Black
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        dc i2'$00ff'        ; Tourquiose
        dc i2'$0f00'        ; Red
        dc i2'$0ff0'        ; Yellow
        
colour14 anop
        dc i2'$0000'        ; Black
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f00'        ; Red
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f00'        ; Red
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f00'        ; Red
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f00'        ; Red
        dc i2'$00f0'        ; Green
        dc i2'$0f0f'        ; Violet
        dc i2'$0f00'        ; Red

        end
