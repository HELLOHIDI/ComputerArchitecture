.text
.globl main
main:
    addi	$t0, $0, 7			# $t0 = $0 + $t2 (=7)
    addi	$t1, $0, 16			# $t0 = $0 + 0 (=16)
    sub		$t2, $t1, $t0		# $t2 = $t0 + $t1 (=9)
    addi	$t3, $t1, -7		# $t3 = $t1 + (-7) (=9)