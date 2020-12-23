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
SPIDER_VOLUME		equ 128
SPIDER_CONTROL		equ 6
SPIDER_SIZE			equ $36

; OSC 10 & 11 for L/R channels
DEATH_SOUND_ADDR	equ $4000
DEATH_OSC_NUM		equ 10
DEATH_FREQ_HIGH		equ 0
DEATH_FREQ_LOW		equ 214
DEATH_VOLUME		equ 80
DEATH_CONTROL		equ 2
DEATH_SIZE			equ $36

; OSC 12 - 15 for L/R channels in swap mode
SEGMENTS_SOUND_ADDR	equ $7000
SEGMENTS_OSC_NUM	equ 12
SEGMENTS_FREQ_HIGH	equ 0
SEGMENTS_FREQ_LOW	equ 214
SEGMENTS_VOLUME		equ 80
SEGMENTS_CONTROL	equ 6
SEGMENTS_SIZE		equ $24

; OSC 20 & 21 for L/R channels
EXTRA_LIFE_SOUND_ADDR	equ $8000
EXTRA_LIFE_OSC_NUM		equ 20
EXTRA_LIFE_FREQ_HIGH	equ 0
EXTRA_LIFE_FREQ_LOW		equ 107
EXTRA_LIFE_VOLUME		equ 128
EXTRA_LIFE_CONTROL		equ 2
EXTRA_LIFE_SIZE		equ $36

; OSC 0 - 5 to have 3x L/R channels
BONUS_SOUND_ADDR	equ $b000
BONUS_OSC_NUM		equ 0
BONUS_FREQ_HIGH		equ 0
BONUS_FREQ_LOW		equ 214
BONUS_CONTROL		equ 2
BONUS_SIZE			equ $24

; OSC 8 & 9 for L/R channels
KILL_SOUND_ADDR		equ $c000
KILL_OSC_NUM		equ 8
KILL_FREQ_HIGH		equ 0
KILL_FREQ_LOW		equ 214
KILL_CONTROL		equ 2
KILL_SIZE			equ $24

; OSC 6 & 7 for L/R channels
FIRE_SOUND_ADDR 	equ $d000
FIRE_OSC_NUM		equ 6
FIRE_FREQ_HIGH		equ 0
FIRE_FREQ_LOW		equ 214
FIRE_CONTROL		equ 2
FIRE_SIZE			equ $1b

; OSC 22 - 25 for L/R channels in swap mode
FLEA_SOUND_ADDR		equ $3a00
FLEA_OSC_NUM		equ 22
FLEA_CONTROL		equ 6
FLEA_SIZE			equ $00
FLEA_FRAME_COUNT	equ 5


; X register has the address of the register to read
; Accumulator contains the result of the read
readSoundReg entry
		short m
readSoundReg_jslInst anop
		jsl readSoundReg
		long m
		and #$ff
		rtl


; X register has the address of the register to write
; Accumulator has the value to write
writeSoundReg entry
		and #$ff
		short m
writeSoundReg_jslInst anop
		jsl writeSoundReg
		long m
		rtl
		
; X register has the address of the register to write
; Accumulator has the value to write
writeConsecSoundReg entry
		and #$ff
		short m
		pha
		phx
writeConsecSoundReg_jslInst1 anop
		jsl writeSoundReg
		plx
		inx
		pla
writeConsecSoundReg_jslInst2 anop
		jsl writeSoundReg
		long m
		rtl
		
		
soundInit entry
;		jsl loadSounds
		
		pha
		pha
		~GetTableAddress
		pla
		sta soundInit_readRegLow+1
		inc a
		inc a
		sta soundInit_readRegHigh+1
		inc a
		inc a
		sta soundInit_writeRegLow+1
		inc a
		inc a
		sta soundInit_writeRegHigh+1
		pla
		and #$ff
		
		short m
		sta soundTableAddr+2
		sta soundInit_readRegLow+3
		sta soundInit_readRegHigh+3
		sta soundInit_writeRegLow+3
		sta soundInit_writeRegHigh+3

soundInit_readRegHigh anop
		lda >soundInit
		sta readSoundReg_jslInst+3
		  
