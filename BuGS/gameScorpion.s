;
;  gameScorpion.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-20.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy gameScorpion.macros
        keep gameScorpion

gameScorpion start


scorpionState_none      equ 0
scorpionState_left      equ 1
scorpionState_right     equ 2
scorpionState_exploding equ 3


drawScorpion entry
        rtl
        
        
updateScorpion entry
        rtl
        
        
addScorpion entry
        lda scorpionState
        beq addScorpion_done
        
addScorpion_done anop
        rtl
        

shootScorpion entry
        rtl


scorpionState        dc i2'scorpionState_none'
scorpionScreenOffset dc i2'0'
scorpionTileOffsets  dc i2'0'
                     dc i2'0'
                     dc i2'0'
                     dc i2'0'
                     dc i2'0'
                     dc i2'0'
scorpionSpriteCounter dc i2'0'
scorpionSprite        dc i2'0'

scorpionLeftJumpTable dc i4'leftScorpion1s'
                      dc i4'leftScorpion1'
                      dc i4'leftScorpion1s'
                      dc i4'leftScorpion1'
                      dc i4'leftScorpion2s'
                      dc i4'leftScorpion2'
                      dc i4'leftScorpion2s'
                      dc i4'leftScorpion2'
                      dc i4'leftScorpion3s'
                      dc i4'leftScorpion3'
                      dc i4'leftScorpion3s'
                      dc i4'leftScorpion3'
                      dc i4'leftScorpion4s'
                      dc i4'leftScorpion4'
                      dc i4'leftScorpion4s'
                      dc i4'leftScorpion4'
                 
explosionJumpTable dc i4'explosion1'
                   dc i4'explosion2'
                   dc i4'explosion3'
                   dc i4'explosion4'
                   dc i4'explosion5'
                   dc i4'explosion6'

        end
