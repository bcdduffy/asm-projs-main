.globl __start
.data # Data declaration section (Here is where variables and stored data
exist)
.text # Text region - user instructions (your code)
__start: # execution starts here
xori $s5, $zero, 0x1007
xori $s4, $zero, 0x0118
xori $s0, $zero, 0x1111
xori $s1, $zero, 0x2222
j jLabel
iLabel:
xori $s0, $zero, 0x0111
xori $s1, $zero, 0x0111
jLabel:
sub $s2, $s1, $s0
bne $s0, $s1, iLabel
add $s3, $s0, $s1
#sw $s3, 16($s2)
#lw $s4, 16($s2)
#slt $s5, $s0, $s4
#lw $s4, 16($s2)
#xori $s3, $s2, 0x0001
#xori $s5, $s5, 0x0001
#jr $s5
li $v0, 10
syscall # exit the program via syscall
# END OF PROGRAM part2.s
