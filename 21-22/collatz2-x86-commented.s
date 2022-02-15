# Student ID: <200024536>
# 
# Please comment assembly code 
#
# Comment character is # 
# You are not required to comment assembler directives 
# For full details of requirements please see practical spec.

	.text
	.file	"collatz.c"
	.globl	collatz
	.p2align	4, 0x90
	.type	collatz,@function
collatz:
	.cfi_startproc
	pushq	%rbp			# Pushes address of base pointer from previous stack frame onto the stack
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp		# Copies current address in stack pointer to base pointer, setting base pointer to top of the stack
	.cfi_def_cfa_register %rbp
	pushq	%rbx			# Push the callee-save register %rbx from previous stack frame onto the stack
	.cfi_offset %rbx, -24
	testl	%edi, %edi		# Performs a bitwise and operation on %edi (int start) with %edi. and set ZF to 1 if start == 0  
	jle	.LBB0_8			# Jumps to .LBB0_8 if start is equal or less than 0
	movl	%edx, %r10d		# %r10d = add (%edx = in_add) 
	movl	$2147483647, %r11d	# %r11d = 2147483647 (INT_MAX)
	subl	%edx, %r11d		# %r11d = INT_MAX-add
	xorl	%ebx, %ebx		# array_length = 0
	jmp	.LBB0_4			# Jumps to .LBB0_4	
	.p2align	4, 0x90
.LBB0_2:
	movl	%eax, %edi		# %edi = current (start)
.LBB0_3:
	addq	$1, %rbx		# array_length = array_length + 1
	cmpq	$200, %rbx		# Compares array_length to 200 (MAXARRAYSIZE). and sets appropriate flags depending on result (if condition on line 11 in collatz.c)
	je	.LBB0_10		# Jumps to .LBB0_10 if array_length equals to MAXARRAYSIZE
.LBB0_4:
	movl	%edi, (%r9,%rbx,4)  	# Index array_length (%rbx used to hold long-lived values that should be preserved across calls) of the array (%r9 = int_array) is set to be current (%edi = start) (line 14 in collatz.c)
	cmpl	$1, %edi		# Compares current to 1, and sets appropriate flags depending on result (if condition on line 18 in collatz.c)
	je	.LBB0_9			# Jumps to .LBB0_9 if current equals to 1
	movl	%edi, %eax		# %eax = current  
	cltd				# Sign-extends eax into edx:eax
	idivl	%ecx			# Divides edx:eax by div (%ecx = in_div), storing quotient in %eax and remainder in %edx (%edx = current%div) 
	testl	%edx, %edx		# Performs a bitwise and operation on %edx (remainder) with %edi. and set ZF to 1 if remainder == 0
	je	.LBB0_2			# Jumps to .LBB0_2 if current%div == 0
	movl	%r11d, %eax		# %eax = INT_MAX-add
	cltd				# Sign-extends eax into edx:eax
	idivl	%esi			# Divids edx:eax by mult (%esi = in_mult), storing quotient in %eax (%eax = (INT_MAX-add)/mult) and remainder in %edx
	cmpl	%edi, %eax		# Compare current to (INT_MAX-add)/mult and sets appropriate flags depending on result (if condition on line 27 in collatz.c)
	jl	.LBB0_11		# Jumps to .LBB0_11 if current is less than (INT_MAX-add)/mult
	imull	%esi, %edi		# %edi = current * mult
	addl	%r10d, %edi		# %edi = (current * mult) + add
	jmp	.LBB0_3			# Jumps to .LBB0_3
.LBB0_8:
	xorl	%ebx, %ebx		# array_length = 0 
	jmp	.LBB0_12		# Jumps to .LBB0_12
.LBB0_9:
	addl	$1, %ebx		# array_length = array_length +1
	movb	$1, %al			# %al(return value) = 1 
	jmp	.LBB0_13		# Jumps to .LBB0_13
.LBB0_10:
	movl	$200, %ebx		# array_length = 200
	jmp	.LBB0_12		# Jumps to .LBB0_12
.LBB0_11:
	addl	$1, %ebx		# array_length = array_length + 1
.LBB0_12:
	xorl	%eax, %eax		# result = 0 (return register)
.LBB0_13:
	movl	%ebx, (%r8)		# *in_length = array_length
	popq	%rbx			# Pop the callee-save register %rbx from the previous stack frame back into %rbx
	popq	%rbp			# Pop the base pointer from the previous stack frame back into %rbp
	.cfi_def_cfa %rsp, 8
	retq				# Return the function
.Lfunc_end0:
	.size	collatz, .Lfunc_end0-collatz
	.cfi_endproc

	.ident	"clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.4.0+2600+cefb5d4c)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
