#Sebastian Moreno, SXS170103, 3340.004
#Homework 5
.data
	fin : .asciiz "input.txt" #filename for input
	prompt: .asciiz "Enter input text filename: "
	arrayBefore: .asciiz "The array before:\t"
	arrayAfter: .asciiz "The array after: \t"
	promptMean: .asciiz "the mean is: "
	promptMedian: .asciiz "The median is: "
	promptStanDev: .asciiz "The standard deviation is: "
	newline : .asciiz "\n"
	space : .asciiz " "
	buffer: .space 80
	intarray: .word 20

.text

   	la $a0,fin		#loading the address of the input file into $a0
   	la $a1, buffer       #loading the address of the buffer into $a1
   
  	jal readFile                  
   	beq $v0,$0,exit                  # Exit if file can't be opened

  	la $a0, intarray                # address of integer array
  	li $a1, 20                  # maximum number of integers can be stored
  	la $a2, buffer                # address input buffer
  	
  	jal getInts                  # Call the procedure getInts
   	move $t7,$v0                  # $t7 equal to  number of integers extracted or

  	li $v0,4               # print label "The array before:"
  	la $a0,arrayBefore
   	syscall
   

   	la $a0,intarray                # address of integer array
  	move $a1,$t7                  # $a  equal to  length of the array
  	 
   	jal print                      # Call the procedure print
   	
   	#selection sort
  	la $a0,intarray                # address of integer array
  	move $a1,$t7                  # $a1 equal to  length of the array
  	jal selectionSort              # Call the procedure sort
  	

   	li $v0,4               # print promptArrayAfter
   	la $a0,arrayAfter
   	syscall
   	
   	la $a0,intarray                # address of integer array
   	move $a1,$t7                  # $a1 is  equal to  the length of the array
  	jal print                      # Call the procedure print


   	la $a0,promptMean               # Calculate and print mean
   	li $v0,4
   	syscall
   	
  	la $a0,intarray                # address of integer array
   	move $a1,$t7                  # $a1 equal to  length of the array
  	jal calMean
  	
   	li $v0,2               # print promptMean
  	syscall
  	
   	la $a0,newline
   	li $v0,4
   	syscall
   	
   	la $a0,promptMedian               # print promptMedian
   	li $v0,4
   	syscall

   	la $a0,intarray                #load the address of integer array
   	move $a1,$t7                  # set $a1 to the length of the array
   	
   	jal calMedian    
  	bltz $v1, printFloat           # if $v1 is negative mean median is a float
  	


   	move $a0,$v0
   	li $v0,1                 # print median
   	syscall
   	
   	j stdDev               # jump to the standard deviation
   	
   	
printFloat: #function for the float
   	li $v0,2
   	syscall               # print median(float value)

stdDev: #function for the standard deviation
   	li $v0,4
   	la $a0,newline
   	syscall
   	
   	li $v0,4              
   	la $a0,promptStanDev   # print label prompt standard deviation
   	syscall              
   	
   	la $a0,intarray                #load in the address of integer array
  	move $a1,$t7                  # $a1 euqal to the length of the array
  	
   	jal calStdDev
   	li $v0,2
  	syscall                   # print standared deviation
  	
exit:   li $v0, 10               
	syscall

   

readFile: #function to read the file
  	 move $t1,$a1               # tempararily store address of buffer in $t1
   
   	li   $v0, 13                     # system call for open file
   	li   $a1, 0                      # 0 is the flag for reading
   	syscall                          

  	blt $v0,$0 returnReadFile          # If failed to open input file, return to main
  	move $s0, $v0                    # save the file descriptor in $s0
  	
  	li   $v0, 14                     # system call for reading from file
   	move $a0, $s0                    # file descriptor
   	
   	move $a1,$t1                  # address of buffer
   	li   $a2, 80                    # hardcoded buffer length
   	syscall                          # read from file

   	li   $v0, 16                     # system call for reading from file
   	move $a0,$s0               # #a0 file descripter
   	syscall
   	
   	move $v0,$s0                  