soundInit_writeRegHigh anop
		lda >soundInit
		sta writeSoundReg_jslInst+3
		sta writeConsecSoundReg_jslInst1+3
		sta writeConsecSoundReg_jslInst2+3
		long m
		
soundInit_readRegLow anop
		lda >soundInit
		sta readSoundReg_jslInst+1
		
soundInit_writeRegLow anop
		lda >soundInit
		sta writeSoundReg_jslInst+1
		sta writeConsecSoundReg_jslInst1+1
		sta writeConsecSoundReg_jslInst2+1

		
; Spider sound
		pea SPIDER_SOUND_ADDR
		jsl loadSpiderSound
		
		lda #SPIDER_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SPIDER_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SPIDER_VOLUME
		ldx #SOUND_REG_VOLUME+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SPIDER_SIZE
		ldx #SOUND_REG_SIZE+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SPIDER_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SPIDER_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SPIDER_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SPIDER_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SPIDER_VOLUME
		ldx #SOUND_REG_VOLUME+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SPIDER_SIZE
		ldx #SOUND_REG_SIZE+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SPIDER_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SPIDER_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg

		
; Death sound
		pea DEATH_SOUND_ADDR
		jsl loadDeathSound
		
		lda #DEATH_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+DEATH_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #DEATH_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+DEATH_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #DEATH_VOLUME
		ldx #SOUND_REG_VOLUME+DEATH_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #DEATH_SIZE
		ldx #SOUND_REG_SIZE+DEATH_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #DEATH_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+DEATH_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM+1
		jsl writeSoundReg

		
; Segments sound
		pea SEGMENTS_SOUND_ADDR
		jsl loadSegmentsSound
		
		lda #SEGMENTS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+SEGMENTS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+SEGMENTS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_VOLUME
		ldx #SOUND_REG_VOLUME+SEGMENTS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_SIZE
		ldx #SOUND_REG_SIZE+SEGMENTS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+SEGMENTS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+SEGMENTS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+SEGMENTS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_VOLUME
		ldx #SOUND_REG_VOLUME+SEGMENTS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_SIZE
		ldx #SOUND_REG_SIZE+SEGMENTS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+SEGMENTS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM+2
		jsl writeConsecSoundReg

		
; Bonus sound
		pea BONUS_SOUND_ADDR
		jsl loadBonusSound
		
		lda #BONUS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+BONUS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #BONUS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+BONUS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #BONUS_SIZE
		ldx #SOUND_REG_SIZE+BONUS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #BONUS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+BONUS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM+1
		jsl writeSoundReg
		
		lda #BONUS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+BONUS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #BONUS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+BONUS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #BONUS_SIZE
		ldx #SOUND_REG_SIZE+BONUS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #BONUS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+BONUS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM+2
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM+3
		jsl writeSoundReg
		
		lda #BONUS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+BONUS_OSC_NUM+4
		jsl writeConsecSoundReg
		
		lda #BONUS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+BONUS_OSC_NUM+4
		jsl writeConsecSoundReg
		
		lda #BONUS_SIZE
		ldx #SOUND_REG_SIZE+BONUS_OSC_NUM+4
		jsl writeConsecSoundReg
		
		lda #BONUS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+BONUS_OSC_NUM+4
		jsl writeConsecSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM+4
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM+5
		jsl writeSoundReg
		
; Kill sound
		pea KILL_SOUND_ADDR
		jsl loadKillSound
		
		lda #KILL_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+KILL_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #KILL_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+KILL_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #KILL_SIZE
		ldx #SOUND_REG_SIZE+KILL_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #KILL_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+KILL_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM+1
		jsl writeSoundReg
		
		
; Fire sound
		pea FIRE_SOUND_ADDR
		jsl loadFireSound
		
		lda #FIRE_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+FIRE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #FIRE_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+FIRE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #FIRE_SIZE
		ldx #SOUND_REG_SIZE+FIRE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #FIRE_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+FIRE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM+1
		jsl writeSoundReg
		
