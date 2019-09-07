#Sebastian Moreno, SXS170103, 3340.004
#Homework 1
.data
	a: .word 0
	b: .word 0
	c: .word 0

	ans1: .word 0
	ans2: .word 0
	ans3: .word 0

      username: .space 20

      promptName: .asciiz	"Please enter your name: "
      promptInt: .asciiz	"Please enter an integer 1 - 100: "
      promptAns: .asciiz	"Your numbers are: "

.text
      # print the prompt name
	li	$v0, 4
	la	$a0, promptName
	syscall

	# read in username
	li	$v0, 8
	la	$a0, username
	li      $a1, 19
	syscall

	# prompt for number
	li	$v0, 4
	la	$a0, promptInt
	syscall

	# read in int(a)
	li	$v0, 5
	syscall

	#store int (a)
	sw $v0, a


	# prompt for number
	li	$v0, 4
	la	$a0, promptInt
	syscall

	# read in int(b)
	li	$v0, 5
	syscall

	#store int (b)
	sw $v0, b

	# prompt for number
	li	$v0, 4
	la	$a0, promptInt
	syscall

	# read in int(c)
	li	$v0, 5
	syscall

	#store int (c)
	sw $v0, c

	#loading a,b,c from memory
	lw $t0, a

	lw $t1, b

	lw $t2, c

	#calc answer 1
	add $t4, $t0, $t0
	sub $t4, $t4, $t1
	addi $t4, $t4, 9

	#storing calc 1 into memory
	sw  $t4, ans1

	#calc answer 2
	sub $t4, $t2, $t1
	addi $t5, $t0, -5
	add $t6, $t4, $t5

	#store calc 2 into memory
	sw $t6, ans2

	#calc answer 3
	addi $t4, $t0, -3
	addi $t5, $t1, 4
	addi $t6, $t2, 7

	#combine registers
	add $t7, $t4, $t5
	sub $t7, $t7, $t6

	#store into label
	sw $t7, ans3


	# print the username entered
	li	$v0, 4
	la	$a0, username
	syscall

	# print the prompt for the answers entered
	li	$v0, 4
	la	$a0, promptAns
	syscall

	#print the answer 1
	li	$v0, 1
	lw	$a0, ans1
	syscall

	#print a space
	li	$v0, 11
	li	$a0, ' '
	syscall

	#print the answer 1
	li	$v0, 1
	lw	$a0, ans2
	syscall

	#print a space
	li	$v0, 11
	li	$a0, ' '
	syscall

	#print the answer 1
	li	$v0, 1
	lw	$a0, ans3
	syscall

	#print a space
	li	$v0, 11
	li	$a0, ' '
	syscall
	
	#Test case 1:
	#Please enter your name: sebastian
	#Please enter an integer 1 - 100: 15
	#Please enter an integer 1 - 100: 25
	#Please enter an integer 1 - 100: 35
	#sebastian
	#Your numbers are: 14 20 -1 
	
	#Test case 2:
	#Please enter your name: Please enter your name: sebastian
	#Please enter an integer 1 - 100: 50
	#Please enter an integer 1 - 100: 89
	#Please enter an integer 1 - 100: 32
	#sebastian
	#Your numbers are: 20 -12 101 
	
		
	#exit
	li $v0, 10
	syscall
