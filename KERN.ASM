ORG 0x8000

; run kernel main function
JMP KMAIN

%INCLUDE "SHEL.ASM"

; kernel entrypoint
KMAIN:
    ; setup stack
    MOV SP, K_STACK_BOTTOM
    MOV BP, SP

    ; start shell
    CALL SHEL_MAIN

    CLI
    HLT


TIMES 1024 DB 0
K_STACK_BOTTOM:
