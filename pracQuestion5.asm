.data


a:	.word 5, 9, 2, 1, 4, 6, 3, 9, 2, 1
len:	.word 10
	
	#for(i = 0; i < 10; i++)
		#a[i] += 5
	
	.text
main:
	#$s0 = i
	li $s0, 0
	


	la $s1, a #loading the address of a into register $s1
loop:	
	#add 5 to array a but through the i($s0) index
	

	lw $s2, 0($s1) #load the first byte from the array into register $s2
	addi $s2, $s2, 5 #increment the byte by 1
	sw $s2, 0($s1) #store the new value into memory
	addi $s1, $s1, 4  #increment the register by one to point to the next element in the array
	
	
	#increment i 
	addi $s0, $s0, 1
	
	#if $s0(i) < 10 loop
	blt  $s0, 10, loop
	
	#put the register back into a

exit:

	li $v0, 10
	syscall
