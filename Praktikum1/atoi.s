.data
STR: .asciz "12345678"
R: .word 0

.text
main:
	la t0, STR				# Load address of STR
	lw t1, R				# Load Number as 0
	li t3, 10				# Load t3 = 10

atoi:
	lb t2, 0(t0)			# Load next character into t2
	beqz t2, exit			# If t2 = null character jump to exit
	addi t0, t0, 1			# Increment the string pointer
	addi t2, t2, -48		# STR = STR - 48
	mul t1, t1, t3			# num = num * 10
	add t1, t1, t2			# num = num + STR
	j atoi

exit:
	sw t1, R, t3			# Store t1 into R using t3 as temporary
	lw a0, R				# Load R into a0
	li a7, 1				# syscall 1 = print_int
	ecall					# Print a0	
	li a7, 10				# terminate syscall
	ecall					# end
