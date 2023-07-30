# NAME: Brenden Duffy
# DATE: 3/2/2022
# PURPOSE:  Project 1, part 5

	# assembler directive to describe the "__start" as a global label
	.globl __start 

	.data	# Data declaration section (Here is where variables and stored data exist)
#DaValues:	.space 40
msg1:	.asciiz		", "
msg2:	.asciiz		"Enter a number: "
msg3:	.asciiz		"Every other Element: "
msg4:	.asciiz		" Every other Element after Reversal: "
#DaValues:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
DaValues:	.space 40

	.text   # Text region - user instructions (your code)

__start:	# execution starts here

	
	jal takeIn
	
	la $a0, msg3		# load address of msg1 into register
	li $v0, 4			# msg1 prompts for user to input integer
	syscall				# make a syscall to print msg1 in console window
	
	jal printEveryOther
	jal reverseArray
	
	la $a0, msg4		# load address of msg1 into register
	li $v0, 4			# msg1 prompts for user to input integer
	syscall				# make a syscall to print msg1 in console window
	
	
	jal printEveryOther


	li $v0, 10
	syscall			# exit the program via syscall		

# END OF PROGRAM part2.s


	
printEveryOther:
	li $t1, 2
	li $t2, 11
	li $t4 10
	startLoop:
	beq $t1, $t2, endLoop  # Loop that handles summation, call sumCall when i <=y
	
	sll $t3, $t1, 2
	lw $t0, DaValues($t3)
	
	li	$v0, 1			# system call code for printing integer = 1
    move	$a0, $t0	# move integer to be printed into $a0:  $a0 = $t0
    syscall				# call operating system to perform print
	
	beq $t1, $t4, endLoop
	la $a0, msg1		# load address of msg1 into register
	li $v0, 4			# msg1 prompts for user to input integer
	syscall				# make a syscall to print msg1 in console window
	
	addi $t1, $t1, 2
	j startLoop
	endLoop:
	jr $ra
	
takeIn:
	li $t1, 1
	li $t2,  11
	takeInLoop:
	beq $t2, $t1, endTakeIn  # Loop that handles summation, call sumCall when i <=y
	
	
	
	la $a0, msg2		# load address of msg1 into register
	li $v0, 4			# msg1 prompts for user to input integer
	syscall				# make a syscall to print msg1 in console window
	# read integer into $s0
    li	$v0, 5		# system call code for read integer = 5
    syscall			# call operating system
	# value read from keyboard returned in register $v0
    add $t0, $zero, $v0	# move $v0 to $s0
	
	
	sll $t3, $t1, 2
	sw $t0, DaValues($t3)
	
	addi $t1, $t1, 1
	j takeInLoop
	endTakeIn:
	jr $ra
	
	
reverseArray:

	li $t6, 0
	li $t0, 4
	li $t3, 40
	li $t9, 5
	li $t1, 0
	li $t2, 0
	li $t4, 0
reverseLoop:
	
	beq $t6, $t9, endReverse
	lw $t1, DaValues($t0)
	lw $t2, DaValues($t3)
	move $t4, $t2
	sw $t1 DaValues($t3)
	sw $t4 DaValues($t0)
	addi $t0, $t0, 4
	addi $t3, $t3, -4
	addi $t6, $t6, 1
	j reverseLoop
	
endReverse:
	jr $ra
	