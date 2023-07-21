%ifndef _SHEL_ASM
%define _SHEL_ASM

%INCLUDE "SCR.ASM"
%INCLUDE "KBD.ASM"
%INCLUDE "STR.ASM"
%INCLUDE "BSOD.ASM"

SHEL_MAX_INP_BUF_SZ equ 512

SHEL_PROMPT DB 'C:\> ', 0
SHEL_INP_BUF TIMES SHEL_MAX_INP_BUF_SZ DB 0

BOOT_MSG    DB 'Welcome to mustard non-operating system!', 13
            DB 'Type <help> for more info.', 13, 13, 0

SHEL_MAIN:
    PUSHA
    ; clear screen
    MOV BH, 0X0F
    CALL SCR_SET_COL
    CALL SCR_CLS
    ; print boot msg
    MOV SI, BOOT_MSG
    CALL SCR_PRINT
SHEL_MAIN_LOOP:
    ; print prompt
    MOV SI, SHEL_PROMPT
    CALL SCR_PRINT
    ; read a line of input
    CALL SHEL_READLINE
    CALL BSOD
    ; loop
    JMP SHEL_MAIN_LOOP
    ; return
    POPA
    RET


SHEL_READLINE:
    PUSHA
    MOV CX, 0
SHEL_READLINE_LOOP:
    ; check if we have read the max number of characters
    CMP CX, SHEL_MAX_INP_BUF_SZ
    JE SHEL_READLINE_END
    ; get keyboard input
    CALL KBD_GETCH
    ; write the read character to screen
    CALL SCR_PUTC
    CMP AL, 8
    JNE SHEL_READLINE_BP
    DEC CX
    JMP SHEL_READLINE_LOOP
SHEL_READLINE_BP:
    ; write to keyboard buffer
    MOV BX, SHEL_INP_BUF
    ADD BX, CX
    MOV [BX], AL
    ; inc counter
    INC CX
    ; end if user typed newline
    CMP AL, 13
    JE SHEL_READLINE_END
    JMP SHEL_READLINE_LOOP
SHEL_READLINE_END:
    MOV BX, SHEL_INP_BUF
    ADD BX, CX
    MOV AL, 0
    MOV [BX], AL
    POPA
    RET

%endif  ; _SHEL_ASM
