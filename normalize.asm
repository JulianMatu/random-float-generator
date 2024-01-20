;Author name: Julian Matuszewski
;Author email: julianmatuszewski@csu.fullerton.edu
;Class: CPSC 240-7

global normalize

;declare initialized arrays (cstrings)
segment .data

;declare uninitialized arrays
segment .bss

;instructions including functions
segment .text
    normalize:
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
        ;copy arguments into registers
        mov r12, rdi		        ;r12 is the array
        mov r13, rsi		        ;r13 is the size
        mov r14, 0			        ;r14 is the index
        mov rcx, 1023		        ;rcx is 0x3FF
        shl rcx, 52			        ;shift to the left 52, so that rcx is in the exponential part of a IEEE754 number
        
        ;start loop that will normalize each float in the array
        begin_loop:
            cmp r14, r13            ;if the last element in the array has been indexed
            jge done                ;jump to the end of the function
            
            mov rdx, [r12 + 8*r14]	;move array element at index r14 to rdx
            shl rdx, 12				;shift to the left 12 bits to eliminate the exponential bits
            shr rdx, 12				;shift to the right 12 bits to move the significant bits back to the least significant digits
            or rdx, rcx				;rdx = rdx or rcx | bitwise or will replace zero bits with nonzero bits
            mov [r12 + 8*r14], rdx	;put back into array
            inc r14					;increment index r14 by one
            jmp begin_loop
        
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