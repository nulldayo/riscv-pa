
.text
j main
addX:
add a0, a0, a1
jr ra

main:
addi sp, sp, -8
sw ra, 4(sp)
sw s0, 0(sp)

li a0, 1
li a1, 2
jal ra, addX
add s0, zero, a0

lw s0, 0(sp)
lw ra, 4(sp)
addi sp, sp, 8

li a7,1			# syscall 1 = print_int
ecall			# print a0	
li a7,10		# terminate syscall
ecall			# end