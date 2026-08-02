; ------------------------------------------------------- ;
;  Standard Input/Output & File Wrapper for System Calls  ;
; ------------------------------------------------------- ;

%include "system.inc"
%include "string.inc"

%ifndef STDIO_INC
    %define STDIO_INC

    %ifndef STDIN_FRAME
        %define STDIN_FRAME
        
        %macro create_frame 4
            push rbp
            mov rbp, rsp
            push %1
            push %2
            push %3
            sub rsp, %4
        %endmacro

        %macro destroy_frame 4
            add rsp, %1
            pop %2
            pop %3
            pop %4
            pop rbp
        %endmacro
    %endif

    global _stdin, _stdout, _stderr, _stdfr, _stdfw, _stdif, _stdof

    ; standard I/O branch
    
    ; ssize_t _stdin(void *buffer, int size);
    ; The STanDard INput function uses the following registers:
    ;   RAX for the return value
    ;   RDI for the user buffer
    ;   RSI for the user buffer size
    ;   RSP & RBP for the function frame
    ;   RCX for use of the REP Instruction
    ;   RDX for the _read call
    ;   RBX for saving the user buffer
    ;   R8 for saving the user size
    ;   R9 for later restoring the original input size
    ; Of these 10 registers, only the state of RBX, R8 & R9 are saved along side the stack frame, 
    ; by subtracting 2048 bytes from RSP for the internal buffer, allowing only User Size bytes 
    ; of Input to be copied into the User Buffer, truncating if above US, always Null terminating
    ; both buffers. The internal buffer is destroyed after the end of function frame
    _stdin:
        ; rbx, r8, r9 used to save
        ; original user buffer & user size 
        ; create stack_frame:
        create_frame rbx, r8, r9, 2048

        ; save args 1 & 2:
        mov rbx, rdi    ; rdi = user buffer
        mov r8, rsi     ; rsi = user size

        ; load read args:
        mov rdi, SIN
        mov rsi, rsp    ; internal buffer
        mov rdx, 2048   ; internal buffer size
        call _read
        cmp rax, ERR    ; rax holds input size
            jle .stdin_return

        ; terminate internal buffer
        mov r9, rax
        mov byte [rsi+rax], 0

        ; copy from input to buffer
        mov rcx, rax
        cmp rax, r8
            cmovae rcx, r8

        mov rdi, rbx
        rep movsb

        ; check for truncation
        setae al
        movzx eax, al

        sub rdi, rax
        mov byte [rdi], 0

        ; restore original return value
        mov rax, r9

        .stdin_return:
            destroy_frame 2048, r9, r8, rbx
            ret

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