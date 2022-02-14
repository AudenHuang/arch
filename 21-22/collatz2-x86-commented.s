# Student ID: <please insert your student id here for marker's convenience>
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	.cfi_offset %rbx, -24
	testl	%edi, %edi
	jle	.LBB0_8
	movl	%edx, %r10d
	movl	$2147483647, %r11d
	subl	%edx, %r11d
	xorl	%ebx, %ebx
	jmp	.LBB0_4
	.p2align	4, 0x90
.LBB0_2:
	movl	%eax, %edi
.LBB0_3:
	addq	$1, %rbx
	cmpq	$200, %rbx
	je	.LBB0_10
.LBB0_4:
	movl	%edi, (%r9,%rbx,4)
	cmpl	$1, %edi
	je	.LBB0_9
	movl	%edi, %eax
	cltd
	idivl	%ecx
	testl	%edx, %edx
	je	.LBB0_2
	movl	%r11d, %eax
	cltd
	idivl	%esi
	cmpl	%edi, %eax
	jl	.LBB0_11
	imull	%esi, %edi
	addl	%r10d, %edi
	jmp	.LBB0_3
.LBB0_8:
	xorl	%ebx, %ebx
	jmp	.LBB0_12
.LBB0_9:
	addl	$1, %ebx
	movb	$1, %al
	jmp	.LBB0_13
.LBB0_10:
	movl	$200, %ebx
	jmp	.LBB0_12
.LBB0_11:
	addl	$1, %ebx
.LBB0_12:
	xorl	%eax, %eax
.LBB0_13:
	movl	%ebx, (%r8)
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	collatz, .Lfunc_end0-collatz
	.cfi_endproc

	.ident	"clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.4.0+2600+cefb5d4c)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
