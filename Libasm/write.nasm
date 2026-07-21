section .data
    txt:

section .text
    global  write

write:
    ; function stack frame
    push rbp            ; pushing base pointer into the top
    mov rbp, rsp        ; moving stack pointer into the base pointer
    ; syscall write arguments
    mov rax, 1          ;sys_write ID
    mov rdi, 1          ; sys_write int fd (stdout)
    lea rsi, [rel txt]  ; sys_write void* buf[count]
    mov rdx, size       ; sys_write int count
    syscall             ; executing sys_write
    ; destroying stack frame
    pop rbp             ; popping rbp from top
    ret                 ; return: None
