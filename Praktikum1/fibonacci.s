.data
N: .word 10						# int N=10;

.text

fib_start:
	lw a0, N					# Load a0=N(10)
	addi t0, a0, -2				# Count of steps
	
	bltz t0, fib_end			# for n-2
	ori t1, zero, 1				# f(n-1)=1
	ori t2, zero, 0				# f(n-2)=0
fib_loop:
	add a0, t1, t2				# f(n)=compute from older values
	beq t0, zero, fib_end		# If last run, return a0
	ori t2, a0, 0				# t2 has now f(n-1),t1 has f(n-2)
	addi t0, t0, -1				# Counter -1
	add a0, t1, t2				# f(n)=compute from older values
	beq t0, zero, fib_end		# If last run, return a0
	ori t1, a0, 0				# t2 has now f(n-2) again, t1 has f(n-1)
	addi t0, t0, -1				# Counter -1
	j fib_loop

fib_end:
	li a7, 1					# syscall 1 = print_int
	ecall						# print a0(fib)
	li a7, 10					# terminate syscall
	ecall						# end