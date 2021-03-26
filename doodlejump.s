#####################################################################
#
# CSC258H5S Winter 2021 Assembly Programming Project
# University of Toronto Mississauga
#
# Group members:
# - Student 1: Ashka , 1005994952
# - Student 2: Yash Dave, 1006140203
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################
                    
.data
	displayAddress:	.word	0x10008000
.text
	lw $t0, displayAddress	# $t0 stores the base address for display
	li $t1, 0xf4f5ba	# $t1 stores the yellow colour code

	add $t2, $zero, $zero
	addi $t3, $zero, 16384
loop:
	
	sw $t1, 0($t0)	 # paint the first (top-left) unit some weird color. 
	addi $t0, $t0, 4 # increment the byte address by 4
	blt $t2, $t3, loop # continue loop
	
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall