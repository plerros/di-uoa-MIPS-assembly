####################################################################################
.text
	.globl __start
__start:
 
read_int:	li 	$v0, 5		# read input & store to $v0
		syscall
		
		move	$s7,$v0
print_int:
		li	$v0, 1
		move	$a0, $s7	#print int from s7
		syscall	

	print_nl:
		li 	$v0,4		#print \n
       		la 	$a0,newline
        	syscall

check_int:	bltz	$s7,lessthanzero

		#li	$s6,0

loop:		bnez	$s7,loop2
		jal 	initialize_0

loop2:		lw	$s6,4($sp)
		beq	$s6,$s7,loop3
		jal	initialize_n

loop3:		j	exit

exit:		li	$v0, 10
		syscall
		
lessthanzero:	
		j	read_int

initialize_0:	subu	$sp,$sp,8	#store stack pointer
		sw	$ra,0($sp)

		li	$t0,0
		subu	$sp,$sp,8	#store number 0
		sw	$t0,0($sp)

	print_string0:
		li 	$v0,4		#print fibstart
       		la 	$a0,fibstart
        	syscall
	print_int0:
		li	$v0, 1
		move	$a0, $t0	#print int from t0
		syscall
	print_string1:
		li 	$v0,4		#print fibend
       		la 	$a0,fibend
        	syscall
		
		li	$t0,0
		subu	$sp,$sp,8	#store number fibonacci(0)
		sw	$t0,0($sp)
	
	print_intf0:
		li	$v0, 1
		move	$a0, $t0	#print int from t0
		syscall
	print_nl0:
		li 	$v0,4		#print \n
       		la 	$a0,newline
        	syscall

		j	loop2

initialize_n:	subu	$sp,$sp,8	#store stack pointer
		sw	$ra,0($sp)

		lw	$s0,32($sp)
		addi	$s0,$s0,1
		subu	$sp,$sp,8	#store number n
		sw	$s0,0($sp)

	print_string2:
		li 	$v0,4		#print fibstart
       		la 	$a0,fibstart
        	syscall
	print_intn:
		li	$v0, 1
		move	$a0, $s0	#print int from s0
		syscall
	print_string3:
		li 	$v0,4		#print fibend
       		la 	$a0,fibend
        	syscall
	
		li	$t0,1
		bne	$s0,$t0,initialize_n1
		subu	$sp,$sp,8	#store number fibonacci(1)
		sw	$t0,0($sp)

	print_intf1:
		li	$v0, 1
		move	$a0, $t0	#print int from t0
		syscall
	print_nl1:
		li 	$v0,4		#print \n
       		la 	$a0,newline
        	syscall

		j	loop2

initialize_n1:	lw	$s0,40($sp)
		lw	$s1,64($sp)
		add	$s0,$s0,$s1
		subu	$sp,$sp,4	#store number fibonacci(n)
		sw	$s0,0($sp)

	print_intfn:
		li	$v0, 1
		move	$a0, $s0	#print int from s0
		syscall
	print_nl2:
		li 	$v0,4		#print \n
       		la 	$a0,newline
        	syscall

		j	loop2

####################################################################################
.data

newline:	.asciiz "\n"
fibstart:	.asciiz "f("
fibend:		.asciiz ") ="