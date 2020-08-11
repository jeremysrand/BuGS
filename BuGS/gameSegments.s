;
;  gameSegments.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-07-30.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy gameSegments.macros
        keep gameSegments

gameSegments start
        using globalData
        
SEGMENT_STATE_NONE  equ 0
SEGMENT_STATE_HEAD  equ 1
SEGMENT_STATE_BODY  equ 2

SEGMENT_DIR_LEFT        equ 0
SEGMENT_DIR_DOWN_LEFT   equ 1
SEGMENT_DIR_DOWN        equ 2
SEGMENT_DIR_DOWN_RIGHT  equ 3
SEGMENT_DIR_RIGHT       equ 4
        
        
drawSegments entry
; Write this code...
        rtl
        
        
updateSegments entry
; Write this code...
        rtl
        

addBodySegment entry
; Write this code...
        rtl
        
        
addHeadSegment entry
; Write this code...
        rtl
        

shootSegment entry
; Write this code...
        rtl
        
SEGMENT_SPRITE_LAST_OFFSET  gequ 7*4
leftHeadJumpTable   dc i4'leftHead5'
                    dc i4'leftHead4'
                    dc i4'leftHead1'
                    dc i4'leftHead2'
                    dc i4'leftHead3'
                    dc i4'leftHead2'
                    dc i4'leftHead1'
                    dc i4'leftHead4'
                    

leftHeadShiftJumpTable  dc i4'leftHead5s'
                        dc i4'leftHead4s'
                        dc i4'leftHead1s'
                        dc i4'leftHead2s'
                        dc i4'leftHead3s'
                        dc i4'leftHead2s'
                        dc i4'leftHead1s'
                        dc i4'leftHead4s'
                        

rightHeadJumpTable  dc i4'rightHead5'
                    dc i4'rightHead4'
                    dc i4'rightHead1'
                    dc i4'rightHead2'
                    dc i4'rightHead3'
                    dc i4'rightHead2'
                    dc i4'rightHead1'
                    dc i4'rightHead4'
                    

rightHeadShiftJumpTable dc i4'rightHead5s'
                        dc i4'rightHead4s'
                        dc i4'rightHead1s'
                        dc i4'rightHead2s'
                        dc i4'rightHead3s'
                        dc i4'rightHead2s'
                        dc i4'rightHead1s'
                        dc i4'rightHead4s'


leftDownHeadJumpTable   dc i4'leftDownHead1'
                        dc i4'leftDownHead2'
                        dc i4'leftDownHead1'
                        dc i4'leftDownHead2'
                        dc i4'leftDownHead1'
                        dc i4'leftDownHead2'
                        dc i4'leftDownHead1'
                        dc i4'leftDownHead2'


leftDownShiftHeadJumpTable  dc i4'leftDownHead1s'
                            dc i4'leftDownHead2s'       ; Problem, spills into next tile...
                            dc i4'leftDownHead1s'
                            dc i4'leftDownHead2s'       ; Problem, spills into next tile...
                            dc i4'leftDownHead1s'
                            dc i4'leftDownHead2s'       ; Problem, spills into next tile...
                            dc i4'leftDownHead1s'
                            dc i4'leftDownHead2s'       ; Problem, spills into next tile...
                            

rightDownHeadJumpTable  dc i4'rightDownHead1'
                        dc i4'rightDownHead2'       ; Problem, spills into next tile...
                        dc i4'rightDownHead1'
                        dc i4'rightDownHead2'       ; Problem, spills into next tile...
                        dc i4'rightDownHead1'
                        dc i4'rightDownHead2'       ; Problem, spills into next tile...
                        dc i4'rightDownHead1'
                        dc i4'rightDownHead2'       ; Problem, spills into next tile...


rightDownShiftHeadJumpTable dc i4'rightDownHead1s'
                            dc i4'rightDownHead2s'
                            dc i4'rightDownHead1s'
                            dc i4'rightDownHead2s'
                            dc i4'rightDownHead1s'
                            dc i4'rightDownHead2s'
                            dc i4'rightDownHead1s'
                            dc i4'rightDownHead2s'


downHeadJumpTable   dc i4'downHead3'
                    dc i4'downHead3'
                    dc i4'downHead1'
                    dc i4'downHead1'
                    dc i4'downHead2'
                    dc i4'downHead2'
                    dc i4'downHead1'
                    dc i4'downHead1'


leftBodyJumpTable   dc i4'leftBody5'
                    dc i4'leftBody4'
                    dc i4'leftBody1'
                    dc i4'leftBody2'
                    dc i4'leftBody3'
                    dc i4'leftBody2'
                    dc i4'leftBody1'
                    dc i4'leftBody4'
                    

leftBodyShiftJumpTable  dc i4'leftBody5s'
                        dc i4'leftBody4s'
                        dc i4'leftBody1s'
                        dc i4'leftBody2s'
                        dc i4'leftBody3s'
                        dc i4'leftBody2s'
                        dc i4'leftBody1s'
                        dc i4'leftBody4s'
                        

rightBodyJumpTable  dc i4'rightBody5'
                    dc i4'rightBody4'
                    dc i4'rightBody1'
                    dc i4'rightBody2'
                    dc i4'rightBody3'
                    dc i4'rightBody2'
                    dc i4'rightBody1'
                    dc i4'rightBody4'
                    

rightBodyShiftJumpTable dc i4'rightBody5s'
                        dc i4'rightBody4s'
                        dc i4'rightBody1s'
                        dc i4'rightBody2s'
                        dc i4'rightBody3s'
                        dc i4'rightBody2s'
                        dc i4'rightBody1s'
                        dc i4'rightBody4s'


leftDownBodyJumpTable   dc i4'leftDownBody1'
                        dc i4'leftDownBody2'
                        dc i4'leftDownBody1'
                        dc i4'leftDownBody2'
                        dc i4'leftDownBody1'
                        dc i4'leftDownBody2'
                        dc i4'leftDownBody1'
                        dc i4'leftDownBody2'


leftDownShiftBodyJumpTable  dc i4'leftDownBody1s'
                            dc i4'leftDownBody2s'       ; Problem, spills into next tile...
                            dc i4'leftDownBody1s'
                            dc i4'leftDownBody2s'       ; Problem, spills into next tile...
                            dc i4'leftDownBody1s'
                            dc i4'leftDownBody2s'       ; Problem, spills into next tile...
                            dc i4'leftDownBody1s'
                            dc i4'leftDownBody2s'       ; Problem, spills into next tile...
                            

rightDownBodyJumpTable  dc i4'rightDownBody1'
                        dc i4'rightDownBody2'       ; Problem, spills into next tile...
                        dc i4'rightDownBody1'
                        dc i4'rightDownBody2'       ; Problem, spills into next tile...
                        dc i4'rightDownBody1'
                        dc i4'rightDownBody2'       ; Problem, spills into next tile...
                        dc i4'rightDownBody1'
                        dc i4'rightDownBody2'       ; Problem, spills into next tile...


rightDownShiftBodyJumpTable dc i4'rightDownBody1s'
                            dc i4'rightDownBody2s'
                            dc i4'rightDownBody1s'
                            dc i4'rightDownBody2s'
                            dc i4'rightDownBody1s'
                            dc i4'rightDownBody2s'
                            dc i4'rightDownBody1s'
                            dc i4'rightDownBody2s'


downBodyJumpTable   dc i4'downBody3'
                    dc i4'downBody3'
                    dc i4'downBody1'
                    dc i4'downBody1'
                    dc i4'downBody2'
                    dc i4'downBody2'
                    dc i4'downBody1'
                    dc i4'downBody1'
 
        end
