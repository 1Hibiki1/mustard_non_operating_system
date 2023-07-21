ORG 0x7C00

SECTION .TEXT
    ; Load kernel
    MOV BX, 0x8000   ; Destination address
    MOV AH, 0x02
    MOV AL, 5        ; num sectors
    MOV CH, 0        ; Cylinder number
    MOV CL, 2        ; Sector number
    MOV DH, 0        ; Head number
    INT 0x13

    JMP 0x8000  ; jump to kernel

TIMES 510-($-$$) DB 0
DW 0xAA55
