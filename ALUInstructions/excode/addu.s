.text
.globl main
main:
    addi $t1, $0, 0x7fffffff
    add $t2, $t1, $t1   # overflow
    addu $t3, $t1, $t1  # no exception
    addiu $t4, $t1, -1   # negative constant for addiu