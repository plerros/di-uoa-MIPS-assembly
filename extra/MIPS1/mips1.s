.text
.globl __start
__start:

	li $s0,1
	li $s1,10
	la $s2,M
	la $s3,N

B:	addi $s2,$s2,1
	addi $s3,$s3,1

C:	lb $a0,($s2)M
	li $v0,4
	syscall

	lb $a0,$s3
	li $v0,4
	syscall

A:	addi $s0,$s0,1

	ble $s0,$s1,B


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
