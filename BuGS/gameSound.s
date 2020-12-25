;
;  gameSound.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-12-16.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

        case on
        mcopy gameSound.macros
        keep gameSound

gameSound start
        using globalData
        using tileData
		using screenData


SOUND_REG_FREQ_LOW	equ $0000
SOUND_REG_FREQ_HIGH	equ $0020
SOUND_REG_VOLUME	equ $0040
SOUND_REG_POINTER	equ $0080
SOUND_REG_CONTROL	equ $00a0
SOUND_REG_SIZE		equ $00c0
		
SOUND_HALTED		equ 1
SOUND_STARTED		equ 0

SOUND_SWAP_MODE		equ 6
SOUND_ONE_SHOT_MODE	equ 2

; According to all of the documentation I can find, $00 should be the right speaker and
; $10 should be the left.  But based on GSPlus and mame, I see the opposite.  Still need
; to check on my HW.  But in the end, it could be that some HW demultiplexed them backwards
; so there could be either out there in the wild.
SOUND_RIGHT_SPEAKER	equ $10
SOUND_LEFT_SPEAKER	equ $00

; OSC 16 - 19 for L/R channels in swap mode
SPIDER_SOUND_ADDR	equ $0000
SPIDER_OSC_NUM		equ 16
SPIDER_FREQ_HIGH	equ 0
SPIDER_FREQ_LOW		equ 214
SPIDER_CONTROL		equ SOUND_SWAP_MODE
SPIDER_SIZE			equ $36

; OSC 10 & 11 for L/R channels
DEATH_SOUND_ADDR	equ $4000
DEATH_OSC_NUM		equ 10
DEATH_FREQ_HIGH		equ 0
DEATH_FREQ_LOW		equ 214
DEATH_CONTROL		equ SOUND_ONE_SHOT_MODE
DEATH_SIZE			equ $2d

; OSC 12 - 15 for L/R channels in swap mode
SEGMENTS_SOUND_ADDR	equ $7000
SEGMENTS_OSC_NUM	equ 12
SEGMENTS_FREQ_HIGH	equ 0
SEGMENTS_FREQ_LOW	equ 214
SEGMENTS_VOLUME		equ 128
SEGMENTS_CONTROL	equ SOUND_SWAP_MODE
SEGMENTS_SIZE		equ $24

; OSC 20 & 21 for L/R channels
EXTRA_LIFE_SOUND_ADDR	equ $8000
EXTRA_LIFE_OSC_NUM		equ 20
EXTRA_LIFE_FREQ_HIGH	equ 0
EXTRA_LIFE_FREQ_LOW		equ 107
EXTRA_LIFE_VOLUME		equ 128
EXTRA_LIFE_CONTROL		equ SOUND_ONE_SHOT_MODE
EXTRA_LIFE_SIZE		equ $36

; OSC 0 - 5 to have 3x L/R channels
BONUS_SOUND_ADDR	equ $b000
BONUS_OSC_NUM		equ 0
BONUS_FREQ_HIGH		equ 0
BONUS_FREQ_LOW		equ 214
BONUS_CONTROL		equ SOUND_ONE_SHOT_MODE
BONUS_SIZE			equ $24

; OSC 8 & 9 for L/R channels
KILL_SOUND_ADDR		equ $c000
KILL_OSC_NUM		equ 8
KILL_FREQ_HIGH		equ 0
KILL_FREQ_LOW		equ 214
KILL_CONTROL		equ SOUND_ONE_SHOT_MODE
KILL_SIZE			equ $24

; OSC 6 & 7 for L/R channels
FIRE_SOUND_ADDR 	equ $d000
FIRE_OSC_NUM		equ 6
FIRE_FREQ_HIGH		equ 0
FIRE_FREQ_LOW		equ 214
FIRE_CONTROL		equ SOUND_ONE_SHOT_MODE
FIRE_SIZE			equ $1b

; OSC 22 - 25 for L/R channels in swap mode
FLEA_SOUND_ADDR		equ $3a00
FLEA_OSC_NUM		equ 22
FLEA_CONTROL		equ SOUND_SWAP_MODE
FLEA_SIZE			equ $00

