.data

a:	.word 4
	.text
	
main:

	lw $s1, a
	
	bge $s1, $zero, exit
	#if a is less than zero, then we will fall to the next instruction
	sub $s1, $zero, $s1
	#addi $s1, $s1, 0
	
	sw  $s1, a
	
  	#print a
  	li $v0, 1
  	lw $a0, a
  	syscall

exit:

	li $v0, 10
	syscall
