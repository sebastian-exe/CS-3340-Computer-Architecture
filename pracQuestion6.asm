.data


s1 	.asciiz "hi"
	.align 2	#align next data item on specified byte boundary(word)
s2	.space 4
	
	#while(s2[i] = s1[i] != '/0') i ++
	#read s1 into s2 until it is the null 
	.text
main:
	#store s1 into register s1
	la $s1, s1
	la $s2, s2
	li $s3, 1

loop:
	beq $s3, $zero, exit
	lb $s3, 0($s1)
	sb $s3, 0($s2)	
 	addi $s1, $s1, 1
 	addi $s2, $s2, 1
	
	j loop
exit:

	li $v0, 10
	syscall
