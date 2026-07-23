# *Where machine code becomes human language*

## Exercise 0

In this exercise we will start with the very basics of assembly.
make a file named `hello.s`

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
make a file named `start.s`

First, lets make a print function that will receive a string called str
Then an exit function that will receive the exit code 0
from the start entry point we will call both of them, in the same order

The allowed operations are: MOV, XOR, CALL, SYSCALL, DB, RET and LEA

To better understand what each operand does we divide the code into these function
So we can better read what is going on, and be easier to tweak what is needed

## Exercise 2

With the bit of knowledge we have, shall we make a standalone write function?
make a file named `ft_write.s`.

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
nasm -felf64 ft_write.s -o ft_write.o
gcc -c main.c -o main.o
gcc main.o ft_write.o -o write
```

## Exercise 3

Now that we can write by ourselves, lets do some math.  
Make a file named `math.s` with functions that will: add, subtract, multiply, divide, increment and decrement.
This is a great time to understand borrowing functions from the C library until we can make them ourselves. to showcase our operations, lets import printf.
Another clue, instead of _start, this time lets use global main, so we can save ourselves the trouble
of dealing with the stack.

The allowed Operations are: MOV, ADD, SUB, INC, DEC, IMUL, IDIV, CALL, POP, PUSH and XOR  
The allowed functions are: printf

In order to utilize the functions from C we need gcc instead of ld:

```bash
nasm -felf64 math.s
gcc -no-pie math.o -o math
./math
```

## Exercise 4

*When it's not 0, then its definally 1. Or is it?*

After learning how to incremement and decrement, how about we do another mix of ASM and C.
Let's recreate a C brand function called `strlen`. Make a file named after it with the prefix `ft_` and extension `.s`.
And a second file called `main.c` that will print the number returned by your ft_strlen.

The allowed operations are: MOV, INC, CMP, JMP, CALL, LEA, JX and SYSCALL  
The allowed functions are: printf  

The JX Instruction is actually an abbreviation to Jump IF X, where X is a condition:
|I| Mnemonic  |I| Description          |I|  Flags |I| Mnemonic |I| Description            |I|  Flags |I|
|-|-----------|-|----------------------|-|--------|-|----------|-|------------------------|-|--------|-|
|I|  JE       |I| Jump if Equal        |I| ZF = 1 |I| JS       |I| Jump if Signed         |I| SF = 1 |I|
|I|  JNE      |I| Jump if NOT Equal    |I| ZF = 0 |I| JNS      |I| Jump if NOT Signed     |I| SF = 0 |I|
|I|  JZ       |I| Jump if Zero         |I| ZF = 1 |I| JP       |I| Jump if Parity         |I| PF = 1 |I|
|I|  JNZ      |I| Jump if NOT Zero     |I| ZF = 0 |I| JNP      |I| Jump if NOT Parity     |I| PF = 0 |I|
|I|  JC       |I| Jump if Carry        |I| CF = 1 |I| JPE      |I| Jump if Parity is Even |I| PF = 1 |I|
|I|  JNC      |I| Jump if NOT Carry    |I| CF = 0 |I| JPO      |I| Jump if Parity is Odd  |I| PF = 0 |I|
|I|  JO       |I| Jump if Overflow     |I| OF = 1 |I|          |I|                        |I|        |I|
|I|  JNO      |I| Jump if NOT Overflow |I| OF = 0 |I|          |I|                        |I|        |I|

The following table shows a list of signed jumps based on comparisons of signed operands:

|I| Mnemonic  |I| Description          |I|  Flags  |I|
|-|-----------|-|----------------------|-|---------|-|
|I|  JG       |I| Jump if Greater      |I| ZF = 0  |I|
|I|  JGE      |I| Jump if G or Equal   |I| SF = OF |I|
|I|  JNG      |I| Jump if NOT Greater  |I| ZF = 1  |I|
|I|  JNGE     |I| Jump if NOT G or E   |I| SF ≠ OF |I|
|I|  JL       |I| Jump if Less         |I| SF ≠ OF |I|
|I|  JLE      |I| Jump if L or Equal   |I| SF = OF |I|
|I|  JNL      |I| Jump if NOT Less     |I| SF = OF |I|
|I|  JNLE     |I| Jump if NOT L or E   |I| ZF = 1  |I|

The following table shows a list of signed jumps based on comparisons of unsigned operands:

|I| Mnemonic  |I| Description          |I|  Flags |I|
|-|-----------|-|----------------------|-|--------|-|
|I|  JA       |I| Jump if Above        |I| ZF = 0 |I|
|I|  JAE      |I| Jump if A or Equal   |I| CF = 0 |I|
|I|  JNA      |I| Jump if NOT Above    |I| ZF = 1 |I|
|I|  JNAE     |I| Jump if NOT A or E   |I| CF = 1 |I|
|I|  JB       |I| Jump if Below        |I| CF = 1 |I|
|I|  JBE      |I| Jump if B or Equal   |I| ZF = 1 |I|
|I|  JNB      |I| Jump if NOT Below    |I| CF = 0 |I|
|I|  JNBE     |I| Jump if NOT B or E   |I| CF = 0 |I|

The follow table shows the jumps based on the value of CX and ECX:

|I| Mnemonic |I| Description     |I|
|-|----------|-|-----------------|-|
|I| JCXZ     |-| Jump if CX = 0  |I|
|I| JECXZ    |-| Jump if ECX = 0 |I|

All conditional jumps except these last two (JCXZ & JECXZ) use the processor flags for their criteria.
Thus, any statement that sets or clears a flag can serve as a test basis for a conditional jump. The jump statement can be any one of 30 conditional-jump instructions

You should already know how to assemble and compile this

## Exercise 5

With conditional comparisons, loops, movs and registers we have mastered the basics of what assembly has to offer, 