returnReadFile:
   	jr $ra                      # Return to main

getInts :

  	li,$s1,-1                      # To store the integer decimal
   	li $t0,0
loop1:   
	lb $t1,($a2)              # Load the address of first byte into $t2
   	beq $t1,10,storeInArray         # if byte is new line(new line means one complete


   	beq $t1,$zero,returngetInts      # If $t1 is 0, end of file is reached


   	blt $t1,48,ignoreNnext          # ignore the byte if register value is less than 48
   	bgt $t1,57,ignoreNnext          # ignore the byte if register value is greater than 57

   	addi $t1,$t1,-48              # Convert charcter digit to decimal digit
                              # by subtracting 48 from ASCII integer.
   	bne $s1,-1,multiplyBy10      
   	li $s1,0               # if $s1 equal to -1, current byte is the starting digit

multiplyBy10:
  	li $t3,10        
   	mul $s1,$s1,$t3                  # Multiply $s1 with 10
   	add $s1,$s1,$t1                  # Add converted decimal digit to $s1
   	
ignoreNnext:            
   	add $a2,$a2,1                  # goes to the next byte
   	j loop1             

storeInArray:                    
  	beq $s1,-1,skipStoring         # -1 means , no integer is formed
   	sll $t2,$t0,2                  # multiply index with 4
   	add $t2,$t2,$a0                  # #t2 equal to address to store integer
   	sw $s1,0($t2)                  # Store decimal integer into array
   	li $s1,-1                      # Re set $s1 to -1(for fresh integer)
   
skipStoring:
   	addiu $t0,$t0,1                   # increment the index of integer array
   	add $a2,$a2,1                  # go to next byte
   	beq $t0,20,returngetInts         # only allow maximum 20 integer
  	j loop1				#jump to loop1
returngetInts:
   	move $v0,$t0                  
   	jr $ra                      # Return to main 

print:
   	move $s0,$a0
   	li $t0,0	#load 0 into register $t0
   	
loop2:
   	beq $t0,$a1,returnPrint         # if register  equal to  size of the array, return
   	li $v0,1
   	sll $t1,$t0,2
   	add $t1,$t1,$s0
   	lw $a0,0($t1)           # load the int
   	syscall               	# print int
   	
   	li $v0, 4                        
   	la $a0, space               #insert space
  	syscall
  	
  	add $t0,$t0,1            # Move to next int
  	
  	j loop2			#jump to loop2
  	
  	
returnPrint:
   	li $v0, 4                        
   	la $a0, newline             # Print new line
   	syscall
   	
   	jr $ra                      # Return to main


selectionSort:
   	li $t0,0                      # index array
   	sub $s0,$a1,1                  # subtract 1 from a1 and then put the result into s0
   
outerloop:
   	beq $t0,$s0,returnSelectionSort
   	move $s1,$t0                  
   	add $t1,$t0,1                  # add one to register #t0 and then store the result int0 $t1
   	
innerloop:
   	beq $t1,$a1,checkIfSwapped
   	sll $t2,$t1,2
   	sll $t3,$s1,2
   	
   	add $t2,$t2,$a0
   	add $t3,$t3,$a0
  	lw $t4,0($t2)                  
   	lw $t5,0($t3)                  
   	
   	blt $t4,$t5,updateIndex              # Swap $t0 and $t1 if it is smaller than $t0
   	j nextinner

updateIndex:  
	move $s1,$t1   
	      
nextinner:
   	add $t1,$t1,1
   	j innerloop              
checkIfSwapped:

   	bne $s1,$t0,swap             
                              
  	j nextouter

swap:
   	sll $t2,$t0,2
   	sll $t3,$s1,2
   	
   	add $t2,$t2,$a0        
   	add $t3,$t3,$a0
   	
   	lw $t4,0($t2)        
   	lw $t5,0($t3)
   	        
   	sw $t4,0($t3)
  	sw $t5,0($t2)
  	
