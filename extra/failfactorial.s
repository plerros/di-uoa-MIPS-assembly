
####################################################################################
.text
	.globl __start

__start:

factorial:
	subu $sp,$sp,32		#Stack frame is 32 bytes long
	sw $ra,20($sp)		#Save return address
	sw $fp,16($sp)		#Save old frame pointer
	addiu $fp,$sp,28	#Set up frame pointer
	li $a0,10		#Put argument (10) in $a0
	jal fact		#Call factorial function
	la $a0,$LC		#Put format string in $a0
	move $a1,$v0		#Move fact result to $a1
	jal printf		#Call the print function
	lw $ra,20($sp)          # Restore return address
        lw $fp,16($sp)          # Restore frame pointer
        addiu $sp,$sp,32        # Pop stack frame
        jr $ra                  # Return to caller
        .rdata
$LC:
        .ascii The factorial of 10 is %d\n\000z
         

####################################################################################
.data

newline:	.asciiz "\n"
