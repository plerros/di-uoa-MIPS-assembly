####################################################################################
.text
	.globl __start

__start:   
		move	$a1,$zero
		move 	$a2,$zero
		li 	$a3,1

################
get:
################
print_string_1:	li 	$v0,4		# User prompt
		la 	$a0,message1
		syscall

read_int:	li 	$v0,5		# read input
		syscall

input_check:	bltz 	$v0,loopget	#if input < 0 branch to loopget

		#slt 	$t0,$v0,$zero	#if input < 0 {t0 = 1 / else t0 = 0}
		#beq 	$t0,1,done	#if t0 = 1 branch to done

		move 	$a1,$v0		# moving the user value into $a1
		jal	calfib

		move 	$v1,$a0		# Temp storage of answer now in $a0 to $v1

print_string_2:	li 	$v0,4		# The Fib number is...
		la 	$a0,message2
		syscall

		li 	$v0,1		# ... the answer
		move 	$a0,$v1	# Bring back temp Storage of answer from $v1
		syscall

		j 	done

################
loopget:
################
print_error_1:	li 	$v0,4
		la 	$a0,msgerr1
		syscall

print_error_2:	li 	$v0,4
		la 	$a0,msgerr2
		syscall

loop_to_get:	j	get

################
calfib:
################
		subu	$sp,$sp,32	#set up standard activation record 
		sw	$ra,20($sp)
		sw	$fp,16($sp)
		addiu	$fp,$sp,28
		sw	$a1,0($fp)
		addiu	$a2,$a2,1	#increment number of recursive calls
		beq	$a1,1,ret1

		beq	$a1,0,ret1

		lw	$a1,0($fp)
		subu	$a1,$a1,1	#subtract 1
		jal	calfib		#calculate fib(n-1)

		move	$a3,$a0		#save it in a3
		sw	$a3,4($fp)
		lw	$a1,0($fp)
		subu	$a1,$a1,2	#subtract 2
		jal	calfib		#calculate fib(n-2)

		lw	$a3,4($fp)
		add	$a0,$a3,$a0
		j	donec

################
ret1:
################
		li	$a0,1

################
donec:
################
		lw	$ra,20($sp)	#remove activation record of fibonacci
		lw	$fp,16($sp)
		addiu	$sp,$sp,32
		jr	$ra

################
done:
################
		li 	$v0,4	
		la 	$a0,nl
        	syscall

		la $a0, message3
		syscall

		subu	$a2,$a2,1
		li	$v0,1
		move	$a0,$a2
		syscall

		li	$v0,4
		la	$a0,nl
		syscall

################
endit:
################
		li	$v0,10
		syscall

####################################################################################
.data

message1: .asciiz "Enter a positive index for Fibonacci Calculation : "
message2: .asciiz "The Finonacci number is : "
message3: .asciiz "Recusive calls made to Fibonacci : "
msgerr1: .asciiz "The Finonacci number is : 1 \n"
msgerr2: .asciiz "Recusive calls made to Fibonacci : 0 \n"
nl: .asciiz "\n";
