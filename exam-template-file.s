
#___________________________________CODE___________________________________
.text
.globl __start
__start:


#________________________________TEMPLATES_________________________________
template_while_do:
	#beq $..., $..., template_while_do_end
	#code
	addi $t0, $t0, 1
	j template_while_do

	template_while_do_end:
	#code

template_do_while:
	#code
	addi $t0, $t0, 1
	#beq $..., $..., template_while_do_end
	j template_do_while

	template_do_while_end:
	#code

template_switchcase:
	template_case1:
		#bne $..., $..., template_case2 --if statements
		#code
	template_case2:
		#bne $..., $..., template_case3 --if statements
		#code
	template_case3:
		#bne $..., $..., template_case4 --if statements
		#code

template_recursive:
	addiu $sp $sp, 4
	sw $ra, ($sp)
	#beq $..., $..., template_recursive_continue

	#code
	jal template_recursive

	template_recursive_continue:
	lw $ra, ($sp)
	sw $zero, ($sp)
	addiu $sp $sp, -4
	j $ra
#_________________________________SYSCALLS_________________________________

#move $a0, $...
#jal print_int
print_int:
	li $v0, 1
	syscall
	j $ra

#jal print_float
#mov.s $f12, $...
print_float:
	li $v0, 2
	syscall
	j $ra

#jal print_double
#mov.d $f12, $...
print_double:
	li $v0, 3
	syscall
	j $ra

#la $a0, a_string
#jal print_string
print_string:
	li $v0, 4
	syscall
	j $ra

read_int:
	li $v0,5
	syscall
	move $a0, $v0
	li $v0, 1
	syscall
	j $ra
#move $... $a0

read_float:
	li $v0,6
	syscall
	j $ra
#mov.s $... $f0

read_double:
	li $v0,7
	syscall
	j $ra
#mov.d $... $f0

read_string:
	la $a0, data_string_buffer
	li $a1, 20
	li $v0, 8
	syscall
	j $ra
#move $... $a0

#j exit
exit:
	li $v0, 10;
	syscall

#la $a0, char
#jal print_char
print_char:
	li $v0, 11
	syscall
	j $ra

read_char:
	li $v0, 12
	syscall
	move $a0, $v0
	li $v0, 11
	syscall	
	j $ra
#move $... $a0

#_____________________________CUSTOM FUNCTIONS_____________________________

#jal print_newline
print_newline:
	li $v0, 4
	la $a0, data_newline
	syscall
	j $ra

#la $a0, a_string
string_length:
	li $v0, 0
	move $t1, $a0
	string_length_loop:
		lb $t0,($t1)
		beqz $t0, string_length_return
		add $v0,$v0,1	#increment
		add $t1,1		
	j string_length_loop
	string_length_return:
	j $ra
#move $... $v0

#move $a0, $...
convert_to_gray:
	li $v0, 0
	li $t0, 1
	and $t2, $a0, $t0
	
	li $t4, 1
	sll $t4, $t4, 31
	grey_loop:
		move $t1, $t2		#masking i
		sll $t0, $t0, 1

		and $t2, $a0, $t0	#masking i+1
		srl $t3, $t2, 1

		xor $t3, $t3, $t1
		or $v0, $v0, $t3

		beq $t4, $t0 grey_loop_end
	j grey_loop

	grey_loop_end:
	or $v0, $v0, $t2
	j $ra
#move $..., $v0

#move $a0, $...
#jal convert_from_bigendian_to_smallendian
convert_from_bigendian_to_smallendian:
	li $v0, 0
	li $t0, 0xff000000
	and $t1, $t0, $a0
	srl $t1, $t1, 24
	add $v0, $t1, $v0
	srl $t0, $t0, 8
	li $t0, 0x00ff0000
	and $t1, $t0, $a0
	srl $t1, $t1, 8
	add $v0, $t1, $v0
	srl $t0, $t0, 8
	li $t0, 0x0000ff00
	and $t1, $t0, $a0
	sll $t1, $t1, 8
	add $v0, $t1, $v0
	srl $t0, $t0, 8
	li $t0, 0x000000ff
	and $t1, $t0, $a0
	sll $t1, $t1, 24
	add $v0, $t1, $v0
	srl $t0, $t0, 8
	j $ra
