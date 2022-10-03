.text
.globl main

main:
    addi $t1, $0, 0x3c00
    addi $t2, $0, 0x0DC0

    and $t0, $t1, $t2
    andi $t3, $t1, -1 # $t3 = $t1

    or $t4, $t1, $t2
    ori $t5, $t1, 0 # $t5 = $t1

    nor $t6, $t1, $t2
    nor $t7, $t1, $t1 # $t7 = not $t1

    ori $s0, $0, 9 # $s0 = 9
    sll $t2, $s0, 4 # $t2 = $s0 * 2^4
    srl $t4, $t2, 2 # $t4 = $t2 / 2^2

    