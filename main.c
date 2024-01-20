//****************************************************************************************************************************
//Program name: "Non-deterministic Random Numbers". This program demonstrates the use of non-deterministic random numbers.   *
//The program creates an array of a given size and populates it with random numbers which is acheived by measuring the       *
//entropy of gases in the CPU. This program if the IEEE754 numbers are NaN's and will even sort them. Additionally, it       *
//will normalize the numbers in the array to fit between 1 inclusive and 2 exclusive.                                        *
//Copyright (C) 2023 Julian Matuszewski.                                                                                     *
//                                                                                                                           *
//This file is part of the software program "Non-deterministic Random Numbers".                                              *
//"Non-deterministic Random Numbers" is free software: you can redistribute it and/or modify it under the terms of the       *
//GNU General Public License version 3 as published by the Free Software Foundation.                                         *
//Non-deterministic Random Numbers is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;              *
//without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public      *
//License for more details. A copy of the GNU General Public License v3 is available here:  <https://gnu.org/licenses/>.     *
//****************************************************************************************************************************

//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
// Author name: Julian Matuszewski
// Author email: julianmatuszewski@csu.fullerton.edu
// Class: CPSC 240-7
//
//Program information
//  Program name: Non-deterministic Random Numbers
//  Programming languages: One modules in C and five modules in X86
//  Date program began: 2023-Feb-29
//  Date of last update: 2023-March-12
//  Date comments upgraded: 2023-March-12
//  Files in this program: main.c, executive.asm, fill_random_array.asm, quick_sort.asm, show_array.asm, r.sh
// Status: Unfinished
//  References consulted: Professor Holliday's lecture, Professor Holliday's Examples, Johnson Tong (SI Session)
//  Future upgrade possible: none
//
//Purpose
//  This program will create an array of random numbers given a size input from the user. This array will be populated with non-deter
//  ministic random numbers which are guaranteed to be real numbers. This array is then sorted, normalized to between 1 and 2 and then
//  it is sorted again. Each time it will display the new array.
//
//This file
//  File name: main.c
//  Language: C
//  Max page width: 132 columns  [132 column width may not be strictly adhered to.]
//  Compile this file: gcc -c -Wall -no-pie -m64 -std=c2x -o main.o main.c  
//  Link this program: g++ -m64 -no-pie -o rng.out main.o executive.o fill_random_array.o qsort.o show_array.o cmp.o -std=c2x


//=================Begin code area ===============================================================================

#include <stdio.h>
#include <stdlib.h>

//import x86 main function
extern void executive();

int main () {
    printf("Welcome to Random Products, LLC.\n");
    printf("This software is maintained by Julian Matuszewski\n");
    printf("\n");

    //call the executive() function from the executive x86 source file
    executive();
    
    printf("\n");
    printf("A zero will be returned to the operating system.\n");

    return 0;
}

//============================ end of code =========================================================================