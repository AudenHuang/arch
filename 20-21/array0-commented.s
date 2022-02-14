	.text
	.file	"array.c"
	.globl	contains
	.p2align	4, 0x90
	.type	contains,@function
contains:
	.cfi_startproc
	pushq	%rbp                        # Pushes address of base pointer from previous stack frame onto the stack
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp                  # Copies current address in stack pointer to base pointer, setting base pointer to top of the stack
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp                   # Reserve 48 bytes for a new stack frame by moving the stack pointer -48 bytes below the base pointer
	movq	%rdi, -16(%rbp)             # Copies the 'long* array' argument stored in the register for the first argument to -16 bytes below the base pointer in the stack
	movq	%rsi, -24(%rbp)             # Copies the 'long elem' argument stored in the register for the second argument to -24 bytes below the base pointer in the stack
	movl	%edx, -28(%rbp)             # Copies the 'int left' argument stored in the lower 32-bit register for the third argument to -28 bytes below the base pointer in the stack
	movl	%ecx, -32(%rbp)             # Copies the 'int right' argument stored in the lower 32-bit register for the fourth argument to -32 bytes below the base pointer in the stack
	movl	-32(%rbp), %eax             # %eax = right
	subl	-28(%rbp), %eax             # %eax = right - left
	cmpl	$1, %eax                    # Compares %eax to constant "1" and sets appropriate flags depending on result, for first if condition
	jge	.LBB0_2                         # Jump to .LBB0_2 (second if condition) if %eax is greater or equal to 1, by checking if sign and overflow flags are the same 
	movb	$0, -1(%rbp)                # Copies "0" (false) to -1 byte below the base pointer, essentially the boolean to be returned by the function 
	jmp	.LBB0_8                         # Jump to .LBB0_8
.LBB0_2:
	movl	-32(%rbp), %eax             # %eax = right
	subl	-28(%rbp), %eax             # %eax = right - left
	cmpl	$1, %eax                    # Compares %eax to constant "1" and sets appropriate flags depending on result, for second if condition
	jne	.LBB0_4                         # Jump to .LBB0_4 (else condition) if %eax is not equal to 1, by checking if zero flag is not set
	movq	-16(%rbp), %rax             # Copies address of 'long array' to return register 
	movslq	-28(%rbp), %rcx             # Copies 32-bit value of 'int left' to 64-bit %rcx by extending the integer sign bit, to use as index address for following instruction
	movq	(%rax,%rcx,8), %rax         # Copies value at index 'left' of the array to the return register
	cmpq	-24(%rbp), %rax             # Compares value of "elem" to the value from the array and sets appropriate flags
	sete	%dl                         # Sets lower 8-bits of 'd' register equivalent to byte representation of '1' (true) if zero flag is set, otherwise 0 (What does the instruction sete do in assembly?, 2018)
	andb	$1, %dl                     # Performs bitwise 'and' operations between lower 8-bits of register 'd' (%dl) and the constant '1', clearing all bits to 0 except for least significant bit, which may be 1 or 0 (true or false) 
	movb	%dl, -1(%rbp)               # Copies value of %dl to -1 byte below base pointer, which is the return boolean
	jmp	.LBB0_8                         # Jump to .LBB0-8
