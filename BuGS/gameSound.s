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


soundInit entry
; Write this code...
		rtl

updateSounds entry
; Write this code...
		rtl


playBonusSound entry
		~FFStartPlaying bonusSoundGen
		lda bonusSoundGen
		asl a
		and #7|BONUS1_SOUND_GENERATOR
		bne playBonusSound_doneSound
		lda #1|BONUS1_SOUND_GENERATOR
playBonusSound_doneSound anop
		sta bonusSoundGen
		rtl


playDeathSound entry
		~FFStartPlaying #1|DEATH_SOUND_GENERATOR
		rtl


playKillSound entry
		~FFStartPlaying #1|KILL_SOUND_GENERATOR
		rtl


playExtraLifeSound entry
; Write this code...
		rtl


playFireSound entry
		~FFStartPlaying fireSoundGen
		lda fireSoundGen
		asl a
		and #31|FIRE1_SOUND_GENERATOR
		bne playFireSound_doneSound
		lda #1|FIRE1_SOUND_GENERATOR
playFireSound_doneSound anop
		sta fireSoundGen
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


bonusSoundGen	dc i2'1|BONUS1_SOUND_GENERATOR'
fireSoundGen	dc i2'1|FIRE1_SOUND_GENERATOR'

        end
