.text
.globl main
main:
    addi	$t0, $0, 7		# $t0 = $0 + $t2
    addi	$t1, $0, 16			# $t0 = $0 + 0
    add		$t2, $t0, $t1		# $t2 = $t0 + $t1    