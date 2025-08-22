REM Graphics demo for ZX Spectrum
REM Shows basic graphics capabilities

BORDER 0
CLS

REM Draw some lines
FOR i = 0 TO 255 STEP 8
    PLOT i, 50
    DRAW 0, 100
NEXT i

REM Draw a circle approximation
LET cx = 128
LET cy = 100
FOR angle = 0 TO 360 STEP 10
    LET x = cx + 40 * COS(angle * PI / 180)
    LET y = cy + 40 * SIN(angle * PI / 180)
    PLOT x, y
NEXT angle

PRINT AT 0,0;"Graphics Demo"
PRINT AT 1,0;"Press any key to continue"
PAUSE 0