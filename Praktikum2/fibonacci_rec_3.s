.data
N: .word 10

.text
	lw a0,N				# Load N into a0

main:
        sw      ra, 12(sp)		# Save return address into +12
        sw      s0, 8(sp)		# Save s0 into +8
        addi    s0, sp, 16		# Load sp+16 into s0
        li      a0, 0			# Load 0 into a0
        sw      a0, -12(s0)		# Store a0 into sp+4
        li	a0, 10			# Load 10 into a0
        sw      a0, -16(s0)		# Store content of a0 into sp
        lw      a0, -16(s0)		# Load content of sp into a
        call    fibonacci
        
        lw      s0, 8(sp)		# Load 8 into s0
        lw      ra, 12(sp)		# Load 12 into ra
        addi    sp, sp, 16		# Restore stack pointer
        
        li	a7,1			# ecall 1 = print_int
        ecall				# Print a0
        li	a7,10			# ecall 10 = terminate
        ecall				# end
        
fibonacci:
        addi    sp, sp, -32		# Reserve stack
        sw      ra, 28(sp)		# Save ra into -4
        sw      s0, 24(sp)		# Save s0 into -8
        addi    s0, sp, 32		# s0 gets old stack pointer
        sw      a0, -16(s0)		# Store a0 into -16(s0)
        lw      a0, -16(s0)		# Load -16(s0) into a0
        li	a1, 0			# a1 = 0
        bne     a0, a1, fib_one		# If (a0 != 0) jump to fib_one
        j       fib_zero		# Else jump to fib_zero

fib_zero:
        li	a0, 0			# a0 = 0
        sw      a0, -12(s0)		# Store a0 into -12(s0)
        j       fib_add			# Jump to fib_add

fib_one:
        lw      a0, -16(s0)		# Load -16(s0) into a0
        li	a1, 1			# Load 1 into a1
        bne     a0, a1, fib_rec		# If (a0 == 1) jump to recursive
        li	a0, 1			# Load 1 into a0		
        sw      a0, -12(s0)		# Store a0 into -12(s0)
        j       fib_add                 # Jump to fib_add

fib_rec:
        lw      a0, -16(s0)		# Load -16(s0) into a0
        addi    a0, a0, -1		# n = n - 1
        call    fibonacci
        
        lw      a1, -16(s0)		# Load -16(s0) into a1
        addi    a1, a1, -2		# n = n - 2
        sw      a0, -20(s0)		# Store a0 into -20(s0)
        add     a0, zero, a1		# a0 = a1
        call    fibonacci
        
        lw      a1, -20(s0)		# Load -20(s0) into a1
        add     a0, a0, a1		# a0 = a0 + a1
        sw      a0, -12(s0)		# Store a0 into -12(s0)
        j       fib_add
        
fib_add:
        lw      a0, -12(s0)		# Load -12(s0) into a0
        lw      s0, 24(sp)		# Load 24(sp) into s0
        lw      ra, 28(sp)		# Load 28(sp) into ra
        addi    sp, sp, 32		# Restore stack pointer
        ret				# Jump to ra
