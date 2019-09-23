 #Sebastian Moreno, SXS170103, 3340.004
#Homework 2
.data
	prompt: .asciiz "Enter some text"
	goodbye: .asciiz "Goodbye "
	niceDay: .asciiz "have a nice day"
	words: .asciiz " words"
	chars: .asciiz " characters"
	save: .word 50 
	input: .space 50 #holds saved word
	numChar: .word 0 #hold number of char
	numSpace: .word 0 #holds number of space
.text

 main:     	
 
 	li $v0, 54       #display dialog box and prompt the input
	la $a0, prompt
	la $a1, input
	lw $a2, save
	syscall 
	
	beq $a1, -2, exit
	beq, $a1, -3, exit
	beq $a1, -4, exit
	
	
	jal sumCount
	
	sw $v0, numChar
	
	addi $v1, $v1, 1
	sw $v1, numSpace
	
	# output entered string
	li	$v0, 4 
	la	$a0, input
	syscall	
	
	#output the number of words
	li	$v0, 1
	la	$a0, ($v1)
	syscall
	
	# output the word " word"
	li	$v0, 4
	la	$a0, words
	syscall

	#print a space
	li	$v0, 11
	li	$a0, ' '
	syscall


	# output num of chars string
	li	$v0, 1
	la	$a0, ($t1)
	syscall
	
	# output the word " characters"
	li	$v0, 4
	la	$a0, chars
	syscall

	
	j main
	

sumCount:	#count the characters and the number of words in a string
	
	la $t0, input
	li $t1, 0 #this register will be used as a char counter
	li $t2, 0 #this register will be used as word counter
	
loop:
	lb $a0, 0($t0)
	beq  $a0, '\0', done
	beq $a0, '\n', done
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	
	beq $a0,' ', space #if a space is found, jump to space
	j loop
	
space: 
	addi $t2, $t2, 1 #increment one to the word counter
	j loop #loop back to the loop
	
done:
      add $v0, $zero, $t1
      add $v1, $zero, $t2
      
      
      add $s0, $zero, $t1 #set the $t1 register to s0 register to have something to add to the stack
      
      addi $sp, $sp, -4 #push onto the stack
      sw   $s0, 0($sp)
      
      lw $s0, 0($sp) #pop from the stack
      addi $sp, $sp, 4
      
      jr $ra

exit: 
	
	
	li $v0, 59       #display dialog box and prompt the input
	la $a0, goodbye
	la $a1, niceDay
	syscall 

	li $v0, 10
	syscall
