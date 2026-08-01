ft_gets.s

section .text

global ft_gets


ft_gets:
    call ft_read
    mov rsi[rax - 1], 0x0

ft_read:
    mov rax, 0
    syscall
    ret