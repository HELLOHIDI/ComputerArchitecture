.text
.globl main
main:
    addi $t0, $0, 2 
    addi $t1, $0, 3
    div $t0, $t1
    mflo $t2
    mfhi $t3