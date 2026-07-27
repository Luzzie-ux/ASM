; ------------------- ;
; SYSTEM CALLS HEADER ;
; ------------------- ;

%ifndef SYSTEM_INC  ; if 'system_inc' is not defined:
%define SYSTEM_INC  ; define it with the following definitions:

    %define stdin 0
    %define stdout 1
    %define stderr 2

    %define read_id 0
    %define write_id 1
    %define open_id 2
    %define close_id 3
    %define exit_id 60

    %macro sys_read 3
        mov rdi, %1
        lea rsi, [rel %2]
        mov rdx, %3
        mov rax, read_id
        syscall
    %endmacro

    %macro sys_write 3
        mov rdi, %1
        lea rsi, [rel %2]
        mov rdx, %3
        mov rax, write_id
        syscall
    %endmacro

    %macro sys_open 2-3
        mov rdi, %1
        mov rsi, %2
        mov rdx, %3
        mov rax, open_id
        syscall
    %endmacro

    %macro sys_close 1
        mov rdi, %1
        mov rax, close_id
        syscall
    %endmacro

    %macro sys_exit 1
        mov rdi, %1
        mov rax, exit_id
        syscall
    %endmacro

%endif