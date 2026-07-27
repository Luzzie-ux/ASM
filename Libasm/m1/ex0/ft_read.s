section .text

global ft_read

; ssize_t ft_read(int fd, void *buf, size_t count);
; Requires RDI, RSI and RDX as its arguments to use sys_read.
; RAX will hold value returned by it, in this case, none
ft_read:
    mov rax, 0      ; sys_read ID
    syscall         ; executing sys_read
    ret             ; return: None
