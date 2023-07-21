%ifndef _BSOD_ASM
%define _BSOD_ASM

%INCLUDE "SCR.ASM"

KPANIC_MSG  DB 'KERNEL PANIC', 13,
            DB 13, 13, 13, 13, 'mustard is behind u', 13,
            DB 13, 13, 13, 13, 'sus', 0

BSOD:
    MOV BH, 0x1F
    CALL SCR_SET_COL
    CALL SCR_CLS
    ; dsable cursor
    MOV AH, 0x01
    MOV CH, 0x3F
    INT 0x10
    MOV SI, KPANIC_MSG
    CALL SCR_PRINT
    CLI
    HLT

%endif  ; _BSOD_ASM
