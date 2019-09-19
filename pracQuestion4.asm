.data


c:	.word 0
	
	#for(i = 0; i < 10; i++)
		#c+= 5
	
	.text
main:
	#$s0 = i
	li $s0, 0
	
	#load in c
	lw $s1, c
loop:	
	#add 5 to c
	addi  $s1, $s1, 5
	
	#increment i 
	addi $s0, $s0, 1
	
	#if $s0(i) < 10 loop
	blt  $s0, 10, loop
	
	#put the register back into c
	sw $s1, c

exit:

	li $v0, 10
	syscall
