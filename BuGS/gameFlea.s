;
;  gameFlea.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-18.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy gameFlea.macros
        keep gameFlea

gameFlea start

fleaState_none equ 0
fleaState_falling equ 1
fleaState_exploding equ 2

drawFlea entry
        lda fleaState
        beq drawFlea_done
        
        ldy fleaScreenOffset
        jsl flea1
        
        ldx fleaTileOffsets
        
drawFlea_done anop
        rtl
        
        
updateFlea entry
        lda fleaState
        beq updateFlea_done
        
updateFlea_done anop
        rtl
        

addFlea entry
        rtl
        
        
fleaState        dc i2'fleaState_none'
fleaScreenOffset dc i2'0'
fleaTileOffsets  dc i2'0'
                 dc i2'0'
                 dc i2'0'
                 dc i2'0'

        end
