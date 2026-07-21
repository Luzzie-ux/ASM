# *Where machine code becomes human language*

## Exercise 0

In this exercise we will start with the very basics of assembly.
make a file named `hello.nasm`

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
make a file named `start.nasm`

First, lets make a print function that will receive a string called str
Then an exit function that will receive the exit code 0
from the start entry point we will call both of them, in the same order

The allowed operations are: MOV, XOR, CALL, SYSCALL, DB, RET and LEA

To better understand what each operand does we divide the code into these function
So we can better read what is going on, and be easier to tweak what is needed

## Exercise 2

With the bit of knowledge we have, shall we make a standalone write function?
make a file named `ft_write.nasm`.

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
|RDI|-|1º|
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

Now that we can write by ourselves, lets do some math.  
Make a file named `math.nasm` with functions that will: add, subtract, multiply, divide, increment and decrement.
This is a great time to understand borrowing functions from the C library until we can make them ourselves. to showcase our operations, lets import printf.
Another clue, instead of _start, this time lets use global main, so we can save ourselves the trouble
of dealing with the stack.

The allowed Operations are: MOV, ADD, SUB, INC, DEC, IMUL, IDIV, CALL, POP, PUSH and XOR  
The allowed functions are: printf

In order to utilize the functions from C we need gcc instead of ld:

````bash
nasm -felf64 math.nasm
gcc -no-pie math.o -o math
./math
```

## Exercise 4