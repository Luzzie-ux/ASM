section .text

global ft_write

; ssize_t ft_write(int fd, void *buf, size_t count);
; Requires RDI, RSI and RDX as its arguments to use sys_write.
; RAX will hold the value returned by it, in this case, none
ft_write:
    mov rax, 1          ;sys_write ID
    syscall             ; executing sys_write
    ret                 ; return: None
