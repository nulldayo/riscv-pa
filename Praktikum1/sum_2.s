.data
N: .word 1000 # int N = 1000;
SUM: .word 0 # int SUM = 0;
INC: .word 0 # int INC = 0;

.text
main:
lw t0,N # load N
lw t1,SUM # load SUM
lw t2,INC # load INC

loop:
addi t2,t2,1 # INC=INC+1
add t1,t1,t2 # SUM=SUM+INC
bne t2,t0,loop # goto loop if INC!=N

exit:
sw t1,SUM,t2 # store content of t1 into label SUM using t2 as temporary
li a7,1 #syscall 1 = print_int
lw a0,SUM #load variable SUM
ecall #print SUM

li a7,10 #terminate syscall
ecall