nextouter:
   	add $t0,$t0,1
   	j outerloop
   	               
returnSelectionSort:     
   	jr $ra

calMean:
   	li $t0,0
   	mtc1 $t0,$f12                 
   	mtc1 $t0,$f0
   	

calMeanloop:
   	beq $t0,$a1,returnCalMean       # if $t0  equal to  size of the array, return to main
  	sll $t1,$t0,2
   	add $t1,$t1,$a0
   	
   	lwc1 $f0,0($t1)           # load integer as float value into $f0
   	add.s $f12,$f12,$f0           # add it to $f12
   	add $t0,$t0,1           # advance $t0 by 1
   	
   	j calMeanloop           # go to next iteration
   	
returnCalMean:
   	mtc1 $a1,$f0                  # $f0 equal to  n
   	div.s $f12,$f12,$f0         # mean equal to $f12 equal to sum/n
   	
   	jr $ra                      # return mean in $f12

calMedian:
   	div $t0,$a1,2           # $t0 equal to index of middle integer
   	mfhi $t1
   	beqz $t1,calaverage           # if $t1 equal to 0 means, number of integers is even
                    # then calculate average of middle two integers
 	sll $t2,$t0,2
   	add $t2,$t2,$a0
   	lw $v0,0($t2)           # other wise, number of integers is odd
                    # and thus return the middle integer as median
   	li $v1,0               # return 0 in $v1, means result is integer
   	
   	j returnCalMedian
calaverage:
   	sub $t1,$t0,1
   	sll $t2,$t0,2
  	sll $t3,$t1,2
  	
   	add $t2,$t2,$a0        
   	add $t3,$t3,$a0
   	
   	lw $t4,0($t2)               # load middle two integers    
   	lw $t5,0($t3)
   	
   	add $t4,$t4,$t5           # sum of middle two integers
   	
   	mtc1 $t4,$f12           # $f12 equal to  sum of middle two integers
   	li $t5,2
   	mtc1 $t5,$f0               # $f0 equal to  2
   	
   	div.s $f12,$f12,$f0           # $f12 equal to  $f12/2
   	li $v1,-1                  # return negative value $v1

returnCalMedian:      
   	jr $ra               # return to main

calStdDev:
   	add $sp,$sp,-4
   	sw $ra,4($sp)                  # save return address
   	jal calMean  

   	mov.s $f0,$f12           	# copy mean into $f0
   	li $t0,0
   	mtc1 $t0,$f12                  # sun equal to 0 ( keep track sum in $f12)
loopStandardDeviation:
   	beq $t0,$a1,returnStandardDeviation        # if $t0  equal to  size of the array, return to main
   	sll $t1,$t0,2
   	
   	add $t1,$t1,$a0
   	lw $t2,0($t1)           # load integer
   	
   	mtc1 $t2,$f1              
   	cvt.s.w $f1,$f1           
   	
   	sub.s $f2,$f1,$f0             # $f2 equal to ri-ravg
   	mul.s $f3,$f2,$f2             # $f3 equal to (ri-ravg)^2
   	add.s $f12,$f12,$f3         # $f12 equal to Sum of (ri-ravg)^2
   	
   	add $t0,$t0,1
   	
   	j loopStandardDeviation               # go to next iteration
   
returnStandardDeviation:
   	sub $t2,$a1,1                  # $t3  equal to  n-1
   	mtc1 $t2,$f4                  # $f4  equal to  n-1
   	
   	cvt.s.w $f4,$f4            
   	div.s $f12,$f12,$f4         # $f12  equal to sum/n-1
   	sqrt.s $f12,$f12               # sqrt($f12)
   	
   	lw $ra,4($sp)
   	add $sp,$sp,4                  
   	
   	jr $ra               # return to main