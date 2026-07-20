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
|          |        |              |          |
|          | _start:|    .......   |  ......  |
|	       |		|    section   |  .data   |
|          |message:|    .......   |  ......  |

Comments are made by using the semicolon ';' the assembler will ignore it

## Exercise 1

Now with everything started, lets make a few functions

First, lets make a puts function that will receive a string called str




## Exercise 2

## Exercise 3

## Exercise 4