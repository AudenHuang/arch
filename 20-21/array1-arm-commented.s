	.text
	.file	"array.c"
	.globl	contains
	.p2align	2
	.type	contains,@function
contains:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!               ; Store the current value of the frame (base) pointer and the link register at -16 bytes below the stack pointer (sp) then decrement sp by 16 bytes (A Guide to ARM64 / AArch64 Assembly on Linux with Shellcodes and Cryptography, 2018)
	mov	x29, sp                             ; x29 = stack pointer
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sub	w8, w3, w2                          ; w8 = w3 ('right') - w2 ('left')
	cmp	w8, #1                              ; Compare 'right - left' (w8) with '1' and set flags
	b.lt	.LBB0_3                         ; Jump to .LBB0_3 (return false) if 'right - left' is less than 1 (checks if negative and overflow flag are different)
	b.ne	.LBB0_4                         ; Jump to .LBB0_4 (else condition) if 'right - left' is not equal to 1 (checks if zero flag is not set)
	ldr	x8, [x0, w2, sxtw #3]               ; x8 = 'array[left]' (x0 = array, w2 = left) (sign extend w2 to x2, and multiply x2 by 8 (shift left by 3, 2^8)) (Documents Hub, 2021)
	cmp	x8, x1                              ; Compares x8 (elem) to x1 (array[left]) and set flags
	cset	w0, eq                          ; Set w0 (overwrite 'long* array' to return boolean) to 1 if x8 and x1 are equal, otherwise 0 (checks zero flag)
	b	.LBB0_8                             ; Jump to .LBB0_8 (return)
.LBB0_3:
	mov	w0, wzr                             ; w0 = 0, setting return register w0 to 'false' (overwrites x0 from 'long* array' to the return register)
	b	.LBB0_8                             ; Jump to .LBB0_8 (return)
.LBB0_4:
	cmp	w8, #0                              ; Compare 'right - left' (w8) with '0' and set flags
	cinc	w8, w8, lt                      ; Increment w8 by 1 if w8 is less than '0' (checks if negative and overflow differ) otherwise leave w8 as it is
	add	w8, w2, w8, asr #1                  ; w8 (mid) = left (w2) + w8 ( (right - left) / 2 ) (asr #1 shifts w8 to the right by 1, halving w8)
	ldr	x9, [x0, w8, sxtw #3]               ; x9 = array[mid] (sign extend w8 to x8 and multiply by 8 (see above))
	cmp	x9, x1                              ; Compare x9 (array[mid]) to x1 (elem) and set flags
	b.le	.LBB0_6                         ; Jump to .LBB0_6 (second branch of ternary expression)) if x9 (array[mid]) is less than or equal to x1 (elem) (checks if zero flag is set or if negative and overflow flags differ)
	mov	w3, w8                              ; w3 (right) = w8 (mid) (moves the value of mid into register for 'right' argument for recursive call)
	b	.LBB0_7                             ; Jump to .LBB0_7 (recursive call)
.LBB0_6:
	mov	w2, w8                              ; w2 (left) = w8 (mid) (moves the value of mid into register for 'left' argument for recursive call)
.LBB0_7:
	bl	contains                            ; Recursive call to contains
.LBB0_8:
	and	w0, w0, #0x1                        ; Performs bitwise and operation between w0 and '1' and saves value to w0, setting w0 to either true or false by clearing all bits to zero except first bit
	ldp	x29, x30, [sp], #16                 ; load frame pointer and link register values from previous stack frame located at sp and back into respective registers, then increment sp by 16 bytes
	ret                                     ; Return function
.Lfunc_end0:
	.size	contains, .Lfunc_end0-contains
	.cfi_endproc

	.ident	"clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
