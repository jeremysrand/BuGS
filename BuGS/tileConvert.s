;
;  tileConvert.s
;  BuGS
;
;  Created by Jeremy Rand on 2020-12-30.
;Copyright © 2020 Jeremy Rand. All rights reserved.
;

		case on
        mcopy tileConvert.macros
        keep tileConvert

tileConvert start
		using globalData
	
asciiToTileType entry
		and #$7f
		asl a
		phy
		tay
		lda asciiToTileTypeTable,y
		ply
		rtl
		

tileTypeToAscii entry
		lsr a
		lsr a
		phy
		tay
		lda tileTypeToAsciiTable,y
		ply
		and #$7f
		rtl
	
	
asciiToTileTypeTable anop
		dc i2'TILE_EMPTY'		; 0
		dc i2'TILE_EMPTY'		; 1
		dc i2'TILE_EMPTY'		; 2
		dc i2'TILE_EMPTY'		; 3
		dc i2'TILE_EMPTY'		; 4
		dc i2'TILE_EMPTY'		; 5
		dc i2'TILE_EMPTY'		; 6
		dc i2'TILE_EMPTY'		; 7
		dc i2'TILE_EMPTY'		; 8
		dc i2'TILE_EMPTY'		; 9
		dc i2'TILE_EMPTY'		; 10
		dc i2'TILE_EMPTY'		; 11
		dc i2'TILE_EMPTY'		; 12
		dc i2'TILE_EMPTY'		; 13
		dc i2'TILE_EMPTY'		; 14
		dc i2'TILE_EMPTY'		; 15
		dc i2'TILE_EMPTY'		; 16
		dc i2'TILE_EMPTY'		; 17
		dc i2'TILE_EMPTY'		; 18
		dc i2'TILE_EMPTY'		; 19
		dc i2'TILE_EMPTY'		; 20
		dc i2'TILE_EMPTY'		; 21
		dc i2'TILE_EMPTY'		; 22
		dc i2'TILE_EMPTY'		; 23
		dc i2'TILE_EMPTY'		; 24
		dc i2'TILE_EMPTY'		; 25
		dc i2'TILE_EMPTY'		; 26
		dc i2'TILE_EMPTY'		; 27
		dc i2'TILE_EMPTY'		; 28
		dc i2'TILE_EMPTY'		; 29
		dc i2'TILE_EMPTY'		; 30
		dc i2'TILE_EMPTY'		; 31
		dc i2'TILE_EMPTY'		; 32
		dc i2'TILE_EMPTY'		; 33
		dc i2'TILE_EMPTY'		; 34
		dc i2'TILE_EMPTY'		; 35
		dc i2'TILE_EMPTY'		; 36
		dc i2'TILE_EMPTY'		; 37
		dc i2'TILE_EMPTY'		; 38
		dc i2'TILE_EMPTY'		; 39
		dc i2'TILE_EMPTY'		; 40
		dc i2'TILE_EMPTY'		; 41
		dc i2'TILE_EMPTY'		; 42
		dc i2'TILE_EMPTY'		; 43
		dc i2'TILE_EMPTY'		; 44
		dc i2'TILE_EMPTY'		; 45
		dc i2'TILE_SYMBOL_DOT' ; 46
		dc i2'TILE_EMPTY'		; 47
		dc i2'TILE_NUMBER_0'	; 48
		dc i2'TILE_NUMBER_1'	; 49
		dc i2'TILE_NUMBER_2'	; 50
		dc i2'TILE_NUMBER_3'	; 51
		dc i2'TILE_NUMBER_4'	; 52
		dc i2'TILE_NUMBER_5'	; 53
		dc i2'TILE_NUMBER_6'	; 54
		dc i2'TILE_NUMBER_7'	; 55
		dc i2'TILE_NUMBER_8'	; 56
		dc i2'TILE_NUMBER_9'	; 57
		dc i2'TILE_SYMBOL_COLON' ; 58
		dc i2'TILE_EMPTY'		; 59
		dc i2'TILE_EMPTY'		; 60
		dc i2'TILE_EMPTY'		; 61
		dc i2'TILE_EMPTY'		; 62
		dc i2'TILE_EMPTY'		; 63
		dc i2'TILE_EMPTY'		; 64
		dc i2'TILE_LETTER_A'	; 65
		dc i2'TILE_LETTER_B'	; 66
		dc i2'TILE_LETTER_C'	; 67
		dc i2'TILE_LETTER_D'	; 68
		dc i2'TILE_LETTER_E'	; 69
		dc i2'TILE_LETTER_F'	; 70
		dc i2'TILE_LETTER_G'	; 71
		dc i2'TILE_LETTER_H'	; 72
		dc i2'TILE_LETTER_I'	; 73
		dc i2'TILE_LETTER_J'	; 74
		dc i2'TILE_LETTER_K'	; 75
		dc i2'TILE_LETTER_L'	; 76
		dc i2'TILE_LETTER_M'	; 77
		dc i2'TILE_LETTER_N'	; 78
		dc i2'TILE_LETTER_O'	; 79
		dc i2'TILE_LETTER_P'	; 80
		dc i2'TILE_LETTER_Q'	; 81
		dc i2'TILE_LETTER_R'	; 82
		dc i2'TILE_LETTER_S'	; 83
		dc i2'TILE_LETTER_T'	; 84
		dc i2'TILE_LETTER_U'	; 85
		dc i2'TILE_LETTER_V'	; 86
		dc i2'TILE_LETTER_W'	; 87
		dc i2'TILE_LETTER_X'	; 88
		dc i2'TILE_LETTER_Y'	; 89
		dc i2'TILE_LETTER_Z'	; 90
		dc i2'TILE_EMPTY'		; 91
		dc i2'TILE_EMPTY'		; 92
		dc i2'TILE_EMPTY'		; 93
		dc i2'TILE_EMPTY'		; 94
		dc i2'TILE_EMPTY'		; 95
		dc i2'TILE_EMPTY'		; 96
		dc i2'TILE_LETTER_A'	; 97
		dc i2'TILE_LETTER_B'	; 98
		dc i2'TILE_LETTER_C'	; 99
		dc i2'TILE_LETTER_D'	; 100
		dc i2'TILE_LETTER_E'	; 101
		dc i2'TILE_LETTER_F'	; 102
		dc i2'TILE_LETTER_G'	; 103
		dc i2'TILE_LETTER_H'	; 104
		dc i2'TILE_LETTER_I'	; 105
		dc i2'TILE_LETTER_J'	; 106
		dc i2'TILE_LETTER_K'	; 107
		dc i2'TILE_LETTER_L'	; 108
		dc i2'TILE_LETTER_M'	; 109
		dc i2'TILE_LETTER_N'	; 110
		dc i2'TILE_LETTER_O'	; 111
		dc i2'TILE_LETTER_P'	; 112
		dc i2'TILE_LETTER_Q'	; 113
		dc i2'TILE_LETTER_R'	; 114
		dc i2'TILE_LETTER_S'	; 115
		dc i2'TILE_LETTER_T'	; 116
		dc i2'TILE_LETTER_U'	; 117
		dc i2'TILE_LETTER_V'	; 118
		dc i2'TILE_LETTER_W'	; 119
		dc i2'TILE_LETTER_X'	; 120
		dc i2'TILE_LETTER_Y'	; 121
		dc i2'TILE_LETTER_Z'	; 122
		dc i2'TILE_EMPTY'		; 123
		dc i2'TILE_EMPTY'		; 124
		dc i2'TILE_EMPTY'		; 125
		dc i2'TILE_EMPTY'		; 126
		dc i2'TILE_EMPTY'		; 127
		
