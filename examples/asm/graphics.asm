; Graphics demo for ZX Spectrum in Z80 Assembly
; Demonstrates pixel plotting and line drawing

	DEVICE ZXSPECTRUM48

	ORG 0x8000

start:
	; Set border to blue
	LD A, 1
	OUT (0xFE), A

	; Clear screen
	CALL 0x0DAF

	; Draw some pixels
	LD B, 100		; X coordinate
	LD C, 100		; Y coordinate
	CALL plot_pixel

	LD B, 120
	LD C, 100
	CALL plot_pixel

	LD B, 110
	LD C, 80
	CALL plot_pixel

	; Draw a simple line
	LD B, 50		; Start X
	LD C, 150		; Start Y
	LD D, 200		; End X
	LD E, 50		; End Y
	CALL draw_line

	; Wait for key
	CALL 0x10A8
	RET

plot_pixel:
	; Plot pixel at coordinates B,C
	; Uses ROM PLOT routine
	PUSH BC
	LD A, B
	LD B, C
	LD C, A
	CALL 0x22AA		; ROM PLOT routine
	POP BC
	RET

draw_line:
	; Draw line from B,C to D,E
	; Simple Bresenham-like algorithm
	PUSH BC
	PUSH DE
	
	; Set starting point
	LD A, B
	LD B, C
	LD C, A
	CALL 0x22AA		; ROM PLOT routine
	
	; Set ending point
	POP DE
	POP BC
	LD A, D
	LD D, E
	LD E, A
	CALL 0x2477		; ROM DRAW routine
	RET

	SAVEBIN "graphics.bin", start, $ - start