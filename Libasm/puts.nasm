; -----------------
; Puts program:
; -----------------

section .text

    global  _start

_start:
    call ft_puts
    call exit

; Ft_puts function:
ft_puts:
                        ; set up arguments for ft_puts function:
    mov rdi, 1          ; rdi - File descriptor (1 for stdout)
    lea rsi, [rel str]  ; rsi - Pointer to the str we will print
    mov rdx, str_size   ; rdx - Length of the string
                        ; function start point
    mov rax, 1          ; requesting sys_write
    syscall             ; sys_write with rsi value
    ret                 ; Return: None

; Exit function:
exit:
                        ; set up argument for exit function
    xor rdi, rdi        ; rdi - Exit code
                        ; function start
    mov rax, 60         ; requesting sys_exit
    syscall             ; sys_exit with rdi value

section .data

str: db "Hello", 10     ; or 0xA
str_size equ $ - str
