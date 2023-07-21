%ifndef _SCR_ASM
%define _SCR_ASM

SCR_WIDTH EQU 80
SCR_HEIGHT EQU 25

SCR_COL DB 0x0A


SCR_PRINT:
    MOV AH, 0xE
SCR_PRINT_LOOP:
    LODSB
    CMP AL, 0
    JZ SCR_PRINT_END
    CALL SCR_PUTC
    JMP SCR_PRINT_LOOP
SCR_PRINT_END:
    RET


SCR_PUTC:
    PUSHA
    MOV AH, 0xE
    CMP AL, 13
    JNE SCR_PUTC_NL_END
    INT 0x10
    MOV AL, 10
SCR_PUTC_NL_END:
    CMP AL, 8
    JNE SCR_PUTC_BP_END
    INT 0x10
    MOV AL, ' '
    INT 0x10
    MOV AL, 8
SCR_PUTC_BP_END:
    INT 0x10
    POPA
    RET

; clear screen
SCR_CLS:
    PUSHA
    MOV BH, [SCR_COL]
    ; scrol screen
    MOV AH, 0x07
    MOV AL, 0x00
    MOV CH, 0x00
    MOV CL, 0x00
    MOV DH, 24
    MOV DL, 79
    INT 0x10
    ; move cursor to 0,0
    MOV AH, 0x02
    MOV BH, 0
    MOV DH, 0
    MOV DL, 0
    INT 0x10
    ; return
    POPA
    RET

SCR_SET_COL:
    PUSHA
    MOV [SCR_COL], BH
    POPA
    RET
    

%endif  ; _SCR_ASM
