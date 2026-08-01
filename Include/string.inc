; -------------------------------- ;
;  String & String methods Header  ;
; -------------------------------- ;

%include "bool.inc"

%ifndef STRING_INC
    %define STRING_INC

    global _strlen, _strcpy, _strcat, _strcmp

    _strlen:
        xor rdx, rdx
        cmp rdi, NULL
            jz str_done
        .strlen_loop:
            cmp byte [rdi + rdx], NULL
                je str_done
            inc rdx
            jmp .strlen_loop
    
    _strcpy:

    _strcat:

    _strcmp:

    _strtol:

    _strdup:

    _substr:

    _strjoin:

    str_done:
        mov rax, rdx
        ret

%endif