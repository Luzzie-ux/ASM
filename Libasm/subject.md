# *Where machine code becomes human language*

## Exercise 0

In this exercise we will start with the very basics of assembly.

It is a programming tradition to make your first program to print "Hello, World!" to the terminal.
Remember to note everything you do in order to not forget the basics, they are the base of everything after all.

The allowed operations are: MOV, SYSCALL, XOR and DB

The syntax of NASM is line based so everything is split into Directives and Sections. 
Labels, Instructions and Operands:

|          | Labels | Instructions | Operands |
|----------|--------|--------------|----------|
|Sections  |        |    section   |  .text   |
|Directives|        |    global    |  _start  |
|          | _start:|    .......   |  ......  |
|	       |		|    section   |  .data   |
|          |message:|    .......   |  ......  |

Comments are made by using the semicolon ';' the assembler will ignore it

## Exercise 1

Now with everything started, lets make a few tweaks to the original program

First, lets make a print function that will receive a string called str
Then an exit function that will receive the exit code 0
from the start entry point we will call both of them, in the same order

The allowed operations are: MOV, XOR, CALL, SYSCALL, DB, RET and LEA

To better understand what each operand does we divide the code into these function
So we can better read what is going on, and be easier to tweak what is needed

## Exercise 2

With the bit of knowledge we have, shall we make a standalone write function?

The allowed operations are MOV, RET and SYSCALL

To make a function visible outside its file, we need to make it `global`

so in The Section .text:  
```asm
section	.text
	global	ft_write
```

It is important to remember that by the ABI:
|Register||Argument|
|-|-|-|
|RBI|-|1º|
|RSI|-|2º|
|RDX|-|3º|
|RCX|-|4º|
|R8|-|5º|
|R9|-|6º|
|R10-R15|-|...|

Anything after R9 should be pushed onto the stack for safe keeping

Use the main function in the main.c file to plug your function in it,
it needs to follow the same name it was declared with and be declared
with the `extern` keyword on C so the compiler knows its not a C function

to compile both of them together:
```bash
nasm -felf64 ft_write.nasm -o ft_write.o
gcc -c main.c -o main.o
gcc main.o ft_write.o -o write
```

## Exercise 3

## Exercise 4