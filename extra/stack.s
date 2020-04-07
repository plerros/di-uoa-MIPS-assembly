
	subu $sp,$sp,32		#Stack frame is 32 bytes long
	sw $ra,20($sp)		#Save return address
	sw $fp,16($sp)		#Save old frame pointer
	addiu $fp,$sp,28	#Set up frame pointer
