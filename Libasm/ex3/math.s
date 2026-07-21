; ------------ ;
; Math program ;
; ------------ ;

section .data
formatStr: db "Integer is: %d", 10, 0

section .text
    global main
    extern printf

main:
    mov rdi, 5
    mov rsi, 6
    call add_n
    call ft_printf

    mov rdi, 7
    mov rsi, 9
    call sub_n
    call ft_printf
    
    mov rdi, 4
    mov rsi, 2
    call div_n
    call ft_printf
    
    mov rdi, 2
    mov rsi, 3
    call mul_n
    call ft_printf
    
    mov rdi, 1
    call inc_n
    call ft_printf
    
    mov rdi, 9
    call dec_n
    call ft_printf
    
    ret

; int add_n(int x, int y)
; rax = return, rdi = x, rsi = y
add_n:
    xor rax, rax
    add rax, rdi
    add rax, rsi
    ret

; int sub_(int x, int y)
; rax = return, rdi = x, rsi = y
sub_n:
    xor rax, rax
    sub rdi, rsi
    mov rax, rdi
    ret

; float div_n(int x, int y)
; rax = return, rdi = x, rsi = y
div_n:
    mov rax, rdi
    xor rdx, rdx
    div rsi
    ret

; float mul_n(int x, int y)
; rax = return, rdi = x, rsi = y
mul_n:
    mov rax, rdi
    xor rdx, rdx
    mul rsi
    ret

; int inc_n(int x)
; rax = return, rdi = x
inc_n:
    xor rax, rax
    inc rdi
    mov rax, rdi
    ret

; int dec_n(int x)
; rax = return, rdi = x
dec_n:
    xor rax, rax
    dec rdi
    mov rax, rdi
    ret

ft_printf:
    push rbp
    mov rbp, rsp
    mov rdi, formatStr
    mov rsi, rax
    xor rax, rax
    call printf
    pop rbp
    ret