tileTypeToAsciiTable anop
		dc c' '		; TILE_EMPTY
		dc c' '		; TILE_MUSHROOM1
		dc c' '		; TILE_MUSHROOM2
		dc c' '		; TILE_MUSHROOM3
		dc c' '		; TILE_MUSHROOM4
		dc c' '		; TILE_SYMBOL_C
		dc c' '		; TILE_SYMBOL_P
		dc c'.'		; TILE_SYMBOL_DOT
		dc c':'		; TILE_SYMBOL_COLON
		dc c' '		; TILE_POISON_MUSHROOM1
		dc c' '		; TILE_POISON_MUSHROOM2
		dc c' '		; TILE_POISON_MUSHROOM3
		dc c' '		; TILE_POISON_MUSHROOM4
		dc c'A'		; TILE_LETTER_A
		dc c'B'		; TILE_LETTER_B
		dc c'C'		; TILE_LETTER_C
		dc c'D'		; TILE_LETTER_D
		dc c'E'		; TILE_LETTER_E
		dc c'F'		; TILE_LETTER_F
		dc c'G'		; TILE_LETTER_G
		dc c'H'		; TILE_LETTER_H
		dc c'I'		; TILE_LETTER_I
		dc c'J'		; TILE_LETTER_J
		dc c'K'		; TILE_LETTER_K
		dc c'L'		; TILE_LETTER_L
		dc c'M'		; TILE_LETTER_M
		dc c'N'		; TILE_LETTER_N
		dc c'O'		; TILE_LETTER_O
		dc c'P'		; TILE_LETTER_P
		dc c'Q'		; TILE_LETTER_Q
		dc c'R'		; TILE_LETTER_R
		dc c'S'		; TILE_LETTER_S
		dc c'T'		; TILE_LETTER_T
		dc c'U'		; TILE_LETTER_U
		dc c'V'		; TILE_LETTER_V
		dc c'W'		; TILE_LETTER_W
		dc c'X'		; TILE_LETTER_X
		dc c'Y'		; TILE_LETTER_Y
		dc c'Z'		; TILE_LETTER_Z
		dc c'0'		; TILE_NUMBER_0
		dc c'1'		; TILE_NUMBER_1
		dc c'2'		; TILE_NUMBER_2
		dc c'3'		; TILE_NUMBER_3
		dc c'4'		; TILE_NUMBER_4
		dc c'5'		; TILE_NUMBER_5
		dc c'6'		; TILE_NUMBER_6
		dc c'7'		; TILE_NUMBER_7
		dc c'8'		; TILE_NUMBER_8
		dc c'9'		; TILE_NUMBER_9
		dc c' '		; TILE_SOLID1
		dc c' '		; TILE_SOLID2
		dc c' '		; TILE_SOLID3
		dc c' '		; TILE_PLAYER
		dc c'u'		; TILE_LETTER_WHITE_U
		dc c'G'		; TILE_LETTER_GREEN_G
		dc c'S'		; TILE_LETTER_GREEN S
		
        end