; OSC 26 - 30 for L/R channels in swap mode
SCORPION_SOUND_ADDR	equ $e000
SCORPION_OSC_NUM	equ 26
SCORPION_FREQ_HIGH	equ 0
SCORPION_FREQ_LOW	equ 214
SCORPION_CONTROL	equ SOUND_SWAP_MODE
SCORPION_SIZE		equ $2d
		
		
soundInit entry
; Spider sound
		pea SPIDER_SOUND_ADDR
		jsl loadSpiderSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SPIDER_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SPIDER_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SPIDER_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SPIDER_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		
; Death sound
		pea DEATH_SOUND_ADDR
		jsl loadDeathSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #DEATH_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #DEATH_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #DEATH_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #DEATH_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m

		
; Segments sound
		pea SEGMENTS_SOUND_ADDR
		jsl loadSegmentsSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SEGMENTS_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SEGMENTS_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_VOLUME+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SEGMENTS_VOLUME
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SEGMENTS_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SEGMENTS_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m

		
; Bonus sound
		pea BONUS_SOUND_ADDR
		jsl loadBonusSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+BONUS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #BONUS_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+BONUS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #BONUS_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+BONUS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #BONUS_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+BONUS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #BONUS_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+BONUS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
; Kill sound
		pea KILL_SOUND_ADDR
		jsl loadKillSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #KILL_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #KILL_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #KILL_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #KILL_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		long m
		
; Fire sound
		pea FIRE_SOUND_ADDR
		jsl loadFireSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FIRE_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FIRE_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FIRE_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FIRE_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
; Extra life sound
		pea EXTRA_LIFE_SOUND_ADDR
		jsl loadExtraLifeSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_VOLUME+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_VOLUME
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
; Flea sound
		pea FLEA_SOUND_ADDR
		jsl loadFleaSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_SIZE+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FLEA_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FLEA_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		
; Scorpion sound
		pea SCORPION_SOUND_ADDR
		jsl loadScorpionSound
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SCORPION_FREQ_LOW
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SCORPION_FREQ_HIGH
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_SIZE+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SCORPION_SIZE
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_POINTER+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SCORPION_SOUND_ADDR/256
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		
		rtl


updateSounds entry
		lda gameRunning
		bne updateSounds_done
		lda fleaSoundIsPlaying
		bne updateSounds_done
		
updateSounds_changeFreq anop
		ldy fleaSoundFreqOffset
		iny
		iny
		cpy #NUM_FLEA_FREQS*2
		blt updateSounds_notDone
		jmp stopFleaSound
updateSounds_notDone anop
		sty fleaSoundFreqOffset
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_FREQ_LOW+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda fleaFreqs,y
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda fleaFreqs+1,y
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		
updateSounds_done anop
		rtl


playBonusSound entry
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda bonusSoundOscReg
		sta >SOUND_ADDR_LOW
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		
		lda bonusSoundOscReg
		and #$1f
		ora #SOUND_REG_VOLUME
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		
		lda bonusSoundOscReg
		sta >SOUND_ADDR_LOW
		lda #BONUS_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #BONUS_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
		lda bonusSoundOscReg
		inc a
		inc a
		cmp #SOUND_REG_CONTROL+BONUS_OSC_NUM+6
		blt playBonusSound_noWrap
		lda #SOUND_REG_CONTROL+BONUS_OSC_NUM
playBonusSound_noWrap anop
		sta bonusSoundOscReg
		rtl


playDeathSound entry
		jsl stopSpiderSound
		jsl stopFleaSound
		jsl stopScorpionSound
		jsl stopSegmentSound
		
		lda mouseAddress
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		tax
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_VOLUME+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+DEATH_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #DEATH_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #DEATH_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
		rtl


playKillSound entry
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_VOLUME+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+KILL_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #KILL_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #KILL_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
		rtl


playFireSound entry
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_VOLUME+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+FIRE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FIRE_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #FIRE_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		
		long m
		rtl
		

playExtraLifeSound entry
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #EXTRA_LIFE_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #EXTRA_LIFE_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		rtl

		
		
