.data
STR: .asciz "Hello World!"
.text
main:	
la 	a0, STR 	   # Load Address of STR

li 	   a7, 4 	   # syscall 4 = print_string
ecall	 		   # print strl
li     a7,10       # terminate syscall
ecall	