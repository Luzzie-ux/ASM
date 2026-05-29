# ASSEMBLY - x86_64 

## Table of Contents

1. [Introduction to Assembly](#introduction-to-assembly)
	1. [How does it do it?](#how-does-it-do-it)
	2. [The Computer](#the-computer)
		1. [Components](#besides-the-cpu-what-elses-composes-our-machine)
		2. [Tools](#tools)
		3. [Binary](#binary)
2. 

# Introduction to Assembly

Foreword: This essay is based of an windows machine and the windows subsystem for linux with ubuntu as my distro of choice and an intel x86_64 processor, some things may need to change for your machine in order to make everything work, in that case search about your processor beforehand to trying coding with Assembly.   

In this README we will discuss about the Assembly Programming Language, namely the x86_64 or i386 Architecture, on how to read it, understand it and how to utilize it alongside almost anything. Since Assembly is the lowest level language before the actual machine code (i.e Binary), we need to understand what a piece of assembly codes does to the computer or to make it more simplier: How does the Computer understand Assembly?

## How does it do it?

When we write a simple program in C or Python to print to stdout, for example, "Hello World", we usually only need to think about the size of the string (in C at least) or what function to call (in this case Python's print()), but have you ever thought what actually happens behind the whole human code and what does the compiler actually do with it?

To put it bluntly, the compiler doesnt care for what you wrote (in a semantical type of sense), once it gets a hold of the code, GCC for example will call a tool chain to first read through everything and check for substancial errors like a forgotten semicolon. Then a parser to find possible optimazitions and lexicon to see if what was wrote follows the rules of the language in use, then the compiler that will write what you need in our topic of discussing, ASM, to then assemble it and link it to the libraries we call and other files we use.

Most if not all the time the compiler will write a better asm code than us since it was build to do exactly that, but it doesnt mean we cant learn it to use in alongside our code, or to better understand why the compiler chose to do something in a certain way that our code definitely does not.

Now what is missing is the answer to the question, "how does it do it?", well its very simple actually, Assembly can be seen as more of an actual instruction set than anything else, it is the native way we can access the core of a machine and give it direct orders. ASM then can be put as our computer manual having two distinct language translations, one to humans and the other to the machine (Binary). And when called, the cpu will follow through.

To better understand why 0's and 1's are important to us, we need to understand more about what a computer is and how is it build. 

## The computer

Depending on the manufacturer that built the computer parts, we will need to use a different set of instructions to build our code and different tools to make it work, for example, there is no universal assembly code or any general way to build something in assembly solely because of the way our CPU is built, every CPU comes with its own set of instructions, rules and orders to follow before it does anything special and that dictates our we build things too.

### Besides the CPU what elses composes our machine?

[section from geeksforgeeks website](https://www.geeksforgeeks.org/computer-organization-architecture/computer-and-its-components/)

**1 - Input Unit:**

The input unit consists of input devices that are attached to the computer. These devices take input and convert it into binary language that the computer understands. Some of the common input devices are keyboard, mouse, joystick, scanner etc.

	The Input Unit is formed by attaching one or more input devices to a computer.
	A user input data and instructions through input devices such as a keyboard, mouse, etc.
	The input unit is used to provide data to the processor for further processing.

**2 - Central Processing Unit:**

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

**3 - Output Unit:**

The output unit consists of output devices that are attached to the computer. It converts the binary data coming from the CPU to human understandable form. The common output devices are monitor, printer, plotter, etc.

	The output unit displays or prints the processed data in a user-friendly format.
	The output unit is formed by attaching the output devices of a computer.
	The output unit accepts the information from the CPU and displays it in a user-readable form.

### Tools

With the CPU alone we cant do anything though, that is why we need an Assembler and Linker too. 

I will be specially using NASM - the Netwide Assembler, a portable 80x86 assembler and it's instruction set when explaining things since that is what I have available to me, as for the Linker I will be using LD - The GNU linker, this one comes with every linux distribuiton as far as I know. 

The purpose of an assembler is to get your .s or .asm files and transform them to objs files that the linker will receive, this tool is part of the compiler toolchain but since we will write everything in asm we have little use for gcc. The Linker is also part of our toolchain, LD in this case will grab the .o files assembled and link them into usable binary to the OS, forming an output file (i.e. a.out), for us to execute our code.

Alongside NASM we will need the Intel Manual (for alternative sources look up [felixcloutier.com/x86/](https://www.felixcloutier.com/x86/)) for the x86 assembly instructions and operations, NASM will impact written syntax so choose assemblers based on what you have, in windows for example we have MASM and for an selfhosted assembler you can use FASM and its website for more information [flat assembler](https://flatassembler.net/). With the Reference Manual I will be also using VSCODE and the following extensions: ASM Code Lens by [maziac](https://github.com/maziac/asm-code-lens-issues) & x86 by [13xforever](https://github.com/13xforever/x86_64-assembly-vscode). Any Text editor or IDE can be using as far as I know to code in asm, so choose any that will be easier or more comfortable for you.

### Binary

Now with the tools in hand and the knowledge we need to know how the machine will understand what we pass to it, we can start learning assembly right? Not exactly. With asm most of if not everything is composed of manual memory management and how will our operations be translated to machine code, so we need first to know a little bit about why binary **is** machine language.

Long before we had terminals, keyboards, and GUIs, we had a machine (in its literal definition) that receives instructions in a certain way that will output what we want from it. So we defined a basic model that could understand nuance and true or false conditions, the Binary. 0's and 1's are not just for mathematical operations but important to everything, with a simple yes and no we defined most if not what could a computer do and alongside logic gates (boolen logic) we have a very basic (but complex) computer.

	Zero for false.
	One for true.

Most computers at that time used 8-bits 8 or binary digits, meaning it representend letters, digits or characters only needed 255 combinations of a 8-bit length word to do so, with the American Standard Code for Information Interchange - ASCII, we defined numeric values for each character needed for anything. But of course it doesnt stop there, writing everything in binary is tiresomea and one wrong 1 can set off many errors, so we came up with the hexadecimal format. 

To make binary values readable, we had to find a way to set them right, so let's make a table:

To know how much a bit is worth we say that the highest one would be 8 and the Least 1

|8|7|6|5|4|3|2|1|
|-|-|-|-|-|-|-|-|
|0|0|0|0|0|0|0|0|

and each bit has a arbitarily given value (2^n)

|2⁸ |2⁷ |2⁶|2⁵|2⁴|2³|2²|2¹|2⁰|
|---|---|--|--|--|--|--|--|--|
|256|128|64|32|16|08|04|02|01|
| 0 | 0 |0 |0 |0 |0 |0 |0 |0 |

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

Now with hex defined, we can write almost anything in an 8 bit lenght, making use of only 4 bits to write one digit and 1 byte to write two. 