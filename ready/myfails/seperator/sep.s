####################################################################################
.text
	.globl __start

__start:

	la	$t0,line
	la	$t2,numbers
	la	$t3,letters
	lb	$t4,lettera
	lb	$t5,letterz
	lb	$t6,letterA
	lb	$t7,letterZ

loop:	lb	$t1,0($t0)
	bgt	$t1,$t4,letter
notletter:
	bgt	$t1,$t6,LETTER
notLETTER:
	sltiu	$t1,$t1,0
	bgtz	$t1,notnumber
	lb	$t1,0($t0)
	sltiu	$t1,$t1,10
	bltz	$t1,notnumber
	lb	$t1,0($t0)
	sb	$t1,0($t3)
	addiu	$t2,$t2,4
	bne	$t1,$t5,loop	
exit:	li	$v0, 10
	syscall
notnumber:
	addiu	$t0,$t0,4

letter:	bgt	$t1,$t5,notletter
	sb	$t1,0($t3)
	addiu	$t3,$t3,4

LETTER:	bgt	$t1,$t7,notLETTER
	sb	$t1,0($t3)
	addiu	$t3,$t3,4


	


####################################################################################
.data

newline:	.asciiz "\n"
lettera:	.asciiz "a"
letterz:	.asciiz "z"
letterA:	.asciiz "A"
letterZ:	.asciiz "Z"
line:		.asciiz "a1#B2z"
letters:	.asciiz "      "
numbers:	.asciiz "      "
