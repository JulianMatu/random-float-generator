;Author name: Julian Matuszewski
;Author email: julianmatuszewski@csu.fullerton.edu
;Class: CPSC 240-7

;external C/C++ library functions
extern isnan

;define itself
global fill_random_array

;declare initialized arrays (cstrings)
segment .data

;declare uninitialized arrays
segment .bss

;instructions including functions
segment .text
    fill_random_array:
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

        ;Operation Blocks:
        mov r14, rdi            ;1st argument is the size of the array
        mov r8, rsi            ;2nd argument is the pointer to the array
        
        ;to generate n random qwords, where n = the first parameter
        ;for i = 0 until n, inc:
        ;   use rdrand to generate 64 random bits
        ;   store random number in array
        mov r15, 0          ;r15 is n
        mov r9, 1           ;r9 is "true"

        beginLoop:
            cmp r15, r14                ;sets ZF flag to 1 if r15 = n
            je exitLoop                 ;jump to exit if ZF flag = 1

            rdrand r12                  ;generate random number and put into r12

            ;before putting into array, check if r12 is NaN
            mov rdi, r12
            call isnan
            
            cmp r9, rax                 ;sets ZF flag to 1 if rax = 1 as in r12 is nan
            je beginLoop                ;skip iterating and do not add to array, instead generate a new number until not nan

            mov [r8 + 8*r15], r12       ;copy rand into index r15, must multiply by 8 so that it is shifted 8 bytes over (64 bit float)

            inc r15                     ;increment r15 counter by one
            jmp beginLoop               ;back to start of loop
        exitLoop:

        
        ;put return in correct register
        

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