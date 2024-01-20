;Author name: Julian Matuszewski
;Author email: julianmatuszewski@csu.fullerton.edu
;Class: CPSC 240-7

;external C/C++ library functions
extern printf
extern scanf
extern stdin
extern fgets
extern strlen

;program modules
extern fill_random_array
extern quickSort                ;Linked C++ implementation using merge sort // not the C qsort
extern show_array
extern normalize
extern isnan

global executive

;numerical consts
INPUT_LEN: equ 256  ;max bytes of name, title, response
MAX_LEN: equ 100    ;maximum length of our randomized array
MIN_LEN: equ 0      ;minimum length of our randomized array

;declare initialized arrays (cstrings)
segment .data
    prompt_name: db "Please enter your name: ", 0
    prompt_title: db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): ", 0

    ;First %s is title, second %s is name
    greeting: db "Nice to meet you %s %s. ", 0
    info: db "This program will generate 64-bit IEEE float numbers.", 10, 0
    prompt_size: db "How many numbers do you want?  Today’s limit is 100 per customer. ", 0
    arr_stored: db "Your numbers have been stored in an array.  Here is that array.", 10, 10, 0
    arr_sorted: db "The array is now being sorted.", 10, 10, 0
    arr_display: db "Here is the updated array.",10, 10, 0
    arr_norm: db "The random numbers will be normalized. Here is the normalized array.", 10, 10, 0
    closing: db "Goodbye. You are welcome any time.", 10, 0
    invalid_input: db "Invalid Input. Try Again.", 10, 0

    ;additional strings
    spc: db " ", 0
    format: db "%s", 0       ;null-terminated c-string
    double_form: db "%lf", 0
    int_form: db "%d", 0

;declare uninitialized arrays
segment .bss
    ;reserve 256 bytes for each variable
    title: resb INPUT_LEN
    name: resb INPUT_LEN
    myarray: resq 100       ;max of 100 doubles

;instructions including functions
segment .text
    executive:
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
        pushf                                                       ;Backup rflags

        ;Operation Blocks:

        ;Display program info
        push qword 0
        mov rax, 0  
        mov rdi, format
        mov rsi, info           ;"This program will generate 64-bit IEEE float numbers.\n"
        call printf
        pop rax

        ;We have to check if the inputted number exceeds our maximum or is negative. If so, ask for them to enter a new number
        InputLoop:  

            ;Ask how big the random array should be
            push qword 0
            mov rax, 0
            mov rdi, format
            mov rsi, prompt_size    ;"How many numbers do you want?  Today’s limit is 100 per customer. "
            call printf
            pop rax

            ;Take user input using scanf to find the correct array size
            mov rax, 0
            mov rdi, int_form
            mov rsi, rsp            ;copy the pointer to the top of the stack into second argument for scanf, so that...
            call scanf              ;the input will be stored on the stack
            pop r8                  ;pop so that the size will be stored in register r8
            
            ;Check Max range
            mov r12, MAX_LEN
            cmp r12, r8             ;CF if r8 > MAX_LEN
            jl InputLoop            ;jmp input loop if CF

            ;Check Min range
            mov r12, MIN_LEN
            cmp r8, r12             ;CF if r8 < MIN_LEN
            jl InputLoop
            ;If input passes min and max range, continue executing program

            jmp InputAccepted

        InvalidInput:

            ;Print that input is invalid
            mov rax, 0
            mov rdi, format
            mov rsi, invalid_input  ;"Invalid Input. Try Again."
            call printf

        jmp InputLoop

        InputAccepted:

        ;Use the fill_random_array module to populate myarray with random floats
        mov rax, 0
        mov rdi, r8
        mov rsi, myarray
        call fill_random_array

        ;Display stored in array
        push qword 0
        mov rax, 0
        mov rdi, format
        mov rsi, arr_stored         ;"Your number have been stored in an array. Here is that array."
        push r8
        call printf
        pop r8
        pop rax

        ;Display unsorted array
        mov rax, 0
        mov rdi, r8                 ;argument 1 is the size of the array
        mov rsi, myarray            ;argument 2 is the pointer to the array
        call show_array

        ;Call qsort to sort array
        mov rax, 0
        mov rdi, myarray            ;argument 1 is the pointer to the array
        mov rsi, r8                 ;argument 2 is the size of the array
        call quickSort              ;void qsort(double* arr, int size)

        ;Display array is being sorted
        push qword 0
        mov rax, 0
        mov rdi, format
        mov rsi, arr_sorted         ;"The array is now being sorted."
        push r8
        call printf
        pop r8
        pop rax

        ;Display array is updated
        push qword 0
        mov rax, 0
        mov rdi, format
        mov rsi, arr_display         ;"Here is the update array."
        push r8
        call printf
        pop r8
        pop rax

        ;Display sorted array
        mov rax, 0
        mov rdi, r8                 ;argument 1 is the size of the array
        mov rsi, myarray            ;argument 2 is the pointer to the array
        call show_array

        ;Normalize Array
        mov rax, 0
        mov rdi, myarray            ;argument 1 is the pointer to the array
        mov rsi, r8                 ;argument 2 is the size of the array
        call normalize

        ;Call qsort to sort array
        mov rax, 0
        mov rdi, myarray            ;argument 1 is the pointer to the array
        mov rsi, r8                 ;argument 2 is the size of the array
        call quickSort              ;void qsort(double* arr, int size)

        ;Display array is normalized
        mov rax, 0
        mov rdi, format
        mov rsi, arr_norm           ;"The random numbers will be normalized. Here is the normalized array."
        push r8
        call printf
        pop r8

        ;Display normalized array
        mov rax, 0
        mov rdi, r8                 ;argument 1 is the size of the array
        mov rsi, myarray            ;argument 2 is the pointer to the array
        call show_array

        ;Goodbye Message
        mov rax, 0
        mov rdi, closing
        mov rsi, title              ;"Goodbye [title]. You are welcome anytime."
        push r8
        call printf
        pop r8

        ;move pointer to array into return register
        mov rax, 0
        push qword 0

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