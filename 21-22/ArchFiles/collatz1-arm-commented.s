// Student ID: <please insert your student id here for marker's convenience>
// 
// Please comment assembly code 
// For Part 3 you are not required to comment function collatz
//
// Comments start with // 
// You are not required to comment assembler directives 
// For full details of requirements please see practical spec.

	.text
	.file	"collatz.c"
	.globl	collatz
	.p2align	2
	.type	collatz,@function
//
// comments not required for function collatz (below) in Part 1
//

collatz:
	.cfi_startproc
	stp	x29, x30, [sp, #-32]!	        
	stp	x20, x19, [sp, #16]		          
	mov	x29, sp				                  
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	adrp	x8, mult
	str	w1, [x8, :lo12:mult]
	adrp	x8, add
	mov	x19, x4
	adrp	x20, array_length
	adrp	x9, div
	str	w2, [x8, :lo12:add]
	adrp	x8, array
	cmp	w0, #1
	str	wzr, [x20, :lo12:array_length]
	str	w3, [x9, :lo12:div]
	str	x5, [x8, :lo12:array]
	b.lt	.LBB0_2
	bl	collatz_recurse
	b	.LBB0_3
.LBB0_2:
	mov	w0, wzr
.LBB0_3:
	ldr	w8, [x20, :lo12:array_length]
	and	w0, w0, #0x1
	str	w8, [x19]
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	ret
.Lfunc_end0:
	.size	collatz, .Lfunc_end0-collatz
	.cfi_endproc
//
// comments not required for function collatz (above) in Part 3
//

//
// comments are required for function collatz_recurse (below)
//
	.p2align	2
	.type	collatz_recurse,@function
collatz_recurse:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!		        // Stores the current value of the frame pointer (base pointer) and the link register at -16 bytes below the stack pointer (sp) then decrement sp by 16 bytes
	mov	x29, sp				                // x29 = stack pointer
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, array_length		        // X8 = array_length
	ldrsw	x9, [x8, :lo12:array_length]  	// x9 = array_length (load register signed word from x8 and writes it in x9)
	cmp	w9, #199			                // Compares array_length to the constant 199 and sets appropriate flags depending on result (if condition on line 11 in collatz.c)
	b.le	.LBB1_2				            // Branch to .LBB1_2 if array_length is less than or equals to 199 (by checking the flags)
.LBB1_1:
	mov	w0, wzr				                // start = 0
	b	.LBB1_8				                // Branch to .LBB1_8	
.LBB1_2:
	adrp	x10, array			            // x10 = array
	ldr	x10, [x10, :lo12:array]	        	// x10 = array
	add	w11, w9, #1			                // w11 = array_length + 1
	cmp	w0, #1				                // Compares current to the constant 1 and sets appropriate flags depending on result (if condition on line 18 in collatz.c)
	str	w0, [x10, x9, lsl #2]		        // Index array_length (x9) of the array (x10) is set to be current (w0) (x9 logically shift left by 2 bit)(line 14 in collatz.c)
	str	w11, [x8, :lo12:array_length]	  	// array_length (x8) = array_length + 1
	b.eq	.LBB1_8				            // Branch to .LBB1_8 if current is equals to 1 (by checking the flags)
	adrp	x8, div				            // x8 = div
	ldr	w9, [x8, :lo12:div]		          	// w9 = div
	sdiv	w8, w0, w9			            // w8 = current/div (only saved the integer bit, sdiv don’t calculate the remainder)
	msub	w9, w8, w9, w0			        // w9 = (current- (w8 *div)) = remainder of current/div (current%div)
	cbz	w9, .LBB1_6			                // Branch to .LBB1_6 if current%div equals to zero (by checking the flags)
	adrp	x8, add				            // x8 = add
	ldr	w8, [x8, :lo12:add]		      	    // w8 = add
	adrp	x9, mult			            // x9 = mult
	ldr	w9, [x9, :lo12:mult]		        // w9 = mult
	mov	w10, #2147483647		            // w10 = 2147483647 (INT_MAX)
	sub	w10, w10, w8			            // w10 = INT_MAX -add
	sdiv	w10, w10, w9			        // w10 = (INT_MAX -add)/mult
	cmp	w10, w0				                // Compares (INT_MAX -add)/mult to the current and sets appropriate flags depending on result (if condition on line 27 in collatz.c)
	b.lt	.LBB1_1				            // Brach to .LBB1_1 if (INT_MAX -add)/mult is less than or equals to current (by checking the flags)
	madd	w0, w9, w0, w8		      	    // current = current*mult + 0
	b	.LBB1_7				                // Branch to .LBB1_7
.LBB1_6:
	mov	w0, w8			              	    // Current = current/div
.LBB1_7:
	bl	collatz_recurse			            // Calls collatz_recurse function (load the address and branch to it)
.LBB1_8:
	and	w0, w0, #0x1			            // Performs bitwise and operation between w0 and '1' and saves value to w0, setting w0 to either true or false by clearing all bits to zero except first bit
	ldp	x29, x30, [sp], #16		          	// Load frame pointer and link register values from previous stack frame located at sp and back into respective registers, then increment sp by 16 bytes
	ret					                    // Return function
.Lfunc_end1:
	.size	collatz_recurse, .Lfunc_end1-collatz_recurse
	.cfi_endproc

	.type	array_length,@object
	.local	array_length
	.comm	array_length,4,4
	.type	mult,@object
	.local	mult
	.comm	mult,4,4
	.type	add,@object
	.local	add
	.comm	add,4,4
	.type	div,@object
	.local	div
	.comm	div,4,4
	.type	array,@object
	.local	array
	.comm	array,8,8
	.ident	"clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.4.0+2600+cefb5d4c)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
