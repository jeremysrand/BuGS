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



SOUND_REG_FREQ_LOW	equ $0000
SOUND_REG_FREQ_HIGH	equ $0020
SOUND_REG_VOLUME	equ $0040
SOUND_REG_POINTER	equ $0080
SOUND_REG_CONTROL	equ $00a0
SOUND_REG_SIZE		equ $00c0
		
SOUND_HALTED		equ 1
SOUND_STARTED		equ 0

SPIDER_SOUND_ADDR	equ $0000
SPIDER_SOUND_SIZE	equ 6

DEATH_SOUND_ADDR	equ $4000
DEATH_OSC_NUM		equ 5
DEATH_FREQ_HIGH		equ 0
DEATH_FREQ_LOW		equ 214
DEATH_VOLUME		equ 255
DEATH_CONTROL		equ 2
DEATH_SIZE			equ $36

SEGMENTS_SOUND_ADDR	equ $7000
SEGMENTS_SOUND_SIZE	equ 4

BONUS_SOUND_ADDR	equ $8000
BONUS_OSC_NUM		equ 0
BONUS_FREQ_HIGH		equ 0
BONUS_FREQ_LOW		equ 214
BONUS_VOLUME		equ 255
BONUS_CONTROL		equ 2
BONUS_SIZE			equ $24

KILL_SOUND_ADDR		equ $9000
KILL_OSC_NUM		equ 4
KILL_FREQ_HIGH		equ 0
KILL_FREQ_LOW		equ 214
KILL_VOLUME			equ 255
KILL_CONTROL		equ 2
KILL_SIZE			equ $24

FIRE_SOUND_ADDR 	equ $a000
FIRE_OSC_NUM		equ 3
FIRE_FREQ_HIGH		equ 0
FIRE_FREQ_LOW		equ 214
FIRE_VOLUME			equ 255
FIRE_CONTROL		equ 2
FIRE_SIZE			equ $1b


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
		long m
		
soundInit_readRegLow anop
		lda >soundInit
		sta readSoundReg_jslInst+1
		
soundInit_writeRegLow anop
		lda >soundInit
		sta writeSoundReg_jslInst+1

		
; Spider sound
		pea SPIDER_SOUND_ADDR
		jsl loadSpiderSound

		
; Death sound
		pea DEATH_SOUND_ADDR
		jsl loadDeathSound
		
		lda #DEATH_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_VOLUME
		ldx #SOUND_REG_VOLUME+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_SIZE
		ldx #SOUND_REG_SIZE+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+DEATH_OSC_NUM
		jsl writeSoundReg
		
		lda #DEATH_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM
		jsl writeSoundReg

		
; Segments sound
		pea SEGMENTS_SOUND_ADDR
		jsl loadSegmentsSound

		
; Bonus sound
		pea BONUS_SOUND_ADDR
		jsl loadBonusSound
		
		lda #BONUS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+BONUS_OSC_NUM
		jsl writeSoundReg
		
		lda #BONUS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+BONUS_OSC_NUM
		jsl writeSoundReg
		
		lda #BONUS_VOLUME
		ldx #SOUND_REG_VOLUME+BONUS_OSC_NUM
		jsl writeSoundReg
		
		lda #BONUS_SIZE
		ldx #SOUND_REG_SIZE+BONUS_OSC_NUM
		jsl writeSoundReg
		
		lda #BONUS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+BONUS_OSC_NUM
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM
		jsl writeSoundReg
		
		lda #BONUS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+BONUS_OSC_NUM+1
		jsl writeSoundReg
		
		lda #BONUS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+BONUS_OSC_NUM+1
		jsl writeSoundReg
		
		lda #BONUS_VOLUME
		ldx #SOUND_REG_VOLUME+BONUS_OSC_NUM+1
		jsl writeSoundReg
		
		lda #BONUS_SIZE
		ldx #SOUND_REG_SIZE+BONUS_OSC_NUM+1
		jsl writeSoundReg
		
		lda #BONUS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+BONUS_OSC_NUM+1
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM+1
		jsl writeSoundReg
		
		lda #BONUS_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+BONUS_OSC_NUM+2
		jsl writeSoundReg
		
		lda #BONUS_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+BONUS_OSC_NUM+2
		jsl writeSoundReg
		
		lda #BONUS_VOLUME
		ldx #SOUND_REG_VOLUME+BONUS_OSC_NUM+2
		jsl writeSoundReg
		
		lda #BONUS_SIZE
		ldx #SOUND_REG_SIZE+BONUS_OSC_NUM+2
		jsl writeSoundReg
		
		lda #BONUS_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+BONUS_OSC_NUM+2
		jsl writeSoundReg
		
		lda #BONUS_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+BONUS_OSC_NUM+2
		jsl writeSoundReg
		
; Kill sound
		pea KILL_SOUND_ADDR
		jsl loadKillSound
		
		lda #KILL_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_VOLUME
		ldx #SOUND_REG_VOLUME+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_SIZE
		ldx #SOUND_REG_SIZE+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+KILL_OSC_NUM
		jsl writeSoundReg
		
		lda #KILL_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM
		jsl writeSoundReg
		
		
; Fire sound
		pea FIRE_SOUND_ADDR
		jsl loadFireSound
		
		lda #FIRE_FREQ_LOW
		ldx #SOUND_REG_FREQ_LOW+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_FREQ_HIGH
		ldx #SOUND_REG_FREQ_HIGH+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_VOLUME
		ldx #SOUND_REG_VOLUME+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_SIZE
		ldx #SOUND_REG_SIZE+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_SOUND_ADDR/256
		ldx #SOUND_REG_POINTER+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM
		jsl writeSoundReg

		rtl


updateSounds entry
; Write this code...
		rtl


playBonusSound entry
		lda #BONUS_CONTROL+SOUND_HALTED
		ldx bonusSoundOscReg
		jsl writeSoundReg

		lda #BONUS_CONTROL
		ldx bonusSoundOscReg
		jsl writeSoundReg
		
		lda bonusSoundOscReg
		inc a
		cmp #SOUND_REG_CONTROL+BONUS_OSC_NUM+3
		blt playBonusSound_noWrap
		lda #SOUND_REG_CONTROL+BONUS_OSC_NUM
playBonusSound_noWrap anop
		sta bonusSoundOscReg
		rtl


playDeathSound entry
		lda #DEATH_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM
		jsl writeSoundReg

		lda #DEATH_CONTROL
		ldx #SOUND_REG_CONTROL+DEATH_OSC_NUM
		jsl writeSoundReg
		rtl


playKillSound entry
		lda #KILL_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM
		jsl writeSoundReg
	  
		lda #KILL_CONTROL
		ldx #SOUND_REG_CONTROL+KILL_OSC_NUM
		jsl writeSoundReg
		rtl


playExtraLifeSound entry
; Write this code...
		rtl


playFireSound entry
		lda #FIRE_CONTROL+SOUND_HALTED
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM
		jsl writeSoundReg
		
		lda #FIRE_CONTROL
		ldx #SOUND_REG_CONTROL+FIRE_OSC_NUM
		jsl writeSoundReg
		rtl


startSpiderSound entry
; Write this code...
		rtl


stopSpiderSound entry
; Write this code...
		rtl


startScorpionSound entry
; Write this code...
		rtl


stopScorpionSound entry
; Write this code...
		rtl


startFleaSound entry
; Write this code...
		rtl


stopFleaSound entry
; Write this code...
		rtl


bonusSoundOscReg	dc i2'SOUND_REG_CONTROL+BONUS_OSC_NUM'
soundTableAddr		dc i4'0'

        end