; Extra life sound
		pea EXTRA_LIFE_SOUND_ADDR
		jsl loadExtraLifeSound
		
		lda #EXTRA_LIFE_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+EXTRA_LIFE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #EXTRA_LIFE_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+EXTRA_LIFE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #EXTRA_LIFE_VOLUME
		ldx #SOUND_REG_VOLUME+EXTRA_LIFE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #EXTRA_LIFE_SIZE
		ldx #SOUND_REG_SIZE+EXTRA_LIFE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #EXTRA_LIFE_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+EXTRA_LIFE_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM
		jsl writeSoundReg
		
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM+1
		jsl writeSoundReg
		
; Flea sound
		pea FLEA_SOUND_ADDR
		jsl loadFleaSound

		lda #FLEA_SIZE
		ldx #SOUND_REG_SIZE+FLEA_OSC_NUM
		jsl writeConsecSoundReg

		lda #FLEA_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+FLEA_OSC_NUM
		jsl writeConsecSoundReg

		lda #FLEA_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+FLEA_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #FLEA_SIZE
		ldx #SOUND_REG_SIZE+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg

		lda #FLEA_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg

		lda #FLEA_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg
		
		rtl


updateSounds entry
		lda gameRunning
		bne updateSounds_done
		lda fleaSoundIsPlaying
		bne updateSounds_done
		
updateSounds_changeFreq anop
		ldy fleaSoundFreqOffset
		cpy #NUM_FLEA_FREQS*2
		blt updateSounds_notDone
		jmp stopFleaSound
updateSounds_notDone anop
		lda #FLEA_FRAME_COUNT
		sta fleaSoundFrame
		iny
		iny
		sty fleaSoundFreqOffset
		
		lda fleaFreqs,y
		pha
		ldx #SOUND_REG_FREQ_LOW+FLEA_OSC_NUM
		jsl writeConsecSoundReg
		pla
		ldx #SOUND_REG_FREQ_LOW+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg

		ldy fleaSoundFreqOffset
		lda fleaFreqs+1,y
		pha
		ldx #SOUND_REG_FREQ_HIGH+FLEA_OSC_NUM
		jsl writeConsecSoundReg
		pla
		ldx #SOUND_REG_FREQ_HIGH+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg
		
updateSounds_done anop
		rtl


playBonusSound entry
		lda tileRightVolume,x
		pha
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx bonusSoundOscReg
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx bonusSoundOscReg
		inx
		jsl writeSoundReg
		
		lda bonusSoundOscReg
		and #$1f
		ora #SOUND_REG_VOLUME
		tax
		pla
		pha
		phx
		jsl writeSoundReg
		
		plx
		inx
		pla
		eor #$ff
		jsl writeSoundReg

		lda #BONUS_CONTROL+SOUND_RIGHT_SPEAKER
		ldx bonusSoundOscReg
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_LEFT_SPEAKER
		ldx bonusSoundOscReg
		inx
		jsl writeSoundReg
		
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
		
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM+1
		jsl writeSoundReg
		
		lda mouseAddress
		sec
		sbc #SCREEN_ADDRESS
		and #$fffc
		tax
		lda >screenToTileOffset,x
		tax
		lda tileRightVolume,x
		pha
		ldx #SOUND_REG_VOLUME+DEATH_OSC_NUM
		jsl writeSoundReg
		
		pla
		eor #$ff
		ldx #SOUND_REG_VOLUME+DEATH_OSC_NUM+1
		jsl writeSoundReg

		lda #DEATH_CONTROL+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_CONTROL+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM+1
		jsl writeSoundReg
		rtl


playKillSound entry
		lda tileRightVolume,x
		pha
		
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM+1
		jsl writeSoundReg
		
		pla
		pha
		ldx #SOUND_REG_VOLUME+KILL_OSC_NUM
		jsl writeSoundReg
		
		pla
		eor #$ff
		ldx #SOUND_REG_VOLUME+KILL_OSC_NUM+1
		jsl writeSoundReg
	  
		lda #KILL_CONTROL+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_CONTROL+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM+1
		jsl writeSoundReg
		rtl


playFireSound entry
		lda tileRightVolume,x
		pha
		
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM+1
		jsl writeSoundReg
		
		pla
		pha
		ldx #SOUND_REG_VOLUME+FIRE_OSC_NUM
		jsl writeSoundReg
		
		pla
		eor #$ff
		ldx #SOUND_REG_VOLUME+FIRE_OSC_NUM+1
		jsl writeSoundReg
		
		lda #FIRE_CONTROL+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_CONTROL+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM+1
		jsl writeSoundReg
		rtl
		

