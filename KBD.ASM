%ifndef _KBD_ASM
%define _KBD_ASM

KBD_GETCH:
    MOV AH, 0
    INT 0X16
    RET

%endif  ; _KBD_ASM
