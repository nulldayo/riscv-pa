.data
N: .word 10

.text
	lw a0, N				# Load N into a0
        
fibonacci:                             
        addi    sp, sp, -32     		# Reserve stack -32
        sw      ra, 28(sp)      		# Save ra into -4
        sw      s0, 24(sp)      		# Save s0 into -8
        addi    s0, sp, 32      		# s0 = old stack pointer
        sw      a0, -16(s0)     		# Save a0 into -16
        lw      a0, -16(s0)     		# Load -16 into a0
        mv      a1, zero	        	# Load 0 into a1 from zero
        bne     a0, a1, fibonacci_one   	# If (N != 0) jump to fibonacci_one
        j       fibonacci_zero	        	# Else jump to fibonacci_zero

fibonacci_zero:
        mv      a0, zero	        	# a0 = 0
        sw      a0, -12(s0)	        	# Store 0 into -12
        j       exit		        	# Jump to exit

fibonacci_one:
        lw      a0, -16(s0)	        	# Load -16(s0) into a0
        addi    a1, zero, 1	        	# a1 = 1
        bne     a0, a1, fibonacci_recursive	# if (N != 1) jump to fibonacci_recursive
        addi    a0, zero, 1	        	# a0 = 1
        sw      a0, -12(s0)	        	# Store 1 into -12
        j       exit			

fibonacci_recursive:
        lw      a0, -16(s0)	        	# Load -16(s0) into a0
        addi    a0, a0, -1	        	# n = n - 1
        call    fibonacci		
        lw      a1, -16(s0)	        	# Load -16(s0) into a1
        addi    a1, a1, -2	        	# n = n - 2
        sw      a0, -20(s0)	        	# Store a0 into -20(s0)
        add     a0, zero, a1	        	# a0 = a1
        call    fibonacci
        lw      a1, -20(s0)                     # Load -20(s0) into a1
        add     a0, a0, a1      		# a0 = a0 + a1
        sw      a0, -12(s0)     		# Store a0 into -12(s0)
        j       exit

exit:
        lw      a0, -12(s0)	        	# Load -12(s0) into a0
        li	a7, 1	        		# print_int
        ecall
        lw      s0, 24(sp)	        	# Restore s0
        lw      ra, 28(sp)	        	# Restore ra
        addi    sp, sp, 32	        	# Restore stack
        ret