playExtraLifeSound entry
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM
		jsl writeSoundReg
		
		lda #EXTRA_LIFE_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM+1
		jsl writeSoundReg

		lda #EXTRA_LIFE_CONTROL+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM
		jsl writeSoundReg
		
		lda #EXTRA_LIFE_CONTROL+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+EXTRA_LIFE_OSC_NUM+1
		jsl writeSoundReg
		rtl

		
		
startSegmentSound entry
		jsl stopSegmentSound
		
		lda #SEGMENTS_CONTROL+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM
		jsl writeSoundReg
		
		lda #SEGMENTS_CONTROL+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM+2
		jsl writeSoundReg
		
		rtl
		
		
stopSegmentSound entry
		lda #SEGMENTS_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SEGMENTS_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+SEGMENTS_OSC_NUM+2
		jsl writeConsecSoundReg
		
		rtl
		
		
startSpiderSound entry
		lda tileRightVolume,x
		pha
		jsl stopSpiderSound
		
		pla
		pha
		ldx #SOUND_REG_VOLUME+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		pla
		eor #$ff
		ldx #SOUND_REG_VOLUME+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg

		lda #SPIDER_CONTROL+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+SPIDER_OSC_NUM
		jsl writeSoundReg
		
		lda #SPIDER_CONTROL+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+SPIDER_OSC_NUM+2
		jsl writeSoundReg
		rtl

		
updateSpiderSound entry
		lda tileRightVolume,x
		pha
		ldx #SOUND_REG_VOLUME+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		pla
		eor #$ff
		ldx #SOUND_REG_VOLUME+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg
		
		rtl
		

stopSpiderSound entry
		lda #SPIDER_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+SPIDER_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #SPIDER_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+SPIDER_OSC_NUM+2
		jsl writeConsecSoundReg
		
		rtl


startScorpionSound entry
; Write this code...
		rtl


stopScorpionSound entry
; Write this code...
		rtl


startFleaSound entry
		lda fleaSoundIsPlaying
		bne startFleaSound_doIt
		rtl
		
startFleaSound_doIt anop
		stz fleaSoundIsPlaying
		stz fleaSoundFreqOffset
		
		lda tileRightVolume,x
		pha
		ldx #SOUND_REG_VOLUME+FLEA_OSC_NUM
		jsl writeConsecSoundReg
		
		pla
		eor #$ff
		ldx #SOUND_REG_VOLUME+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #FLEA_FRAME_COUNT
		sta fleaSoundFrame
		
		lda fleaFreqs
		ldx #SOUND_REG_FREQ_LOW+FLEA_OSC_NUM
		jsl writeConsecSoundReg
		
		lda fleaFreqs
		ldx #SOUND_REG_FREQ_LOW+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg

		lda fleaFreqs+1
		ldx #SOUND_REG_FREQ_HIGH+FLEA_OSC_NUM
		jsl writeConsecSoundReg
		
		lda fleaFreqs+1
		ldx #SOUND_REG_FREQ_HIGH+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #FLEA_CONTROL+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+FLEA_OSC_NUM
		jsl writeSoundReg
		
		lda #FLEA_CONTROL+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+FLEA_OSC_NUM+2
		jsl writeSoundReg
		rtl


stopFleaSound entry
		lda #FLEA_CONTROL+SOUND_HALTED+SOUND_RIGHT_SPEAKER
		ldx #SOUND_REG_CONTROL+FLEA_OSC_NUM
		jsl writeConsecSoundReg
		
		lda #FLEA_CONTROL+SOUND_HALTED+SOUND_LEFT_SPEAKER
		ldx #SOUND_REG_CONTROL+FLEA_OSC_NUM+2
		jsl writeConsecSoundReg
		
		lda #1
		sta fleaSoundIsPlaying
		rtl


bonusSoundOscReg	dc i2'SOUND_REG_CONTROL+BONUS_OSC_NUM'
soundTableAddr		dc i4'0'
fleaSoundIsPlaying		dc i2'1'
fleaSoundFreqOffset		dc i2'0'
fleaSoundFrame			dc i2'0'

        end
