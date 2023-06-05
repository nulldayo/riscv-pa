.data
STR: .asciz "ABCD"

.text
main:
	la t0, STR			# Load address of STR
#	jal strlen

strlen:
	li t1,0				# Initialize the count to zero
	loop:
		lb t2, 0(t0)	# Load the next character into t2
		beqz t2, exit	# Check for the null character
		addi t0, t0, 1	# Increment the string pointer
		addi t1, t1, 1	# Increment the count
		j loop
exit:
	sw t1,STR,t0		# Store t1 into STR using t0 as temporary
	lw a0,STR			# Load word of STR
	li a7, 1			# syscall 1 = print_int
	ecall				# Print a0
	li a7, 10			# terminate syscall
	ecall				# end