.LBB0_4:
	movl	-28(%rbp), %eax             # %eax = left
	movl	-32(%rbp), %ecx             # %ecx = right
	subl	-28(%rbp), %ecx             # %ecx = right - left
	movl	%eax, -40(%rbp)             # Copies value of 'left' in %eax to -40 bits below base pointer
	movl	%ecx, %eax                  # %eax = %ecx (right - left)
	cltd                                # Sign-extends most significant bit of %eax into %edx, converting double word to quad word in preparation for division (Roshi, 2013)
	movl	$2, %ecx                    # %ecx = 2
	idivl	%ecx                        # Divides quad word %edx:%eax by %ecx, storing quotient in %eax and remainder in %edx; %eax = (left - right ) / 2 (X86-assembly/Instructions/idiv - aldeid, 2021)
	movl	-40(%rbp), %ecx             # %ecx = left
	addl	%eax, %ecx                  # %ecx = left + %eax ('mid = left + (right - left) / 2' where %ecx previously held 'left' but is now used for 'mid')
	movl	%ecx, -36(%rbp)             # Store 'mid' at -36 bytes below the base pointer
	movq	-24(%rbp), %rsi             # %rsi = elem
	movq	-16(%rbp), %rdi             # %rdi = array
	movslq	-36(%rbp), %r8              # Converts 32-bit value of 'mid' to 64-bit by extending signed bit, and stores it in %r8 to be used as index array for following instruction 
	cmpq	(%rdi,%r8,8), %rsi          # Compares value at index 'mid' (%r8) of 'array' (%rdi) to elem and sets flags
	jge	.LBB0_6                         # Jumps to .LBB0_6 ('else' of ternary operator) if 'elem' is greater or equal to the array value at 'mid' (if sign and overflow flags are the same)
	movq	-16(%rbp), %rdi             # %rdi = array (copying array pointer in stack to first argument register in preparation for function call)
	movq	-24(%rbp), %rsi             # %rsi = elem (copying array pointer in stack to second argument register in preparation for function call)
	movl	-28(%rbp), %edx             # %edx = left (copying array pointer in stack to third argument register in preparation for function call)
	movl	-36(%rbp), %ecx             # %ecx = mid (copying array pointer in stack to fourth argument register in preparation for function call)
	callq	contains                    # Calls the contains function 
	andb	$1, %al                     # Performs bitwise and operation on %al with 1, clearing all bits to 0 except for least significant bit, which may be 1 or 0 (true or false)
	movzbl	%al, %ecx                   # %ecx = %al (most significant bits of %ecx are zero extended from %al)
	movl	%ecx, -44(%rbp)             # Stores boolean result of ternary expression function call at -44 bytes below the base pointer in the stack
	jmp	.LBB0_7                         # Jump to .LBB0_7
.LBB0_6:
	movq	-16(%rbp), %rdi             # %rdi = array (copying array pointer in stack to first argument register in preparation for function call)
	movq	-24(%rbp), %rsi             # %rsi = elem (copying array pointer in stack to second argument register in preparation for function call)
	movl	-36(%rbp), %edx             # %edx = mid (copying array pointer in stack to third argument register in preparation for function call)
	movl	-32(%rbp), %ecx             # %ecx = right (copying array pointer in stack to fourth argument register in preparation for function call)
	callq	contains                    # Calls the contains function
	andb	$1, %al                     # Performs bitwise and operation on %al with 1, clearing all bits to 0 except for least significant bit, which may be 1 or 0 (true or false)
	movzbl	%al, %ecx                   # %ecx = %al (most significant bits of %ecx are zero extended from %al)
	movl	%ecx, -44(%rbp)             # Stores boolean result of ternary expression function call at -44 bytes below the base pointer in the stack
.LBB0_7:
	movl	-44(%rbp), %eax             # %eax = the boolean result of the ternary expression
	cmpl	$0, %eax                    # Compares boolean result in %eax to '0' and sets appropriate flags
	setne	%cl                         # Sets lower 8-bits of 'c' register to byte equivalent of '1' (true) if zero flag is not set (previous comparison is not equal), otherwise 0
	andb	$1, %cl                     # Performs bitwise and operation on %cl with 1, clearing all bits to 0 except for least significant bit, which may be 1 or 0 (true or false)
	movb	%cl, -1(%rbp)               # Copies value of %cl to -1 byte below base pointer, which is the return boolean 
.LBB0_8:
	movb	-1(%rbp), %al               # %al = value of return boolean
	andb	$1, %al                     # Performs bitwise and operation on %al with 1, clearing all bits to 0 except for least significant bit, which may be 1 or 0 (true or false)
	movzbl	%al, %eax                   # Sign extends %al to %eax, leaves boolean value in return register
	addq	$48, %rsp                   # Release stack frame by moving stack pointer 48 bytes up
	popq	%rbp                        # Pop the base pointer from the previous stack frame back into %rbp
	.cfi_def_cfa %rsp, 8
	retq                                # Return the function
.Lfunc_end0:
	.size	contains, .Lfunc_end0-contains
	.cfi_endproc

	.ident	"clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym contains
