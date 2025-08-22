; Hello World program for ZX Spectrum in Z80 Assembly
; Compiled with SjASMPlus or z80asm
; Target: ZX Spectrum 48K

	DEVICE ZXSPECTRUM48

	ORG 0x8000		; Start at 32768

start:
	; Set border color to red
	LD A, 2
	OUT (0xFE), A

	; Clear screen
	CALL 0x0DAF		; ROM clear screen routine

	; Print message
	LD DE, message
	CALL print_string

	; Wait for keypress
	CALL 0x10A8		; ROM wait for key routine

	; Return to BASIC
	RET

print_string:
	; Print null-terminated string pointed to by DE
	LD A, (DE)
	OR A
	RET Z
	RST 0x10		; ROM print character routine
	INC DE
	JR print_string

message:
	DB "Hello from Z80 Assembly!", 0

	SAVEBIN "hello.bin", start, $ - start