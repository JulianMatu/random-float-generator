;Author name: Julian Matuszewski
;Author email: julianmatuszewski@csu.fullerton.edu
;Class: CPSC 240-7

;external C/C++ library functions
extern printf

;define itself
global show_array

;declare initialized arrays (cstrings)
segment .data
sci_format: db "%-18.13e", 0                                 ;print floats in scientific notation
hex_format: db "0x%016lx", 0                                 ;print bits in hexadecimal format
format: db "%s", 0 
header: db "IEEE754                Scientific Decimal", 10, 0  ;The header to the display, with enough spaces so that it looks nice
row: db "0x%016lx     %-18.13e", 10, 0                      ;The appropiate row
newline: db 10, 0

;declare uninitialized arrays
segment .bss


;instructions including functions
segment .text
    show_array:
        ;Prolog ===== Insurance for any caller of this assembly module ========================================================
        ;Any future program calling this module that the data in the caller's GPRs will not be modified.
        push rbp
        mov  rbp,rsp
        push rdi                                                    ;Backup rdi
        push rsi                                                    ;Backup rsi
        push rdx                                                    ;Backup rdx
        push rcx                                                    ;Backup rcx
        push r8                                                     ;Backup r8
        push r9                                                     ;Backup r9
        push r10                                                    ;Backup r10
        push r11                                                    ;Backup r11
        push r12                                                    ;Backup r12
        push r13                                                    ;Backup r13
        push r14                                                    ;Backup r14
        push r15                                                    ;Backup r15
        push rbx                                                    ;Backup rbx
        pushf

        ;operation blocks
        mov r12, rdi                ;r12 is the size
        mov r13, rsi                ;r13 is the pointer to the array

        ;Prints the header first
        mov rax, 0
        mov rdi, format
        mov rsi, header
        call printf

        ;Using a loop, print out the contents of the array in hex and then in scientific notation decimal
        mov r14, 0                  ;r14 will be used as the loop counter
        beginLoop:
            cmp r14, r12            ;compare if the counter has reached the size
            je exitLoop             ;exit loop if the above is true

            ;print row
            push qword 0
            mov rax, 1                  ;1 floating point input
            mov rdi, row
            mov rsi, [r13 + 8*r14]      ;8 byte offset so that it reads the next element in the array
            movsd xmm0, [r13 + 8*r14]   ;passing using xmm register because the formatting would not work otherwise
            call printf
            pop rax

            inc r14
            jmp beginLoop
        
        exitLoop:

        ;Prints newline at the end
        mov rax, 0
        mov rdi, format
        mov rsi, newline
        call printf

        ;===== Restore original values to integer registers ===================================================================
        popf                                                        ;Restore rflags
        pop rbx                                                     ;Restore rbx
        pop r15                                                     ;Restore r15
        pop r14                                                     ;Restore r14
        pop r13                                                     ;Restore r13
        pop r12                                                     ;Restore r12
        pop r11                                                     ;Restore r11
        pop r10                                                     ;Restore r10
        pop r9                                                      ;Restore r9
        pop r8                                                      ;Restore r8
        pop rcx                                                     ;Restore rcx
        pop rdx                                                     ;Restore rdx
        pop rsi                                                     ;Restore rsi
        pop rdi                                                     ;Restore rdi
        pop rbp                                                     ;Restore rbp

ret