startSegmentSound entry
		lda segmentSoundIsPlaying
		bne startSegmentSound_doIt
		rtl
		
startSegmentSound_doIt anop
		stz segmentSoundIsPlaying
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SEGMENTS_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SEGMENTS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SEGMENTS_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SEGMENTS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
		rtl
		
		
stopSegmentSound entry
		lda segmentSoundIsPlaying
		beq stopSegmentSound_doIt
		rtl
		
stopSegmentSound_doIt anop
		lda #1
		sta segmentSoundIsPlaying
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		
		rtl
		
		
startSpiderSound entry
		lda spiderSoundIsPlaying
		bne startSpiderSound_doIt
		rtl
		
startSpiderSound_doIt anop
		stz spiderSoundIsPlaying
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_VOLUME+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SPIDER_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SPIDER_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SPIDER_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SPIDER_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		
		rtl

		
updateSpiderSound entry
		lda spiderSoundIsPlaying
		beq updateSpiderSound_doIt
		rtl

updateSpiderSound_doIt anop
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_VOLUME+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		rtl
		

stopSpiderSound entry
		lda spiderSoundIsPlaying
		beq stopSpiderSound_doIt
		rtl
		
stopSpiderSound_doIt anop
		lda #1
		sta spiderSoundIsPlaying
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SPIDER_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		
		rtl


startScorpionSound entry
		lda scorpionSoundIsPlaying
		bne startScorpionSound_doIt
		rtl
		
startScorpionSound_doIt anop
		stz scorpionSoundIsPlaying
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_VOLUME+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SCORPION_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SCORPION_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SCORPION_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		lda #SCORPION_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		rtl
		
		
updateScorpionSound entry
		lda scorpionSoundIsPlaying
		beq updateScorpionSound_doIt
		rtl
		
updateScorpionSound_doIt anop
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG

		lda #SOUND_REG_VOLUME+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		
		rtl
		

stopScorpionSound entry
		lda scorpionSoundIsPlaying
		beq stopScorpionSound_doIt
		rtl
		
stopScorpionSound_doIt anop
		lda #1
		sta scorpionSoundIsPlaying
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+SCORPION_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m

		rtl


startFleaSound entry
		lda fleaSoundIsPlaying
		bne startFleaSound_doIt
		rtl
		
startFleaSound_doIt anop
		stz fleaSoundIsPlaying
		stz fleaSoundFreqOffset
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_VOLUME+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda tileRightVolume,x
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		eor #$ff
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_LOW+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda fleaFreqs
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_FREQ_HIGH+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda fleaFreqs+1
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #FLEA_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #FLEA_CONTROL+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		lda #FLEA_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		lda #FLEA_CONTROL+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		long m
		rtl


stopFleaSound entry
		lda fleaSoundIsPlaying
		beq stopFleaSound_doIt
		rtl
		
stopFleaSound_doIt anop
		lda #1
		sta fleaSoundIsPlaying
		
		short m
		lda >SOUND_SYSTEM_VOLUME
		and #$0f
		ora #$20
		sta >SOUND_CONTROL_REG
		
		lda #SOUND_REG_CONTROL+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_RIGHT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_LEFT_SPEAKER
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		
		lda #SOUND_REG_CONTROL+FLEA_OSC_NUM
		sta >SOUND_ADDR_LOW
		lda #SOUND_ONE_SHOT_MODE+SOUND_RIGHT_SPEAKER+SOUND_HALTED
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		lda #SOUND_ONE_SHOT_MODE+SOUND_LEFT_SPEAKER+SOUND_HALTED
		sta >SOUND_DATA_REG
		sta >SOUND_DATA_REG
		long m
		rtl


bonusSoundOscReg	dc i2'SOUND_REG_CONTROL+BONUS_OSC_NUM'
fleaSoundIsPlaying		dc i2'1'
fleaSoundFreqOffset		dc i2'0'
segmentSoundIsPlaying	dc i2'1'
spiderSoundIsPlaying	dc i2'1'
scorpionSoundIsPlaying	dc i2'1'

        end