#move $..., $v0

#move $a0, $...
#move $a1, $...
check_overflow:
	srl $t0, $a0, 1
	srl $t1, $a1, 1
	addu $v0, $t0, $t1
	srl $v0, $v0, 31
	j $ra
#move $..., $v0

add_64:
	addu $t0, $a0, $a1
	mtlo $t0

	srl $t0, $a0, 1
	srl $t1, $a1, 1
	addu $v0, $t0, $t1
	srl $v0, $v0, 31

	la $a0, data_A
	lw $a0, 4($a0)
	add $a0, $a0, $v0

	la $a1, data_B
	lw $a1,4($a1)	

	addu $t0, $a0, $a1
	mthi $t0

	j $ra
#mfhi $...
#mflo $...

#move $a0, $...
#move $a1, $...
Hamming_difference:
	xor $t0 $a0, $a1
	li $v0, 0
	li $t2, 0x80000000
	Hamming_difference_loop:
		andi $t1, $t0, 1
		add $v0, $v0, $t1
		srl $t0, $t0, 1
		srl $t2, $t2, 1
	bnez $t2, Hamming_difference_loop
j $ra
#move $..., $v0

#move $..., $a0
fibonacci_recursive:
	addiu $sp $sp, 4
	sw $ra, ($sp)

	li $t0, 1
	beq $a0, $zero, fibonacci_recursive_continue_0
	beq $a0, $t0, fibonacci_recursive_continue_1

	addiu $a0, $a0, -1
	addiu $sp $sp, 4
	sw $a0, ($sp)

	jal fibonacci_recursive
	lw $a0, ($sp)
	sw $v0, ($sp)
	addiu $a0, $a0, -1
	jal fibonacci_recursive
	lw $t0, ($sp)
	add $v0, $v0, $t0
	sw $zero, ($sp)
	addiu $sp $sp, -4

	fibonacci_recursive_continue:
	lw $ra, ($sp)
	sw $zero, ($sp)
	addiu $sp $sp, -4
	j $ra

	fibonacci_recursive_continue_0:
		li $v0, 0
		j fibonacci_recursive_continue
	fibonacci_recursive_continue_1:
		li $v0, 1
		j fibonacci_recursive_continue
#move $..., $v0

#move $a0, $...
prime_check:
	addiu $sp $sp, 4
	sw $ra, ($sp)
	li $t0, 1
	li $t2, 2
	move $t1, $a0

	primecheck_while_do:
		mult $t2, $t2
		mflo $t3
		slt $t4, $t1, $t3
		bne $t4, $zero, primecheck_exit

		div $t1, $t2
		mfhi $t4
		bne $t4, $zero, primecheck_while_do_increment

		add $t0, $zero, $t2
		j primecheck_exit

		primecheck_while_do_increment:
		addi $t2, $t2, 1
		j primecheck_while_do

	primecheck_exit:
		addi $t0, $t0, -1
		bne $t0, $zero, not_prime
		#la $a0, data_isprime
		#jal print_string
		lw $ra, ($sp)
		sw $zero, ($sp)
		addiu $sp $sp, -4
		li $v0, 1			#1 == prime is true
		j $ra

	not_prime:
		#la $a0, data_notprime
		#jal print_string
		lw $ra, ($sp)
		sw $zero, ($sp)
		addiu $sp $sp, -4
		li $v0, 0			#0 == prime is false
		j $ra

#___________________________________DATA___________________________________
.data

#_______________________________CUSTOM DATA________________________________
data_testbyte:		.byte 0x01, 0x02, 0x03, 0x04, 0x81, 0x82, 0x83, 0x84
					#.half
					#.float
					#.double
data_testword:		.word 0x12345678, 0x87654321
data_newline:		.asciiz "\n"
data_string_buffer:	.space 20
data_isprime:		.asciiz " It IS a prime."
data_notprime:		.asciiz " It is NOT a prime."

#___________________________________EOF____________________________________