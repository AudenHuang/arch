# arch
CS2002 Prarical 1
## Overview
In this practical students will undertake various tasks related to understanding the assembly
language of x86-64, in the AT&T syntax (also known as GNU Assembler Syntax, or GAS).
Students will be analysing both unoptimised and optimised assembly

## Tasks
1. Analysing unoptimised assembly code
For this part students are required to comment the assembly code for function collatz recurse
in the file collatz0-commented.s, to help a human reader understand it. 

2. Recursion to iteration
For this part study collatz2-commented.s, which was obtained by optimisation level 2. students will
see that recursion has turned into iteration. Students are to add comments for the assembly
code for function collatz.
Include in the report a diagram/table/list of the stack frame for function collatz
in this file, answering the same questions about the stack frame as asked about the stack
frame in Part 1. Students can also further explain some of the observed compiler optimisations
in the report. Explain, for example, why the function collatz recurse has completely
disappeared from the assembly version. The code commenting and the accompanying text
in the report should convince the marker that the student understand why the code does the same
computation as before.

3. ARMv8
For this part study the provided file collatz1-arm-commented.s, which is assembly of a very
different architecture. It was also compiled from collatz.c, with optimisation level 1. In
order to understand this, some independent study may be required.
Describe in more detail in the report what the student have learned about the
ARMv8 architecture as it relates to this code. This may include, but is not limited to:
• What do the various instructions in collatz1-arm-commented.s do?
• What addressing modes are used and what do they mean?
• How do you see the 64-bit ARM calling convention reflected in the assembly?
• Where are 64-bit values used and where 32-bit or 16-bit or 8-bit values?
• What is the layout of the stack frames of the collatz recurse function? Do you notice any interesting differences with the stack frames you found in Part 1?

## Remark
The comments in the files has been alighned in VSCode for the marker to view, so it might not be in alignment on Github

