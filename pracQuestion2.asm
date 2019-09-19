.data

a:	.word  -4
	.text
	
	#if(a > 0) a = -a
main:
	lw $s0, a
	
	ble $s0, $zero, exit
	sub $s0, $zero, $s0
	
	sw $s0, a
	#print out the value of a
	
	li $v0, 1
	lw $a0, a
	syscall

exit:

	li $v0, 10
	syscall
