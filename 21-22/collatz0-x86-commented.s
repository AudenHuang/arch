# Student ID: <please insert your student id here for marker's convenience>
# 
# Please comment assembly code 
# For Part 1 you are not required to comment function "collatz"
#
# Comment character is # 
# You are not required to comment assembler directives 
# For full details of requirements please see practical spec.

	.text
	.file	"collatz.c"
	.globl	collatz
	.p2align	4, 0x90
	.type	collatz,@function

#
# comments not required for function collatz (below) in Part 1
# 

collatz:                        
	.cfi_startproc              
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	%edi, -4(%rbp)		
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	%ecx, -16(%rbp)
	movq	%r8, -24(%rbp)
	movq	%r9, -32(%rbp)
	movl	$0, array_length
	movl	-8(%rbp), %eax
	movl	%eax, mult
	movl	-12(%rbp), %eax
	movl	%eax, add
	movl	-16(%rbp), %eax
	movl	%eax, div
	movq	-32(%rbp), %rax
	movq	%rax, array
	movb	$0, -33(%rbp)		# Copies "0" (false) to -33 byte below the base pointer (the boolean to be returned by the function)
	cmpl	$1, -4(%rbp)
	jl	.LBB0_2
	movl	-4(%rbp), %edi
	callq	collatz_recurse
	andb	$1, %al			# Performs bitwise and operation on %al with 1, clearing all bits to 0 except for the least significant bit, which may be 1 (true) or 0 (false)
	movb	%al, -33(%rbp)		# Copies value of %al to -33 byte below base pointer (the return boolean)	
.LBB0_2:
	movl	array_length, %ecx	# %ecx = array_length
	movq	-24(%rbp), %rax		# %rax = *in_length (line 32)
	movl	%ecx, (%rax)		# *in_length = array_length
	movb	-33(%rbp), %al		# %al = value of return boolean, which is 0 according to line 43
	andb	$1, %al			# Performs bitwise and operation on %al with 1, clearing all bits to 0 except for the least significant bit, which may be 1 (true) or 0 (false)
	movzbl	%al, %eax		# %ecx = %al (most significant bits of %ecx are zero extended from %al)
	addq	$48, %rsp		# Release stack frame by moving stack pointer 48 bytes up
	popq	%rbp			# Pop the base pointer from the previous stack frame back into %rbp
	.cfi_def_cfa %rsp, 8
	retq				# Return the function
.Lfunc_end0:
	.size	collatz, .Lfunc_end0-collatz
	.cfi_endproc
#
# comments not required for function collatz (above) in Part 1
#

#
# comments are required for function collatz_recurse (below)
#

	.p2align	4, 0x90
	.type	collatz_recurse,@function
collatz_recurse:
	.cfi_startproc
	pushq	%rbp			# Pushes address of base pointer from previous stack frame onto the stack
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp		# Copies current address in stack pointer to base pointer, setting base pointer to top of the stack
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp		# Reserve 16 bytes for a new stack frame by moving the stack pointer -16 bytes below the base pointer
	movl	%edi, -8(%rbp)		# Copies the 'int current' argument stored in the lower 32-bit register for the first argument to -8 bytes below the base pointer in the stack 
	cmpl	$200, array_length	# Compares array_length to constant "200"(MAXARRAYSIZE) and sets appropriate flags depending on result (if condition on line 11 in collatz.c)
	jl	.LBB1_2			# Jumps to .LBB1_2 if array_length is less than 200, by checking if zero flag is not set
	movb	$0, -1(%rbp)		# Copies "0" (false) to -1 byte below the base pointer (the boolean to be returned by the function) 
	jmp	.LBB1_9			# Jumps to .LBB1_9
.LBB1_2:
	movl	-8(%rbp), %edx		# %edx = current
	movq	array, %rax		# %rax = array (put array in the return register)
	movslq	array_length, %rcx	# Copies 32-bit value of array_length to 64-bit %rcx by extending the integer sign bit, to use as index address for following instruction
	movl	%edx, (%rax,%rcx,4)	# index array_length (%rcx) of the array (%rax) is set to be current (%edx) (line 14 in collatz.c)
	movl	array_length, %eax	# %eax = array_length
	addl	$1, %eax		# %eax = %eax +1 (added one to array_length and put the result back in %eax)
	movl	%eax, array_length	# array_length = %eax (array_length +1)
	cmpl	$1, -8(%rbp)		# Compares current to constant "1" and sets appropriate flags depending on result (if condition on line 18 in collatz.c)
	jne	.LBB1_4			# Jumps to .LBB1_4 if current is not equal to 1
	movb	$1, -1(%rbp)		# Copies "1" (true) to -1 byte below the base pointer (the boolean to be returned by the function) 
	jmp	.LBB1_9			# Jumps to .LBB1_9
