section .text

global ft_write

; int ft_write(int fd, void *buf, int count)
ft_write:
    ; syscall sys_write arguments
    ; rdi = fd rsi = buf, rdx = count
    mov rax, 1          ;sys_write ID
    syscall             ; executing sys_write
    ret                 ; return: None
