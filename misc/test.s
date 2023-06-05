.data
A: .asciz "ABCD"
B: .asciz "The quick brown fox jumps over the lazy dog"
LF: .asciz "\n"

.text

la a0, A
li a7, 4		# ecall 4 = print_string
ecall

li a7, 10		# terminate ecall
ecall			# end