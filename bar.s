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
# - Dynamic Background, involves sun and moon
# - Dynamic On-Screen Messages
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################
.data
	colours: .word 0xBFFFF7, 0x050A45, 0x66440E 
	bars: .word 4000, 3008, 1952, 976 #starting locations of the bars
	displayAddress:	.word	0x10008000
	playerAddress: .word 	0x10008000
	keystroke: .word	0xffff0000
	keyvalue: .word		0xffff0004
	leftKey: .word 		##############	
	rightKey: .word 		##############	
	jump: .word 1 #If 1, doodler goes high, 0 falls down
	height: .word 0
	maxheight: .word -1920
	ourconstant: .word -1920 # Total height at which the doodler appears to jump
	event: .word 0xffff0000 # if a key was pressed
	key: .word 0xffff0004 # which key was pressed
	
.globl main

.text
	
	lw $s5, ourconstant
	lw $s4, maxheight
	lw $s2, height
	lw $s3, jump		# 1 = up, 0 = down
	li $t4, 1
	lw $t6, playerAddress	# $t6 stores the address of player 1
	addi $t6, $t6, 4028
	
main: 	

	IFmain:
		
		beq $s3, $zero, ELSEmain
		ble $s4, $s2, ELSEmain
		jal base
		jal addBar
		jal movement
		jal base
		jal movement
		jal base
		jal movement
		jal base
		jal movement
		j REST
		
	
	ELSEmain:
		
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		jal base
		jal jumpdoodle
		jal touchbar
		
	REST:
		addi $t3, $t3, 1
		bne $t3, 50, main
		j end
	
base:	addi $sp, $sp, -4
	sw $ra, 0($sp) # Push address of main function onto the stack
	li $t2, 0
	lw $t0, displayAddress # Display address loaded
	jal backcolour # paint the background
	jal drawdoodle
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
	addi $s5, $s5, 256
	IFmovement:
		ble $s5, $zero, ELSEmovement
		j LEFTmovement
	ELSEmovement:
		lw $s5, ourconstant
		li $s3, 0	
	
	LEFTmovement:
		li $v0, 32
		la $a0, 300
		syscall
		lw $ra, 0($sp)
		addi $sp, $sp, 4 # Pop the address of main function from stack
		jr $ra

drawdoodle:
	
	la $s0, colours 
	lw $t1, 8($s0) # Loading the player1 colour into regsiter $t1
	sw $t1, 0($t6)
	sw $t1, 8($t6)
	sw $t1, -124($t6)
	sw $t1, -128($t6)
	sw $t1, -252($t6)
	sw $t1, -120($t6)
	jr $ra

jumpdoodle:
	
	IFjump:
		bne $s3, $zero, ELSEjump
		addi $t6, $t6, 128
		addi $s2, $s2, 128
		bgtz $s2, CHANGE1
		li $v0, 32
		la $a0, 125
		syscall
		jr $ra
	
	ELSEjump:
		addi $t6, $t6, -128
		addi $s2, $s2, -128
		addi $s5, $s5, 128
		ble $s2, $s4, CHECK
		
	CHECK:	
		beq $zero, $s5, CHANGE2
		li $v0, 32
		la $a0, 125
		syscall
		jr $ra
	
	CHANGE1:
	
		li $s3, 1
		la $s5, ourconstant 
		li $v0, 32
		la $a0, 125
		syscall
		jr $ra
		
	CHANGE2:
		
		li $s3, 0
		li $v0, 32
		la $a0, 125
		syscall
		jr $ra

touchbar:
	
		bne $s3, $zero, ENDtouch
	
	IFtouch:
		
		addi $t6, $t6, 128 	# bringing the left leg of doodler down
		la $t0, bars
		lw $t8, displayAddress
		lw $t5, 0($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		sub $t8, $t8, $t5
		
		lw $t5, 4($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		sub $t8, $t8, $t5
		
		lw $t5, 8($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		sub $t8, $t8, $t5
		
		lw $t5, 12($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		sub $t8, $t8, $t5
	
		addi $t6, $t6, -128
		
		addi $t6, $t6, 136 	# bringing the left leg of doodler down and right 2 units
		lw $t5, 0($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		sub $t8, $t8, $t5
		
		lw $t5, 4($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		sub $t8, $t8, $t5
		
		lw $t5, 8($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		sub $t8, $t8, $t5
		
		lw $t5, 12($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		sub $t8, $t8, $t5
		
		addi $t6, $t6, -136
		
		j ENDtouch
	
	CONT:
		
		addi $t6, $t6, -128
		lw $s5, ourconstant
		li $s3, 1
		j ENDtouch
	
	CONT2:
		addi $t6, $t6, -136
		lw $s5, ourconstant
		li $s3, 1
		j ENDtouch
	
	ENDtouch:
		
		jr $ra
	
# movelrdoodle:
	
#	IFmove:
#		beq $t
	
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
		
#======= Loop to paint background colour ======
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
#====== Function to paint the bars ======

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
end:
	li $v0, 10
	syscall	
		
