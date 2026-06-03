# ASSEMBLY - x86_64 

## Table of Contents

1. [Introduction to Assembly](#introduction-to-assembly)
	1. [Foreword](#foreword)
	2. [The Computer](#the-computer)
	3. [Components](#components)
		1. [Input Unit](#1---input-unit)
		2. [Central Processing Unit](#2---central-processing-unit)
		3. [Output Unit](#3---output-unit)
		4. [Binary](#binary)
2. 

# Introduction to Assembly

In this README we will discuss about the Assembly Programming Language, namely the x86_64 or i386 Architecture, on how to read it, understand it and how to utilize it alongside almost anything. Since Assembly is the lowest level language before the actual machine code (i.e Binary), we need to understand: How does the Computer understand Assembly?

## Foreword

This essay is based on an windows machine and the windows subsystem for linux with ubuntu as my distro of choice and an intel x86_64 processor, some things may need to change for your machine in order to make everything work, in that case search about your processor beforehand to trying coding with Assembly.

In order to Code in ASM however, we can not use the normal C compiler for this job and therefore, need tools to do so, but what do we use?

In this paper I will be specially using the NASM (Netwide Assembler, a portable 80x86 assembler) and its instruction set when explaining whatever isn't operations, NASM will impact written syntax, so choose an assembler based on what you currently have when coding, for Windows we can use MASM, for Linux we can use the GAS (GNU Assembler) and for a self-hosted assembler you can use and read about FASM in its website [flat assembler](https://flatassembler.net/). As for the Linker, LD (The GNU linker) will be utilized, this linker should come with every distribution of the GNU Binary utilities as far as I know. 

To further understand the use of this tools check the section below.

Alongside NASM we will need the Intel Manual [found here](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html) for the x86_64 assembly instructions and operations. As previously explained, the Assembler will impact the syntax used to write our code, but in order to perform operations we will need the construction set made by the Fabricator of our CPU (Intel in this case), it's here that we can learn what the cpu can and cannot do.

(for alternative sources of the i386 architecture, look up [felixcloutier.com/x86/](https://www.felixcloutier.com/x86/))

Alongside the Reference Manual I will be also using VSCODE and the following extensions: ASM Code Lens by [maziac](https://github.com/maziac/asm-code-lens-issues) & x86 by [13xforever](https://github.com/13xforever/x86_64-assembly-vscode). Any Text editor or IDE can be used, so choose what will be easier or more comfortable for you.

## The computer 

When we write a simple program in C or Python to print to stdout, for example, the standard "Hello World", we usually only need to think about the size of the string (in C at least) or what function to call (in this case Python's print()), but have you ever thought what actually happens behind the whole human code and what does the compiler actually do with it?

To put it bluntly, the compiler doesn't care for what you wrote (in a semantical type of sense), once it gets a hold of the code, GCC will call its tool chain:

| Tool Chain  |     Phases               |   descriptions    |
|-------------|--------------------------|-------------------|
|Pre-processor| Lexer - Lexical analysis | The compiler will read the source code, grouping every character into tokens|
| P   ->      | Parser - Syntax analysis | After the lexer, the parser will take the tokens as inputs and will verify the grammatical struct of the code and its syntax, building a parse tree to pass along|
| P   ->      |        Semantic analysis | This phase will verify type correctness and ensure proper declaration and scope of identifiers, forming an Annotated Syntax Tree to pass further|
| Compiler    |             Optimization | Here the compiler will take from the AST, verifying what can be optimized out and what can be further specialized|
| C   ->      |          Code generation | From what the optimization gives us, an Assembly code will be generated here|
| Assembling  |                Assembler | With the assembly code in hands, the AS will assemble the .s into .o files, passing them into binary|
| Linking     |                   Linker | Last the LD will take the .o given to it from the AS and form an ELF executable (or shared object)|


Most if not all the time the compiler will write a better asm code than us because it was built to do exactly that. It doesn't mean we can't learn how to use alongside our code. It's in fact important to understand how does the compiler do its job because we will be doing it, besides assembling and linking, from the Pre-Processing to Code Generation, that will be our Job now. 

Now what is missing is the answer to the question, "How does It do it?". Assembly itself can't be read by the computer and so with the help of NASM we can transform whatever we give it into binary. This Language should be interpreted as an instruction set than anything else, it is the native way we can access the core of a machine and give it direct orders. Metaphorically ASM is to humans what Binary is to computers, a dialect of some sorts.

Let's now dive into what is a Computer and how does a Computer behaves when it has to run.

## Components

Depending on the manufacturer that built the computer parts, we will need to use a different way to build our code and different tools to make it work, there is no universal method when creating any assembly code not in the uniqueness sense of the phrase but because how our CPU is built. Although the CPU may seem the most important part, it is only when working together with the other parts that we can use all of the CPU's potential.

The following overview of computer components is summarized from [geeksforgeeks - computer-and-its-components](https://www.geeksforgeeks.org/computer-organization-architecture/computer-and-its-components/). The indented points are quoted directly.

### 1 - Input Unit:

The input unit consists of input devices that are attached to the computer. These devices take user input and convert it into binary language that the computer understands. Some of the common input devices are keyboard, mouse, joystick, scanner etc.

	The Input Unit is formed by attaching one or more input devices to a computer.
	A user input data and instructions through input devices such as a keyboard, mouse, etc.
	The input unit is used to provide data to the processor for further processing.

### 2 - Central Processing Unit:

The *CPU (Central Processing Unit)* is the brain of the computer because it controls everything the computer does. When you enter information using an input device, the CPU processes it. First, it fetches instructions from memory, then decodes them to understand what needs to be done. If needed, it retrieves data from memory or an input device. After that, the CPU executes the task and either stores the result or displays it on an output device. The CPU has three main parts:

A. *Arithmetic and Logic Unit (ALU):*  

The ALU, as its name suggests performs mathematical calculations and takes logical decisions. Arithmetic calculations include addition, subtraction, multiplication and division. Logical decisions involve the comparison of two data items to see which one is larger or smaller or equal. 

	Arithmetic Logical Unit is the main component of the CPU
	It is the fundamental building block of the CPU.
	Arithmetic and Logical Unit is a digital circuit that is used to perform arithmetic and logical operations.

B. *Control Unit:*   

The Control unit coordinates and controls the data flow in and out of the CPU, and also controls all the operations of ALU, memory registers and also input/output units. It is also responsible for carrying out all the instructions stored in the program. It decodes the fetched instruction, interprets it and sends control signals to input/output devices until the required operation is done properly by ALU and memory.

	The Control Unit is a component of the central processing unit of a computer that directs the operation of the processor.
	It instructs the computer's memory, arithmetic and logic unit, and input and output devices on how to respond to the processor's instructions.
	In order to execute the instructions, the components of a computer receive signals from the control unit.
	It is also called the central nervous system or brain of the computer.

C. *Memory Registers:*  

A register is a small, temporary memory inside the CPU. The processor uses it to store data that it is currently working on. Registers come in different sizes, such as 16-bit, 32-bit, and 64-bit, and each has a specific role. Some store data, some store instructions, and others hold memory addresses.

For example, the Accumulator (ACC) is an important register in the CPU. It holds one of the values used in calculations inside the Arithmetic and Logic Unit (ALU).

Apart from registers, the internal memory (also called primary memory or main memory) is where data and instructions are stored temporarily while a program runs. This memory is called RAM (Random Access Memory). Every piece of data in RAM is stored at a unique location with an address, so the processor can access it quickly without searching the entire memory. Since RAM provides direct access to any data location, it is called Random Access Memory.

	Memory Unit is the primary storage of the computer.
	It stores both data and instructions.
	Data and instructions are stored permanently in this unit so that they are available whenever required.

### 3 - Output Unit:

The output unit consists of output devices that are attached to the computer. It converts the binary data coming from the CPU to human understandable form. The common output devices are monitor, printer, plotter, etc.

	The output unit displays or prints the processed data in a user-friendly format.
	The output unit is formed by attaching the output devices of a computer.
	The output unit accepts the information from the CPU and displays it in a user-readable form.

### Binary

Now with the tools in hand and the knowledge we need to know how the machine will understand what we pass to it, we can start learning assembly right? Not exactly. With asm most of if not everything is composed of manual memory management and how will our operations be translated to machine code, so we need first to know a little bit about why binary **is** machine language.

Long before we had terminals, keyboards, and GUIs, we had a machine (in its literal definition) that receives instructions in a certain way that will output what we want from it. So we defined a basic model that could understand nuance and true or false conditions, the Binary. 0's and 1's are not just for mathematical operations but important to everything, with a simple yes and no we defined most if not what could a computer do and alongside logic gates (boolean logic) we have a very basic (but complex) computer.

	Zero for false.
	One for true.

Most computers at that time used a variety of bits (binary digits) to perform operations, but with the intel8080 the 8-bit format became more standardized. Bits are to machines letters, digits or characters, being able to perform 256 combinations of an 8-bit length word to do so, with the American Standard Code for Information Interchange - ASCII, we defined numeric values for each character needed for anything. But of course it doesn't stop there, writing everything in binary is tedious and one 0 in the wrong place can create many errors, so IBM came up with the hexadecimal format. 

To make binary values readable, we had to find a way to set them right, so let's make a table:

To know how much a bit is worth we say that the Highest value one would be eight position and the Least Valuable one the first position

|8|7|6|5|4|3|2|1|
|-|-|-|-|-|-|-|-|
|0|0|0|0|0|0|0|0|

and each bit has a arbitrarily given value too: (2^n)

|2⁷ |2⁶|2⁵|2⁴|2³|2²|2¹|2⁰|
|---|--|--|--|--|--|--|--|
|128|64|32|16|08|04|02|01|
| 0 |0 |0 |0 |0 |0 |0 |0 |

(With the growth of bit sizes from 8 to 16 and 16 to 32 and 32 to 64, the Most Significant Bit (MSB) keeps increasing, but that doesn't mean we stopped using lower formats, check [registers](#registers) to better understand.)

The hexadecimal format takes from this to define how a digit will be written because of how many combinations from 0000 to 1111 we can make:

|8|4|2|1| HEX |
|-|-|-|-|-----|
|0|0|0|0| -> 0|
|0|0|0|1| -> 1|
|0|0|1|0| -> 2|
|0|0|1|1| -> 3|
|0|1|0|0| -> 4|
|0|1|0|1| -> 5|
|0|1|1|0| -> 6|
|0|1|1|1| -> 7|
|1|0|0|0| -> 8|
|1|0|0|1| -> 9|
|1|0|1|0| -> A|
|1|0|1|1| -> B|
|1|1|0|0| -> C|
|1|1|0|1| -> D|
|1|1|1|0| -> E|
|1|1|1|1| -> F|

Now with hex defined, we can write almost anything in an 8 bit length, making use of only 4 bits to write one digit and 1 byte to write two. 