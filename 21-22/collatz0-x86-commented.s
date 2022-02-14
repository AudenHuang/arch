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
	movb	$0, -33(%rbp)
	cmpl	$1, -4(%rbp)
	jl	.LBB0_2
	movl	-4(%rbp), %edi
	callq	collatz_recurse
	andb	$1, %al
	movb	%al, -33(%rbp)
.LBB0_2:
	movl	array_length, %ecx
	movq	-24(%rbp), %rax
	movl	%ecx, (%rax)
	movb	-33(%rbp), %al
	andb	$1, %al
	movzbl	%al, %eax
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	cmpl	$200, array_length
	jl	.LBB1_2
	movb	$0, -1(%rbp)
	jmp	.LBB1_9
.LBB1_2:
	movl	-8(%rbp), %edx
	movq	array, %rax
	movslq	array_length, %rcx
	movl	%edx, (%rax,%rcx,4)
	movl	array_length, %eax
	addl	$1, %eax
	movl	%eax, array_length
	cmpl	$1, -8(%rbp)
	jne	.LBB1_4
	movb	$1, -1(%rbp)
	jmp	.LBB1_9
.LBB1_4:
	movl	-8(%rbp), %eax
	cltd
	idivl	div
	cmpl	$0, %edx
	jne	.LBB1_6
	movl	-8(%rbp), %eax
	cltd
	idivl	div
	movl	%eax, %edi
	callq	collatz_recurse
	andb	$1, %al
	movb	%al, -1(%rbp)
	jmp	.LBB1_9
.LBB1_6:
	movl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	$2147483647, %eax
	subl	add, %eax
	cltd
	idivl	mult
	movl	%eax, %ecx
	movl	-12(%rbp), %eax
	cmpl	%ecx, %eax
	jle	.LBB1_8
	movb	$0, -1(%rbp)
	jmp	.LBB1_9
.LBB1_8:
	movl	-8(%rbp), %edi
	imull	mult, %edi
	addl	add, %edi
	callq	collatz_recurse
	andb	$1, %al
	movb	%al, -1(%rbp)
.LBB1_9:
	movb	-1(%rbp), %al
	andb	$1, %al
	movzbl	%al, %eax
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
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
