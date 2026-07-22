; --------- ;
; FT_STRLEN ;
; --------- ;

global ft_strlen

section .text

; long ft_strlen(const char *s)
; Counts how many characters composes a null terminated string.
; If a void ptr is passed, it will return 0
ft_strlen:
    xor rax, rax    ;zero outs rax
    cmp rdi, 0      ; tests for a NULL value
    je .return
    .loop:
        cmp byte [rdi + rax], 0x0    ;looking for the end of the string
        je .return                   ; if \0 then return
        inc rax                      ; rax + 1 if not
        jmp .loop                    ; go back to start of the loop
    .return:
        ret                          ; return point