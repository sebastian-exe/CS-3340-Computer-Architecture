#Sebastian Moreno, SXS170103, 3340.004
#Homework 3
.data
	height: .word 0
	weight: .word 0
	BMI: .double 0.0
	underweight: .double 18.5
	normalweight: .double 25.0
	overweight: .double 30.0
	
      name: .space 20

      promptName: .asciiz	"What is your name? "
      promptHeight: .asciiz	"Please enter your height in inches: "
      promptWeight: .asciiz	"Now enter your weight in pounds (round to the nearest whole number): "
      promptBMI: .asciiz 	", your BMI is: "
      promptUnderweight: .asciiz "This is considered underweight." 
      promptNormalweight: .asciiz "This is considered normalweight."
      promptOverweight: .asciiz "This is considered overweight."
      promptObese: .asciiz "This is considered obese."
	
.text
      #print the prompt name
	li	$v0, 4
	la	$a0, promptName
	syscall

	#read in name
	li	$v0, 8
	la	$a0, name
	li      $a1, 19
	syscall
	
	#add code to remove the newline character
	li $s0, 0
	
remove:	#trim newline
	lb $a3, name($s0)      # Load character at index
	addi $s0, $s0, 1        # Increment index
	bnez $a3, remove    # Loop until the end of string is reached
	subiu $s0,$s0,2     # Backtrack index to '\n'
	sb $0, name($s0)        # Add the terminating character in its place
	
	# prompt for height
	li	$v0, 4
	la	$a0, promptHeight
	syscall

	# read in height 
	li	$v0, 5
	syscall

	#store height
	sw $v0, height


	# prompt for weight
	li	$v0, 4
	la	$a0, promptWeight
	syscall

	# read in weight
	li	$v0, 5
	syscall

	#store weight
	sw $v0, weight

	#load the values of the weight and the height into argument registers
	lw $a0, height
	lw $a1, weight
	
	#jump the the calcBMI function
	jal calcBMI
	
	#print the name entered
	li	$v0, 4
	la	$a0, name
	syscall
	
	#print the promptBMI
	li	$v0, 4
	la	$a0, promptBMI
	syscall
	
	#print the BMI
	li	$v0, 3
	ldc1    $f12, BMI
	syscall 
	
	#add a newline
	li $v0, 11
	li $a0, '\n'
	syscall

	#setting the value of 18.5 into the FPR of f8
	l.d $f8, underweight
	l.d $f10, normalweight
	l.d $f14, overweight
	
	
	#now lets start the comparisons for the outputs
	c.lt.d $f6, $f8 #compare BMI < 18.5
	bc1t printUnderweight
	
	c.lt.d $f6, $f10 #compare BMI < 25.0
	bc1t printNormalweight
	
	c.lt.d $f6, $f14  #compare BMI < 30.0
	bc1t printOverweight
	
	
	
	#if the bmi doesn't fall into any of the test cases, print the overweight
	#print the prompt obese
	li	$v0, 4
	la	$a0, promptObese
	syscall
	
	

	j exit

calcBMI: #with the height and weight calcuate the BMI
	
	 #storing the value of 703 into a temporary register
	addi $t0, $zero, 703
	
	#height * height
	mult $a0, $a0
	mflo $t1 #holds the value of height * height
	
	#take the weight and multipy it by 703
	mult $a1, $t0
	mflo $t2 #holds the value of the weight * 703
	
	
	#convert the height^2 to a double
	mtc1.d $t1, $f2
	cvt.d.w $f2, $f2
		
	#convert the weight*703 to as double
	mtc1.d $t2, $f4
	cvt.d.w $f4, $f4	
	
	#divide the weight by the height
	div.d $f6, $f4, $f2
	
	
	#load the value of $f6(BMI) into the BMI
	sdc1 $f6, BMI
	jr $ra


printUnderweight: #print the underweight output
	
	li	$v0, 4
	la	$a0, promptUnderweight
	syscall
	j exit

printNormalweight: #print the normalweight output
	
	li	$v0, 4
	la	$a0, promptNormalweight
	syscall
	j exit
	
printOverweight: #print the overweight output
	
	li	$v0, 4
	la	$a0, promptOverweight
	syscall
	j exit

	
exit:
	li $v0, 10
	syscall
