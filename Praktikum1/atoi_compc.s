.data

STR: .asciz "12345678"
R: .word 0

.text
main:
	la a0, STR                      # load address of STR
	jal ft_atoi
ft_atoi:                                # ft_atoi
        addi    sp, sp, -32
        sw      ra, 28(sp)
        sw      s0, 24(sp)
        addi    s0, sp, 32
        sw      a0, -12(s0)
        mv      a0, zero
        sw      a0, -16(s0)
        sw      a0, -20(s0)
        j       .LBB0_1

exit:
	sw t1, R, t0                    # store t1 into STR using t0 as temporary
	lw a0, R                        # load word of STR
	li a7, 1                        # syscall 1 = print_int
	ecall                           # print a0
	li a7, 10                       # terminate syscall
	ecall                           # end