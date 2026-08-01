; --------------------- ;
;  System Calls Header  ;
; --------------------- ;

%ifndef SYSTEM_INC
    %define SYSTEM_INC

    ; I/O file descriptors
    %define SIN  0
    %define SOUT 1
    %define SERR 2

    ; Syscalls id
    %define SREAD 0
    %define SWRITE 1
    %define SOPEN 2 
    %define SCLOSE 3
    %define SEXIT 60
    
    ; Exit code
    %define ERR -1

    global _read, _write, _exit, _open, _close

    _read:
        mov rax, SREAD
        syscall
        mov rdx, rax
        cmp rdx, ERR
            jle syserror
        jg sysend

    _write:
        cmp [rsi], 0
            jz syserror
        mov rax, SWRITE
        syscall
        mov rdx, rax
        cmp rdx, ERR
            jle syserror
        jg sysend

    _open:
        mov rax, SOPEN
        syscall
    _close:
        mov rax, SCLOSE
        syscall

    _exit:
        mov rax, SEXIT
        syscall

    syserror:
        mov rax, ERR
        ret
    
    sysend:
        mov rax, rdx
        ret

%endif