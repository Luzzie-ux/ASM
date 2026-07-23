; -----------------
; Hello world program:
; -----------------

global  _start

section .data
    str: db "Hello, World!", 10     ; or 0xA
    str_size equ $ - str

section .text
_start: 
    ; set up arguments for Print function:
    mov rdi, 1          ; rdi - File descriptor (1 for stdout)
    lea rsi, [rel str]  ; rsi - Pointer to the str we will print
    mov rdx, str_size   ; rdx - Length of the string
    call .print         ; jumping to print
    
    ; set up argument for Exit function:
    xor rdi, rdi        ; rdi - Exit code 0
    jmp _exit           ; jumping to print

    ; Print function:
    .print:
        mov rax, 1      ; requesting sys_write
        syscall         ; sys_write with rsi value
        ret             ; Return: None

    ; Exit function:
    _exit:
        mov rax, 60     ; requesting sys_exit
        syscall         ; sys_exit with rdi value
