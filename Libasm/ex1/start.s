; -----------------
; Hello world program:
; -----------------

global  _start

section .data

str: db "Hello, World!", 10     ; or 0xA
str_size equ $ - str

section .text

_start:
                        ; _START POINT  
                        ; set up arguments for Print function:
    mov rdi, 1          ; rdi - File descriptor (1 for stdout)
    lea rsi, [rel str]  ; rsi - Pointer to the str we will print
    mov rdx, str_size   ; rdx - Length of the string
    call Print
                        ; set up argument for Exit function:
    xor rdi, rdi        ; rdi - Exit code
    call exit

; Print function:
print:
                        ; function start point
    push rbp            ; rbp - Base Pointer
    mov rbp, rsp        ; rsp - Stack Pointer
    mov rax, 1          ; requesting sys_write
    syscall             ; sys_write with rsi value
    pop rbp             ; destroying base pointer
    ret                 ; Return: None

; Exit function:
exit:
                        ; function start point
    mov rax, 60         ; requesting sys_exit
    syscall             ; sys_exit with rdi value
