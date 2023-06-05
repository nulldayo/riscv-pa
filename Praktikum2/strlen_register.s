.data
A: .asciz "ABCDEF"
B: .asciz "The quick brown fox jumps over the lazy dog"
LF: .asciz "\n"

.text

main:
	addi	sp, sp, -4
	sw	ra, 0(sp)
	la	s0, LF				# Load LF into s0
	la	a0, A				# Load A into a0
	jal	ra, strlen
	
	li	a7, 1				# ecall 1 = print_int
	ecall
	
	mv	a0, s0				# Line feed string into input register
	li	a7, 4				# ecall 4 = print_string
	ecall

	la	a0, B				# Load B into a0
	jal	ra, strlen
	
	li	a7, 1				# ecall 1 = print_int
	ecall
	
	lw	ra, 0(sp)			# Restore return address
	addi	sp, sp, 4		# Free stack space
	li	a7, 10				# terminate ecall
	ecall					# end
	
strlen:
	li	t0, 0				# Initialize the count to zero
	loop:
		lb	t2, 0(a0)		# Load the next character into t2
		beqz	t2,exit 	# Check for the null character
		addi	a0, a0, 1 	# Increment the string pointer
		addi	t0, t0, 1	# Increment the count
		j	loop
		
exit:
	addi	a0,t0,0			# Length of string into a0
	jalr	zero,ra,0		# Jump to ra
