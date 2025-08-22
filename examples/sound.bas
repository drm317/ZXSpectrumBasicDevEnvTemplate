REM Sound demo for ZX Spectrum
REM Demonstrates beeper sound capabilities

BORDER 4
CLS
PRINT AT 10,5;"Sound Demo"

REM Simple beep
BEEP 0.5, 10

REM Scale
FOR note = 0 TO 12
    BEEP 0.2, note
NEXT note

REM Simple tune
DATA 5,0.3, 7,0.3, 9,0.3, 5,0.3
DATA 5,0.3, 7,0.3, 9,0.3, 5,0.3
DATA 9,0.3, 10,0.3, 12,0.6
DATA 9,0.3, 10,0.3, 12,0.6

FOR i = 1 TO 12
    READ pitch, duration
    BEEP duration, pitch
NEXT i

PRINT AT 15,8;"Tune complete!"
PAUSE 0