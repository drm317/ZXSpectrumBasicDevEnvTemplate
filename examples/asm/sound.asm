; Sound demo for ZX Spectrum in Z80 Assembly
; Demonstrates the beeper sound generation

	DEVICE ZXSPECTRUM48

	ORG 0x8000

start:
	; Play a series of beeps with different frequencies
	
	; High frequency beep
	LD HL, 100		; Duration (lower = longer)
	LD DE, 10		; Pitch (lower = higher pitch)
	CALL beep

	; Medium frequency beep
	LD HL, 100
	LD DE, 50
	CALL beep

	; Low frequency beep
	LD HL, 100
	LD DE, 150
	CALL beep

	; Play a simple tune
	CALL play_tune

	RET

beep:
	; Generate beep with duration HL and pitch DE
	CALL 0x03B5		; ROM beeper routine
	RET

play_tune:
	; Play a simple ascending scale
	LD B, 8			; Number of notes
	LD DE, 200		; Starting pitch

tune_loop:
	PUSH BC
	PUSH DE
	LD HL, 50		; Note duration
	CALL beep
	POP DE
	POP BC
	
	; Decrease pitch for higher note
	LD A, E
	SUB 20
	LD E, A
	JR NC, no_carry
	DEC D
no_carry:
	
	; Small delay between notes
	LD HL, 5000
delay_loop:
	DEC HL
	LD A, H
	OR L
	JR NZ, delay_loop
	
	DJNZ tune_loop
	RET

	SAVEBIN "sound.bin", start, $ - start