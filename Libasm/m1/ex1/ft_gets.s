; -------- ;
; ft_gets  ;
; -------- ;

section .text

global ft_gets

; ssize_t ft_gets(char buf[size], ssize_t size);
; rax = input bytes, rdi = dest buf, rsi = dest size
ft_gets:
    push rbp
    mov rbp, rsp
    sub rsp, 272             ; 256 buffer + 16 bytes storage

    mov [rbp-8], rdi         ; save user buffer
    mov [rbp-16], rsi        ; save buffer size
    
    ; sys_read(fd=0, intenal buffer, 256)
    mov rdi, 0               ; fd
    lea rsi, [rbp-272]       ; internal buffer
    mov rdx, 256             ; count
    
    ; read
    mov rax, 0               ; id
    syscall                  ; rax holds read_bytes
    
    ; terminate internal buffer
    lea rsi, [rbp-272]       ; load ibuf into rsi
    mov byte [rsi+rax], 0    ; add \0

    ; copy interal content to user buffer
    mov rcx, rax
    cmp rcx, [rbp-16]        ; cmp input size to user size
        jb .copy             ; copy input_size bytes into buf
        jae .move
    

.copy:
    lea rsi, [rbp-272]       ; [source]
    mov rdi, [rbp-8]         ; [destination]
    rep movsb                ; rcx, rsi, rdi

    mov rdi, [rbp-8]         ; load ubuf into rdi
    mov byte [rdi+rax], 0    ; null terminate it

    leave                    ; destroy the stack
    ret                      ; Return bytes read

.move:
    mov rdx, [rbp-16]
    mov rcx, [rbp-16]
    lea rsi, [rbp-272]
    mov rdi, [rbp-8]
    rep movsb

    mov rdi, [rbp-8]
    mov byte [rdi+rdx-1], 0

    leave 
    ret