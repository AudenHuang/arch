	.text
	.file	"array.c"
	.globl	contains
	.p2align	4, 0x90
	.type	contains,@function
contains:
	.cfi_startproc
	jmp	.LBB0_1                         # Jump to .LBB0_1
	.p2align	4, 0x90
.LBB0_7:
	movl	%r8d, %edx                  # %edx = 'mid' (%edx was 'left') sets third argument register to 'mid' for recursive call to contains 
.LBB0_1:
	movl	%ecx, %r8d                  # %r8d = right
	subl	%edx, %r8d                  # %r8d = right - left (also sets zero, sign, and overflow flags)
	jle	.LBB0_8                         # Jump to .LBB0_8 (return false) if 'right' is less than or equal to 'left' (first if condition), if sign and overflow flag are not the same
.LBB0_3:
	cmpl	$1, %r8d                    # Compares 'right - left' to 1 and sets flags
	je	.LBB0_4                         # Jump to .LBB0_4 (second if condition) if equal, by checking if zero flag is set
	shrl	%r8d                        # '%r8d = (right - left) / 2' Shift bits right by one in register %r8d, dividing value by two
	addl	%edx, %r8d                  # %r8d += 'left' (%r8d = left + (right - left) / 2 ; %r8d = mid)
	movslq	%r8d, %rax                  # Convert double word %r8d to quad word by sign extending, then store in %rax to use as array index in following instruction (What does movslq do?, 2019)
	cmpq	%rsi, (%rdi,%rax,8)         # Compare 'array[mid]' to 'elem' (%rsi) and sets flags
	jle	.LBB0_7                         # Jump to .LBB0_7 (else of ternary expression) if 'array[mid]' is less than or equal to 'mid', if sign and overflow flag are not the same
	movl	%r8d, %ecx                  # %ecx = 'mid' (%ecx was 'right')
	subl	%edx, %r8d                  # %r8d = 'right' (mid) - 'left' (%r8d is now 'right' in the first recursive call to contains)
	jg	.LBB0_3                         # Jump to .LBB0_3 (just before second if condition) if 'right' is greater than 'left'
.LBB0_8:
	xorl	%eax, %eax                  # Exclusive or bitwise operation performed on return register with itself, which clears register to 0s and represents false
	retq                                # Return function
.LBB0_4:
	movslq	%edx, %rax                  # Convert double word %edx (left) to quad word by sign extending, then store in %rax to use as array index in following instruction
	cmpq	%rsi, (%rdi,%rax,8)         # Compare 'array[left]' to 'elem' and sets flags
	sete	%al                         # Set return register %al to byte representation of '1' if previous comparison is equal (zero flag is set), and '0' otherwise
	retq                                # Return function
.Lfunc_end0:
	.size	contains, .Lfunc_end0-contains
	.cfi_endproc

	.ident	"clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
