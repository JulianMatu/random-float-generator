;Author name: Julian Matuszewski
;Author email: julianmatuszewski@csu.fullerton.edu
;Class: CPSC 240-7

;define itself
global isnan

;declare initialized arrays (cstrings)
segment .data

;declare uninitialized arrays
segment .bss

;instructions including functions
segment .text
    isnan:
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
        ;copy array 
        mov r12, rdi		;copy num into r12
        shl r12, 1			;shift r12 one bit (overwrite signed bit and add one zero to the end of the mantissa)
        shr r12, 53			;now the 11 bits are on the far right side (53 zeros, 11 exp bits)
        cmp r12, 2047		;check if r12 has 11111111111 | if equal r12 is nan
        je nan
        mov rax, 0			;if not NaN, send false (0)
        jmp done
        
        nan:
        mov rax, 1			;found NaN, send true (1)
        
        done:

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