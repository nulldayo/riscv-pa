.data
N: .word 3

.text
lw a0,N

sum:
	addi sp,sp,-8		# reserve stack for $ra and $a0
	sw ra,0(sp)		# save return address
	bgt a0,zero,recursion	# if $a0>0 goto recursion
	li a0,0			# set return value to zero
	j exit			# jump to exit
	
recursion:
	sw a0,4(sp)			# save argument $a0 on stack
	addi a0,a0,-1			# set argument n=n-1
	jal ra,sum			# recursive call to sum
	lw t1,4(sp)			# restore argument from stack
	add a0,a0,t1			# sum n + return value

exit:
	li a7,1				#syscall 1 = print_int
	ecall				#print SUM

	lw ra,0(sp)			# restore return address
	addi sp,sp,8			# restore stack pointer
	jalr zero,ra,0			# return

	li a7,10 #terminate syscall
	ecall
