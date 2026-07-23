; ---------------------------- ;
; int ft_puts(const char *str) ;
; ---------------------------- ;
global  ft_puts
section .text

; int ft_puts(const char *str);
; The puts function writes to stdout the string passed to it.
; Using RAX for return values, RDI as first argument (const char *).
; And later loading to RSI the value in RDI to call ft_write 
ft_puts:
    call ft_strlen
    cmp rax, 0          ; if after strlen value is zero, ret
        jz .return

    ; arguments for ft_write
    lea rsi, [rdi]      ; const void *buf <- const char *s
    mov rdi, 1          ; int fd
    mov rdx, rax; int count
    call ft_write

    .return:
        ret

    ft_strlen:
        cmp rdi, 0
            je .done
        xor rax, rax
        .loop:
            cmp byte [rdi + rax], 0x0
            je .done
            inc rax
            jmp .loop
        .done:
            mov rax, rdx
            ret

    ft_write:
        mov rax, 1
        syscall
        ret
