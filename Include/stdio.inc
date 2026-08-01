; ------------------------------------------------------- ;
;  Standard Input/Output & File Wrapper for System Calls  ;
; ------------------------------------------------------- ;

%include "system.inc"
%include "string.inc"

%ifndef STDIO_INC
    %define STDIO_INC

    global _stdin, _stdout, _stderr, _stdfr, _stdfw, _stdif, _stdof

    ; standard I/O branch
    _stdin:
        call _read
        jmp stdio_return
    
    _stdout:
        call _strlen
        cmp rax, NULL
            jz stdio_return
        
        lea rsi, [rdi]
        mov rdi, SOUT
        mov rdx, rax
        call _write
        jmp stdio_return

    _stderr:
        call _strlen
        cmp rax, NULL
            jz stdio_return
        
        lea rsi, [rdi]
        mov rdi, SERR
        mov rdx, rax
        call _write
        jmp stdio_return
    
    ; standard files & file I/O branch
    _stdfr:
    _stdfw:

    ; standard I/O format branch
    _stdif:
    _stdof:

    stdio_return:
        mov rax, rdx
        ret

%endif