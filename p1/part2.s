# NAME: Brenden Duffy
# DATE: 3/2/2022
# PURPOSE:  Project 1, part 2 starting code
#
# REGISTER USAGE:   (this is where we decsribe the semantics of values within registers)
#	s0: stores the integer input from the keyboard
#	a0: stores the address of prompt string (msg1 or msg2) (input parameter to syscall)
#	v0: syscall returns input values here
#
# ALGORITHM
#	(left for you to understand)
# (everything aove is for the human and is strictly readable text for the human to understand)

	# assembler directive to describe the "__start" as a global label
	.globl __start 

	.data	# Data declaration section (Here is where variables and stored data exist)

msg1:	.asciiz		"Enter an integer: "
msg2:	.asciiz		"The computed result is:   "
#loc1:	.space	4

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

########################################
# Do not touch anything above this line.
# Write your program below this line.
########################################

	lui $s2, 0x1000
	ori $s2, 0xFF20
	sw $s0, 0($s2)
	sll $s0, $s0, 4
	sw $s0, 4($s2)
#	sw $s0, loc1
	addi $t0, $s0, -1

########################################
# Do not touch anything below this line.
########################################

	la $a0, msg2		# load address of msg2 into register
	li $v0, 4
	syscall				# make a syscall to print msg1 in console window
			
    li	$v0, 1			# system call code for printing integer = 1
    move	$a0, $t0	# move integer to be printed into $a0:  $a0 = $t0
    syscall				# call operating system to perform print

	li $v0, 10
	syscall			# exit the program via syscall		

# END OF PROGRAM part2.s