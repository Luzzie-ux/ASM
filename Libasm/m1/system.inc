; ------------------- ;
; SYSTEM CALLS HEADER ;
; ------------------- ;

%ifndef SYSTEM_INC
    %define SYSTEM_INC

    %define stdin 0
    %define stdout 1
    %define stderr 2

    %define read 0
    %define write 1
    %define open 2
    %define close 3
    %define mmap 9
    %define munmap 11
    %define mremap 25
    %define exit 60

    %define endl 0xA
    %define null 0x0

    %macro sysread 3
        mov rdi, %1
        lea rsi, [rel %2]
        mov rdx, %3
        mov rax, read
        syscall
    %endmacro

    %macro syswrite 3
        mov rdi, %1
        lea rsi, [rel %2]
        mov rdx, %3
        mov rax, write
        syscall
    %endmacro

    %macro sysexit 1
        mov rdi, %1
        mov rax, exit
        syscall
    %endmacro

%endif