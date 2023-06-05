.data
A: .asciz "ABCDEF"
B: .asciz "The quick brown fox jumps over the lazy dog"
LF: .asciz "\n"

.text

main:
	addi	sp, sp, -8
	sw	ra, 0(sp)			# Store return address into 0(sp)
	la	s0, LF				# Load address of LF into s0
	la	a0, A				# Load address of A into a0
	sw	a0, 4(sp)			# Store address of A into 4(sp)
	jal	ra, strlen
	
	li	a7, 1				# ecall 1 = print_int
	ecall
	
	mv	a0, s0				# Line feed string into input register
	li	a7, 4				# ecall 4 = print_string
	ecall

	la	a0, B				# Load B into a0
	sw	a0, 4(sp)			# Store address of B into 4(sp)
	jal	ra, strlen
	
	li	a7, 1				# ecall 1 = print_int
	ecall
	
	lw	ra, 0(sp)			# Restore return address
	addi	sp, sp, 8		# Free stack space
	li	a7, 10				# terminate ecall
	ecall					# end
	
strlen:
	li	t0, 0				# Initialize the count to zero
	lw	t1, 4(sp)			# Load contents of 4(sp) into t1
	loop:
		lb	t2, 0(t1)		# Load the next character into t2
		beqz	t2,exit 	# Check for the null character
		addi	t1, t1, 1 	# Increment the string pointer
		addi	t0, t0, 1	# Increment the count
		j	loop
		
exit:
	addi	a0, t0, 0		# Length of string into a0
	jalr	zero, ra, 0		# Jump to ra
