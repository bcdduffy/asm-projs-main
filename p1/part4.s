# NAME: Brenden Duffy
# DATE: 3/2/2022
# PURPOSE:  Project 1, part 4

	# assembler directive to describe the "__start" as a global label
	.globl __start 

	.data	# Data declaration section (Here is where variables and stored data exist)

msg1:	.asciiz		"Enter an Integer: "
msg2:	.asciiz		" is out of range"
msg3:	.asciiz		"The result of summation is "
theNumber:	.word 0
theAnswer:	.word 0

	.text   # Text region - user instructions (your code)

__start:	# execution starts here
			
	la $a0, msg1		# load address of msg1 into register
	li $v0, 4			# msg1 prompts for user to input integer
	syscall				# make a syscall to print msg1 in console window

	# read integer into $s0
    	li	$v0, 5		# system call code for read integer = 5
    	syscall			# call operating system
	# value read from keyboard returned in register $v0
    	add $s0, $zero, $v0	# move $v0 to $s0

	move $t0, $s0
	li, $s2, 0x1		# Loads starter values
	li, $s4, 10
	li $s5, 0x0
	slt $s1, $s0, $s2   	# Checks to see if input is less than 1
	sgt $s3, $s0, $s4   	# Checks to see if input is greater than 10
	add $s1, $s1, $s3   	# Combines conditions into one
	beq $s5, $s1, calcSum	# Branches based on two conditions
	j outOfRange
	#j forLoop

outOfRange:
    li	$v0, 1			# system call code for printing integer = 1
    move	$a0, $t0	# move integer to be printed into $a0:  $a0 = $t0
    syscall				# call operating system to perform print

	la $a0, msg2		# load address of msg2 into register
	li $v0, 4
	syscall				# make a syscall to print msg1 in console window
			
	li $v0, 10
	syscall			# exit the program via syscall		

calcSum: 
	#li $t0, 0
	#li $t2, 0     # Sets y and index i to 0
	#addi $t3, $s0, 1
	#move $a0, $t0
	#move $a1, $t2
	move $a0, $s0
	jal findSum
	sw $v0, theAnswer
	j sumCall
	
	
	
sumCall:
	la $a0, msg3		# load address of msg2 into register
	li $v0, 4
	syscall				# make a syscall to print msg1 in console window
			
    li	$v0, 1			# system call code for printing integer = 1
    lw	$a0, theAnswer	# move integer to be printed into $a0:  $a0 = $t0
	addi	$a0, $a0, -1	# move integer to be printed into $a0:  $a0 = $t0
    syscall				# call operating system to perform print

	li $v0, 10
	syscall			# exit the program via syscall	
	
.globl findSum
findSum:
	subu $sp, $sp, 8
	sw	$ra, ($sp)
	sw	$s0, 4($sp)
	
	#Base Case
	li	$v0, 1
	beq $a0, 0, sumDone
	
	#
	move $s0, $a0
	sub $a0, $a0, 1
	jal findSum
	
	add $v0, $s0, $v0
	
	sumDone:
		lw $ra, ($sp)
		lw $s0, 4($sp)
		addu $sp, $sp, 8
		jr $ra
	
	
	# beq $a0, $t3, endRecursive  # Loop that handles summation, call sumCall when i <=y
	# add $a1, $a1, $a0
	# addi $a0, $a0, 1
	# jal recursiveLoop
	# jr $ra
	# endRecursive:
	# move $v0, $a1
	# jr $ra
	