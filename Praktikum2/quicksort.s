.data
field: .space 4000
length: .word 1000
XORstate: .word 12345
.text
main:	

	lw	t0, length	
	la	t1, field
	
	
randloop:
	addi t0,t0,-1
	## fill with random numbers from ecall
	li	a0,0
	li	a7,41
	ecall
	sw	a0,0(t1)
	addi 	t1,t1,4
	bnez 	t0,randloop
	
	jal	quicksort
	
	li	a7, 10
	ecall			# terminate




quicksort:

	jalr	zero, ra, 0

