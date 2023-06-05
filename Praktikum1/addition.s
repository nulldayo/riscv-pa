.data
A: .word 1                      # int A=1;
B: .word 2                      # int B=2;
C: .word 0                      # int C=0;

.text
main:
lw x1, A                        # Load A

lw x2, B                        # *** Load B
lw x3, C                        # *** Load C

add x3, x1, x2                  # *** t2=t0+t1
sw x3, C, a0                    # Store content of t2 into label C using a0 as temporary

li a7, 1                        # syscall 1 = print_int
lw a0, C                        # Load variable C
ecall                           # print C

li a7, 10                       # Terminate syscall
ecall
