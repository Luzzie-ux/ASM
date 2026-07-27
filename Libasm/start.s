global _start
%include "system.inc"

section .bss
    buffer resb 64

section .data
    msg: db "Hello, World!", 10, 0
    size equ $ - msg
section .text
_start:
    sys_read stdin, buffer, 64

    sys_write stdout, msg, size

    sys_exit 0