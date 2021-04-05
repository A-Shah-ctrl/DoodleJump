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
	colours: .word 0xBFFFF7, 0x050A45, 0x66440E # colours[0]=background, colours[1]= bars and colours[2] = player1
	bars: .word 3968, 3072, 1024 # bars[0] = bar1, bars[1]= bar2, bars[2] = bar3
	displayAddress:	.word	0x10008000
	playerAddress: .word 	0x10008000
	jump: .word 1 #If 1, doodler goes high, 0 falls down
	height: .word 0
	
.text
	lw $s1, height
	lw $s2, jump		# 1 = up, 0 = down
  	li $t5, -2432		
  	lw $t6, playerAddress	# $t6 stores the address of player 1
	addi $t6, $t6, 4028

main: 	jal base
	jal addBar
	jal movement
	jal base
	jal movement
	jal base
	jal movement
	jal base
	jal movement
	addi $t3, $t3, 1
	bne $t3, 4, main
	j Exit

# =================== PAINT FUNCTION ============================
# Paints the background colour of the screen
paintBar:
	la $s0, colours
	lw $t1, 4($s0) # Colour of bar loaded 
	lw $t2, displayAddress # Display address loaded
	lw $t0, 0($sp)
	addi $sp, $sp, 4 # Pop the address of bar from stack 
	add $t0, $t0, $t2 # Adds offset to diplay address
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)
	jr $ra
	
backcolour:
	la $s0, colours
	lw $t1, 0($s0) # Colour of background loaded 
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
	
	addi $t0, $t0, 128
	addi $t2, $t2, 1
	bne $t2, 32, backcolour
	jr $ra

addBar: 
	addi $sp, $sp, -4
	sw $ra, 0($sp) # Push address of main function onto the stack
	la $s0, bars
	lw $t0, 4($s0) # Second bar
	sw $t0, 0($s0) # Store into bars[0]
	lw $t0, 8($s0) # Third bar
	sw $t0, 4($s0) # Store into bars[1]
	lw $t0, 12($s0) # Fourth bar
	sw $t0, 8($s0) # Store into bars[2]
	
	li $v0, 42 # Generate random number for position from 0 to 20
	li $a1, 20
	syscall
	li $t0, 4
	mult $a0, $t0
	mflo $t0
	sw $t0, 12($s0)# Store into bars[3]
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # Pop the address of main function from stack
	jr $ra	
	
movement: 
	addi $sp, $sp, -4
	sw $ra, 0($sp) # Push address of main function onto the stack
	la $s0, bars
	lw $t0, 0($s0) # First bar
	addi $t0, $t0, 256
	sw $t0, 0($s0)
	lw $t0, 4($s0) # Second bar
	addi $t0, $t0, 256
	sw $t0, 4($s0)
	lw $t0, 8($s0) # Third bar
	addi $t0, $t0, 256
	sw $t0, 8($s0)
	lw $t0, 12($s0) # Fourth bar
	addi $t0, $t0, 256
	sw $t0, 12($s0)
	
	li $v0, 32
	la $a0, 1000
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # Pop the address of main function from stack
	jr $ra	
	
base:	addi $sp, $sp, -4
	sw $ra, 0($sp) # Push address of main function onto the stack
	li $t2, 0
	lw $t0, displayAddress # Display address loaded
	jal backcolour # paint the background
	la $s1, bars
	lw $t0, 0($s1)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push address of first bar onto the stack
	jal paintBar
	lw $t0, 4($s1)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push address of second bar onto the stack
	jal paintBar
	lw $t0, 8($s1)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push address of third bar onto the stack
	jal paintBar
	lw $t0, 12($s1)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push address of fourth bar onto the stack
	jal paintBar
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # Pop the address of main function from stack
	jr $ra

drawBars:
	la $s0, colours
	lw $t1, 4($s0) # Loading the bar colour into regsiter $t1
	la $s0, bars
	# ===== Paints first bar on screen ======
	lw $t0, displayAddress # Loading the displayAddress
	lw $t2, 0($s0) # Loading address of first bar
	add $t0, $t0, $t2
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)
	# ===== Paints second bar on screen ======
	lw $t0, displayAddress # Loading the displayAddress
	lw $t2, 4($s0) # Loading address of second bar
	add $t0, $t0, $t2
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)
	# ===== Paints third bar on screen ======
	lw $t0, displayAddress # Loading the displayAddress
	lw $t2, 8($s0) # Loading address of third bar
	add $t0, $t0, $t2
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)
	
onedoodle:
	
	la $s0, colours 
	lw $t1, 8($s0) # Loading the player1 colour into regsiter $t1
	sw $t1, 0($t6)
	sw $t1, 8($t6)
	sw $t1, -124($t6)
	sw $t1, -128($t6)
	sw $t1, -252($t6)
	sw $t1, -120($t6)

jumpdoodle:
	
	la $s0, colours 
	lw $t1, 0($s0) # Loading the background colour into regsiter $t1
	sw $t1, 0($t6)
	sw $t1, 8($t6)
	sw $t1, -124($t6)
	sw $t1, -128($t6)
	sw $t1, -252($t6)
	sw $t1, -120($t6)
	
	bgtz $s1, CJUMP
	ble $s1, $t5, CFALL
	j CHECK
CFALL:

	addi $s2, $s2, -1
	j CHECK

CJUMP:
	
	addi $s2, $s2, 1
	
CHECK:

	bgtz $s2, ELSE	# Check if falling or jumping

THEN:

	addi $t6, $t6, 128
	addi $s1, $s1, 128	
	j CONT

ELSE:

	addi $t6, $t6, -128
	addi $s1, $s1, -128

CONT:
	
	li $a0, 32
	addi $a0, $a0, 1
	lw $t1, 8($s0) # Loading the player1 colour into regsiter $t1
	sw $t1, 0($t6)
	sw $t1, 8($t6)
	sw $t1, -124($t6)
	sw $t1, -128($t6)
	sw $t1, -252($t6)
	sw $t1, -120($t6)
	j jumpdoodle

Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
