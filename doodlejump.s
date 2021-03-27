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
	playerAddress: .word 	0x10008000
	
.text
	lw $t0, displayAddress	# $t0 stores the base address for display
	li $t1, 0xBFFFF7	# $t1 stores the blue colour code
  	li $t2, 0x050A45	# Color of bars
  	li $t3, 0		# $t3 counts the number of rows
  	li $t4, 0x66440E	# $t4 stores the color of player 1
  	li $t5, 1		# 1 = up, 0 = down
  	lw $t6, playerAddress	# $t6 stores the address of player 1
	addi $t6, $t6, 4028
	
reset:
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)	 
	sw $t1, 32($t0)	 
	sw $t1, 36($t0)	
	sw $t1, 40($t0)	 
	sw $t1, 44($t0)	 
	sw $t1, 48($t0)	 
	sw $t1, 52($t0)	 
	sw $t1, 56($t0)	 
	sw $t1, 60($t0)	 
	sw $t1, 64($t0)
	sw $t1, 68($t0)
	sw $t1, 72($t0)
	sw $t1, 76($t0)
	sw $t1, 80($t0)
	sw $t1, 84($t0)
	sw $t1, 88($t0)
	sw $t1, 92($t0)
	sw $t1, 96($t0)
	sw $t1, 100($t0)
	sw $t1, 104($t0)
	sw $t1, 108($t0)
	sw $t1, 112($t0)
	sw $t1, 116($t0)
	sw $t1, 120($t0)
	sw $t1, 124($t0)
	# sw $t1, 128($t0)
	
	addi $t0, $t0, 128
	addi $t3, $t3, 1
	bne $t3, 32, reset

onedoodle:
	
	sw $t4, 0($t6)
	sw $t4, 8($t6)
	sw $t4, -124($t6)
	sw $t4, -128($t6)
	sw $t4, -252($t6)
	sw $t4, -120($t6)

Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
