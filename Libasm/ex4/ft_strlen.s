; --------- ;
; FT_STRLEN ;
; --------- ;

global ft_strlen

section .text

; long ft_strlen(const char *s)
; Counts how many characters composes a
; a null terminated string
ft_strlen:
    xor rax, rax
    .loop:
        cmp byte [rdi + rax], 0x0
        je .return
        inc rax
        jmp .loop
    .return:
        ret