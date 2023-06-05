.data
N: .word 10

.text
main:
	addi	sp, sp, -12
        sw      ra, 8(sp)		# Save return address into -4
        sw      s0, 4(sp)		# Save s0 into -8
        
	lw	a0,N					# Load N into a0
	li	t0,1					# t0 = 1
        call    fib				# Jump to fib
        
        lw      s0, 4(sp)		# Load -8 into s0
        lw      ra, 8(sp)		# Load -4 into ra
        addi	sp, sp, 12
        
	mv	a0,a1					# Put the result into a0
        li	a7,1				# ecall 1 = print_int
        ecall					# Print a0
        li	a7,10				# ecall 10 = terminate
        ecall					# end

fib:
	bgt	a0, t0, recursive		# If (a0 > 1) jump to recursive
	mv	a1, a0					# Move a0 into a1
	jr	ra

recursive:
	addi	sp, sp, -12			# Reserve space
	sw	ra, 0(sp)				# Save ra in -12
	
	sw	a0, 4(sp)				# Save N in -8
	addi	a0, a0, -1			# n = n - 1
	jal	fib
	lw	a0, 4(sp)				# Restore N from -8
	sw	a1, 8(sp)				# Save return value f(n-1) in -4
	
	addi	a0, a0, -2			# n = n - 2
	jal	fib
	
	lw	t1, 8(sp)				# Restore return value f(n-1) from -4
	add	a1, a1, t1				# !return value!
	
	lw	ra, 0(sp)				# Restore return address from -12
	addi	sp, sp, 12			# Restore stack pointer	
	jr	ra
