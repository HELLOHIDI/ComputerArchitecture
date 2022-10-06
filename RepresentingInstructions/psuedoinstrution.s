.text
.globl main
main:

    #li register constant = ori register, 0 , constant

    li $10, 1 #load immediate instrution
    ori $9, 0, 1

    addi $7, $0, 0x03030770

    lui $6, 0x0303
    ori $6, $6, 0x0770