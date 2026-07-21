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

Now with everything started, lets make a few tweaks to the original program

First, lets make a puts function that will receive a string called str
Then an exit function that will receive the exit code 0
from the start entry point we will call both of them, in the same order

The allowed operations are: MOV, XOR, CALL, SYSCALL, DB, RET and LEA

## Exercise 2

With the bit of knowledge we have, shall we make a standalone write function?

For that we will need the same ideas we had before but now, we cant just be
loading variables directly into .data, the write function should:

Receive any string independtly of its variable name, count its size by itself
the file descriptor should be decided before hand, and should print whatever
was passed into it, to the proper place.



## Exercise 3

## Exercise 4