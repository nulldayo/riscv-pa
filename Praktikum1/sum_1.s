.data
N: .word 1000                   # int N = 1000;
SUM: .word 0                    # int SUM = 0;

.text
main:
lw t0, N                        # Load N
lw t1, SUM                      # Load SUM
li t2, 0                        # Initialize Counter

loop:
addi t2, t2, 1                  # CNT = CNT + 1
add t1, t1, t2                  # SUM = SUM + CNT
bne t2, t0, loop                # Goto loop if CNT != N

exit:
sw t1, SUM, t2                  # Store content of t1 into label SUM using t2 as temporary
li a7, 1                        # syscall 1 = print_int
lw a0, SUM                      # Load variable SUM
ecall                           # Print SUM

li a7, 10                       # terminate syscall
ecall
