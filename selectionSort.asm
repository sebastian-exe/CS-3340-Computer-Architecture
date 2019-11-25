#Sebastian Moreno, SXS170103, 3340.004
#Homework Selection Sort
.data
	#hard code the array of 500 words
	array:	.word	19, 2, 95, 26, 83, 17, -5, 69, -16, 10, 
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10, 
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10, 
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10, 
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10,
	19, 2, 95, 26, 83, 17, -5, 69, -16, 10
.text
	#load the address of array into $a0
	la	$a0, array
	li	$a1, 500
   	
   	#selection sort
  	#la $a0,array               # address of integer array
  	#move $a1,$t7                  # $a1 equal to  length of the array
  	jal selectionSort              # Call the procedure sort
  	j exit


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
   	
exit:   li $v0, 10               
	syscall
