#!/bin/bash

#Program: Non-deterministic Random Numbers
#Author: Julian Matuszewski

#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble executive.asm"
nasm -f elf64 -o executive.o executive.asm

echo "Assemble fill_random_array.asm"
nasm -f elf64 -o fill_random_array.o fill_random_array.asm

echo "Assemble show_array.asm"
nasm -f elf64 -o show_array.o show_array.asm

echo "Assemble isnan.asm"
nasm -f elf64 -o isnan.o isnan.asm

echo "Assemble normalize.asm"
nasm -f elf64 -o normalize.o normalize.asm

echo "Compile main.c"
gcc -c -Wall -no-pie -m64 -std=c2x -o main.o main.c

echo "Compile qsort.cpp"
gcc -c -Wall -no-pie -m64 -std=c++17 -o qsort.o qsort.cpp

echo "Link object files"
g++ -m64 -no-pie -o rng.out main.o qsort.o executive.o fill_random_array.o show_array.o isnan.o normalize.o -std=c2x

echo "Run the Non-deterministic Random Numbers program:"
./rng.out

# For cleaner working directory, you can:
rm *.o
rm *.out

echo "Script file terminated."