.LBB1_4:
	movl	-8(%rbp), %eax		# %eax = current
	cltd				# converts the signed long in %eax to a signed double in %edx:%eax by extending the most-significant bit (sign bit) of %eax into all bits of %edx (preperation for division)
	idivl	div			# divides %edx:%eax by div, storing quotient in %eax and remainder in %edx (%edx = current%div)
	cmpl	$0, %edx		# Compares current%div (%edx) to constant "0" and sets appropriate flags depending on result (if condition on line 21 in collatz.c)
	jne	.LBB1_6			# Jumps to .LBB1_6 if current%div is not equal to 0
	movl	-8(%rbp), %eax		# %eax = current
	cltd				# sign-extends eax into edx:eax
	idivl	div			# divides %edx:%eax by div, storing quotient in %eax (%eax = current/div)and remainder in %edx 
	movl	%eax, %edi		# %edi = current/div
	callq	collatz_recurse		# Calls the collatz_recurse function
	andb	$1, %al			# Performs bitwise and operation on %al with 1, clearing all bits to 0 except for the least significant bit, which may be 1 (true) or 0 (false)
	movb	%al, -1(%rbp)		# Copies value of %al to -1 byte below base pointer (the return boolean)
	jmp	.LBB1_9			# Jumps to .LBB1_9
.LBB1_6:
	movl	-8(%rbp), %eax		# %eax = current
	movl	%eax, -12(%rbp)		# stored current at -12 bytes below the base pointer in the stack 
	movl	$2147483647, %eax	# %eax = 2147483647 (INT_MAX)
	subl	add, %eax		# %eax = INT_MAX - add (subtract add from 2147483647 and stores it in %eax) 
	cltd				# sign-extends eax into edx:eax
	idivl	mult			# divides edx:eax by mult, storing quotient in %eax (%eax = (INT_MAX - add)/mult) and remainder in %edx
	movl	%eax, %ecx		# %ecx = (INT_MAX - add)/mult
	movl	-12(%rbp), %eax		# %eax = current
	cmpl	%ecx, %eax		# Compares current to (INT_MAX - add)/mult and sets appropriate flags depending on result (if condition on line 27 in collatz.c)
	jle	.LBB1_8			# Jumps to .LBB1_8 if current is less or equal to (INT_MAX - add)/mult
	movb	$0, -1(%rbp)		# Copies "0" (false) to -1 byte below the base pointer (the boolean to be returned by the function)
	jmp	.LBB1_9			# Jumps to .LBB1_9
.LBB1_8:
	movl	-8(%rbp), %edi		# %edi = current
	imull	mult, %edi		# %edi = current*mult
	addl	add, %edi		# %edi = (current*mult) + add
	callq	collatz_recurse		# Calls the collatz_recurse function
	andb	$1, %al			# Performs bitwise and operation on %al with 1, clearing all bits to 0 except for the least significant bit, which may be 1 (true) or 0 (false)
	movb	%al, -1(%rbp)		# Copies value of %al to -1 byte below base pointer (the return boolean) 
.LBB1_9:
	movb	-1(%rbp), %al		# %al = value of return boolean
	andb	$1, %al			# Performs bitwise and operation on %al with 1, clearing all bits to 0 except for the least significant bit, which may be 1 (true) or 0 (false)
	movzbl	%al, %eax		# Sign extends %al to %eax, leaves boolean value in return register
	addq	$16, %rsp		# Release stack frame by moving stack pointer 16 bytes up
	popq	%rbp			# Pop the base pointer from the previous stack frame back into %rbp
	.cfi_def_cfa %rsp, 8
	retq				# Return the function
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
	.addrsig_sym collatz_recurse
	.addrsig_sym array_length
	.addrsig_sym mult
	.addrsig_sym add
	.addrsig_sym div
	.addrsig_sym array
