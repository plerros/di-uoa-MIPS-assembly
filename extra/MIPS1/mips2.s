.text
.globl __start
__start:

	li $s0,0
	li $s1,9

C:	lb $a0,M
	add $a0,$a0,$s0
	li $v0,11
	syscall

	lb $a0,N
	add $a0,$a0,$s0
	li $v0,11
	syscall

A:	addi $s0,$s0,1

	ble $s0,$s1,C

END:	la $a0,NEWL
	li $v0,4
	syscall

	move $a0,$t0
	li $v0,10
	syscall

.data
M:	.asciiz "0123456789"
N:	.asciiz "abcdefghij"
NEWL:	.asciiz "\n"
