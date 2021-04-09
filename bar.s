#####################################################################
#
# CSC258H5S Winter 2021 Assembly Programming Project
# University of Toronto Mississauga
#
# Group members:
# - Student 1: Ashka Shah, 1005994952
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
# 1. Dynamic Background, involves sun and moon
# 2. (Dynamic On-Screen Messages
# 3. (Difficulty) Number of platforms fluctuates
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - Good luck marking this!
#
#####################################################################
.data
	bars: .word 4000, 3008, 1952, 976 #starting locations of the bars
	displayAddress:	.word	0x10008000
	playerAddress: .word 	0x10008000
	jump: .word 1 #If 1, doodler goes high, 0 falls down
	height: .word 0
	maxheight: .word -1920
	ourconstant: .word -1920 # Total height at which the doodler appears to jump
	
	colourDay: .word 0xBFFFF7, 0xF45F25, 0x050A45, 0x610000, 0x009933 # Sky, Sun, Bar, Doodle 
	colourNight: .word 0xF5F1D8, 0x000000, 0x2DF748, 0xF72D56 # Sky, Moon, Bar, Doodle 
	currCol: .word 0xBFFFF7, 0xF45F25, 0x050A45, 0x610000, 0x009933
	position: .word 16 # position of the sun or moon 
	time: .word  1 # 1 = Day 0 = Night
	
.globl main

.text

	lw $s5, ourconstant
	lw $s4, maxheight
	lw $s2, height
	lw $s3, jump		# 1 = up, 0 = down
	li $t4, 1
	lw $t6, playerAddress	# $t6 stores the address of player 1
	addi $t6, $t6, 3900
	
main: 	
	lbu $t0, 0xffff0000
	beq $t0, 0, IFmain
	#la $s0, key
	lbu $t0, 0xffff0004
	beq $t0, 0x00006a, moveLeft # j is left
	beq $t0, 0x00006b, moveRight # k is right
	j IFmain
	
moveLeft:
	addi $t6, $t6, -4
	j IFmain
	
moveRight:
	addi $t6, $t6, 4
	j IFmain

	IFmain:
		
		beq $s3, $zero, ELSEmain
		blt $s4, $s2, ELSEmain
		jal base
		jal addBar
		jal movement
		
		lbu $t0, 0xffff0000
		beq $t0, 0, IFmain2
		#la $s0, key
		lbu $t0, 0xffff0004
		beq $t0, 0x00006a, moveLeft2 # j is left
		beq $t0, 0x00006b, moveRight2 # k is right
		j IFmain2
		
		moveLeft2:
			addi $t6, $t6, -4
			j IFmain2
	
		moveRight2:
			addi $t6, $t6, 4
			j IFmain2
			
		IFmain2:
			jal base
			jal movement
			
			#beq $s3, $zero, ELSEmain
			#blt $s4, $s2, ELSEmain
			jal base
			jal movement
		
		lbu $t0, 0xffff0000
		beq $t0, 0, IFmain3
		#la $s0, key
		lbu $t0, 0xffff0004
		beq $t0, 0x00006a, moveLeft3 # j is left
		beq $t0, 0x00006b, moveRight3 # k is right
		j IFmain3
		
		moveLeft3:
			addi $t6, $t6, -4
			j IFmain3
	
		moveRight3:
			addi $t6, $t6, 4
			j IFmain3
			
		IFmain3:
			jal base
			jal movement
		
		lbu $t0, 0xffff0000
		beq $t0, 0, IFmain4
		#la $s0, key
		lbu $t0, 0xffff0004
		beq $t0, 0x00006a, moveLeft4 # j is left
		beq $t0, 0x00006b, moveRight4 # k is right
		j IFmain4
		
		moveLeft4:
			addi $t6, $t6, -4
			j IFmain4
	
		moveRight4:
			addi $t6, $t6, 4
			j IFmain4
			
		IFmain4:
			jal base
			jal movement
			
			
			
			
			
			#############
		#jal base
		#jal movement
		#jal base
		#jal movement
		j REST
		
	
	ELSEmain:
		
		jal base
		jal jumpdoodle
		jal touchbar
		
		
	REST:
		jal touchbottom
		j main
	
base: 
	addi $sp, $sp, -4
	sw $ra, 0($sp) # Push address of main function onto the stack
	li $t2, 0
	lw $t0, displayAddress # Display address loaded
	jal sky
	jal paintSunMoon
	jal drawdoodle
	jal paintBar
	lw $ra, 0($sp)
	addi $sp, $sp, 4 # Pop the address of main function from stack
	jr $ra
	
#======= Function to paint sky colour ======
sky:
	la $s0, currCol
	lw $t1, 0($s0) # Colour of sky loaded 
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
	bne $t2, 32, sky
	jr $ra
	
#====== Function to paint Sun/Moon ======
paintSunMoon:

	la $s0, currCol
	lw $t1, 4($s0) # Colour of bar loaded 
	lw $t2, displayAddress # Display address loaded
	
	la $s0, position		
	lw $t0, 0($s0) #offset of the Sun/Moon
	add $t0, $t0, $t2
	
	sw $t1, 0($t0)
	
	sw $t1, 124($t0)
	sw $t1, 128($t0)
	sw $t1, 132($t0)
		 
	sw $t1, 248($t0)	 
	sw $t1, 252($t0)	 
	sw $t1, 256($t0)	 
	sw $t1, 260($t0)
	sw $t1, 264($t0)
	
	sw $t1, 372($t0)
	sw $t1, 376($t0)
	sw $t1, 380($t0)
	sw $t1, 384($t0)
	sw $t1, 388($t0)
	sw $t1, 392($t0)
	sw $t1, 396($t0)
	
	sw $t1, 504($t0)
	sw $t1, 508($t0)	 
	sw $t1, 512($t0)	 
	sw $t1, 516($t0)
	sw $t1, 520($t0)
	
	sw $t1, 636($t0)
	sw $t1, 640($t0)
	sw $t1, 644($t0)
		 
	sw $t1, 768($t0)
	
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
		la $a0, 150
		syscall
		lw $ra, 0($sp)
		addi $sp, $sp, 4 # Pop the address of main function from stack
		jr $ra

# ==== Function ot paint Doodler ====

drawdoodle:
	
	la $s0, currCol
	lw $t1, 12($s0) # Loading doodler colour into regsiter $t1
	# lw $t2, displayAddress
	# add $t6, $t2, $t6
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
		la $a0, 150
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
		la $a0, 150
		syscall
		jr $ra
	
	CHANGE1:
	
		li $s3, 1
		la $s5, ourconstant 
		li $v0, 32
		la $a0, 150
		syscall
		jr $ra
		
	CHANGE2:
		
		li $s3, 0
		li $v0, 32
		la $a0, 150
		syscall
		jr $ra

touchbar:
	
		bne $s3, $zero, ENDtouch
	
	IFtouch:
		
		# bringing the left leg of doodler down
		la $t0, bars
		lw $t8, displayAddress
		lw $t5, 0($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		sub $t8, $t8, $t5
		
		lw $t5, 4($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		sub $t8, $t8, $t5
		
		lw $t5, 8($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		sub $t8, $t8, $t5
		
		lw $t5, 12($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT
		addi $t5, $t5, 4
		sub $t8, $t8, $t5
		
		addi $t6, $t6, 8 	# bringing the left leg of doodler down and right 2 units
		lw $t5, 0($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		sub $t8, $t8, $t5
		
		lw $t5, 4($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2

		sub $t8, $t8, $t5
		
		lw $t5, 8($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2

		sub $t8, $t8, $t5
		
		lw $t5, 12($t0)
		add $t8, $t8, $t5
		
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2
		addi $t5, $t5, 4
		addi $t8, $t8, 4
		beq $t6, $t8, CONT2

		sub $t8, $t8, $t5
		
		addi $t6, $t6, -8
		
		j ENDtouch
	
	CONT:
		
		lw $s5, ourconstant
		li $s3, 1
		j message
		#j ENDtouch
	
	CONT2:
		addi $t6, $t6, -8
		lw $s5, ourconstant
		li $s3, 1
		j message
		#j ENDtouch
	
	ENDtouch:
		
		jr $ra

touchbottom:
	
	lw $t8, displayAddress
	addi $t8, $t8, 3968
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
	beq $t6, $t8, CONTbottom
	addi $t8, $t8, 4
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
		

#====== Function to paint all four bars ======
paintBar:
	la $s0, currCol
	lw $t1, 8($s0) # Colour of bar loaded 
	lw $t2, displayAddress # Display address loaded
	la $s0, bars
	
	# == 1st Bar ==
	lw $t0, 0($s0)
	add $t0, $t0, $t2 # Adds offset to diplay address
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)
	
	#== 2nd Bar ==
	lw $t0, 4($s0)
	add $t0, $t0, $t2 # Adds offset to diplay address
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)
	
	#== 3rd Bar ==
	lw $t0, 8($s0)
	add $t0, $t0, $t2 # Adds offset to diplay address
	sw $t1, 0($t0)
	sw $t1, 4($t0)
	sw $t1, 8($t0)
	sw $t1, 12($t0)	 
	sw $t1, 16($t0)	 
	sw $t1, 20($t0)	 
	sw $t1, 24($t0)	 
	sw $t1, 28($t0)
	
	#== 4th Bar ==
	lw $t0, 12($s0)
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
	
# == messages ===
message: 		
	li $v0, 42 # Generate random number for position from 0 to 3
	li $a1, 3
	syscall

	beq $a0, 0, cool	
	beq $a0, 1, wow
	beq $a0, 2, yay
	beq $a0, 3, good
	
			
yay: 	
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, currCol
	lw $t1, 16($s0)
	
	# Y 
	sw $t1, 3104($t0)
	sw $t1, 3116($t0)
	sw $t1, 3232($t0)
	sw $t1, 3244($t0)
	
	sw $t1, 3360($t0)
	sw $t1, 3364($t0)
	sw $t1, 3368($t0)
	sw $t1, 3372($t0)
	
	sw $t1, 3500($t0)
	sw $t1, 3628($t0)
	sw $t1, 3624($t0)
	sw $t1, 3620($t0)
	
	#A	
	sw $t1, 3128($t0)
	sw $t1, 3132($t0)
	sw $t1, 3136($t0)
	sw $t1, 3140($t0)
	
	sw $t1, 3256($t0)
	sw $t1, 3384($t0)
	sw $t1, 3512($t0)
	sw $t1, 3640($t0)
	
	sw $t1, 3268($t0)
	sw $t1, 3396($t0)
	sw $t1, 3524($t0)
	sw $t1, 3652($t0)
	
	sw $t1, 3388($t0)
	sw $t1, 3392($t0)
	
	# Y 
	sw $t1, 3148($t0)
	sw $t1, 3160($t0)
	sw $t1, 3276($t0)
	sw $t1, 3288($t0)
	
	sw $t1, 3404($t0)
	sw $t1, 3408($t0)
	sw $t1, 3412($t0)
	sw $t1, 3416($t0)
	
	sw $t1, 3544($t0)
	sw $t1, 3672($t0)
	sw $t1, 3668($t0)
	sw $t1, 3664($t0)
	
	li $v0, 32
	la $a0, 250
	syscall
	j ENDtouch
		
good: 
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, currCol
	lw $t1, 16($s0)
	
	# G
	sw $t1, 3104($t0)
	sw $t1, 3108($t0)
	sw $t1, 3112($t0)
	
	sw $t1, 3232($t0)
	sw $t1, 3360($t0)
	sw $t1, 3488($t0)
	
	sw $t1, 3492($t0)
	sw $t1, 3496($t0)
	sw $t1, 3368($t0)
	
	# O
	sw $t1, 3120($t0)
	sw $t1, 3124($t0)
	sw $t1, 3128($t0)
	
	sw $t1, 3248($t0)
	sw $t1, 3376($t0)
	sw $t1, 3504($t0)
	
	sw $t1, 3256($t0)
	sw $t1, 3384($t0)
	
	sw $t1, 3508($t0)
	sw $t1, 3512($t0)
	
	# O
	sw $t1, 3136($t0)
	sw $t1, 3140($t0)
	sw $t1, 3144($t0)
	
	sw $t1, 3264($t0)
	sw $t1, 3392($t0)
	sw $t1, 3520($t0)
	
	sw $t1, 3272($t0)
	sw $t1, 3400($t0)
	
	sw $t1, 3524($t0)
	sw $t1, 3528($t0)
	
	# L
	
	sw $t1, 3284($t0)
	sw $t1, 3280($t0)
	sw $t1, 3408($t0)
	
	sw $t1, 3160($t0)
	sw $t1, 3288($t0)
	sw $t1, 3416($t0)
	
	sw $t1, 3536($t0)
	sw $t1, 3540($t0)
	sw $t1, 3544($t0)
	
	li $v0, 32
	la $a0, 250
	syscall
	j ENDtouch
	
wow: 
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, currCol
	lw $t1, 16($s0)
	
	# W
	sw $t1, 3104($t0)
	sw $t1, 3232($t0)
	sw $t1, 3360($t0)
	sw $t1, 3488($t0)
	
	sw $t1, 3492($t0)
	sw $t1, 3496($t0)
	sw $t1, 3368($t0)
	sw $t1, 3240($t0)
	sw $t1, 3500($t0)
	sw $t1, 3504($t0)

	sw $t1, 3120($t0)
	sw $t1, 3248($t0)
	sw $t1, 3376($t0)
	sw $t1, 3504($t0)
	
	# O
	sw $t1, 3128($t0)
	sw $t1, 3132($t0)
	sw $t1, 3136($t0)
	sw $t1, 3140($t0)
	
	sw $t1, 3256($t0)
	sw $t1, 3384($t0)
	sw $t1, 3512($t0)
	
	sw $t1, 3268($t0)
	sw $t1, 3396($t0)
	sw $t1, 3524($t0)
	
	sw $t1, 3516($t0)
	sw $t1, 3520($t0)
	
	# W
	sw $t1, 3148($t0)
	sw $t1, 3276($t0)
	sw $t1, 3404($t0)
	sw $t1, 3532($t0)
	
	sw $t1, 3536($t0)
	sw $t1, 3540($t0)
	sw $t1, 3412($t0)
	sw $t1, 3284($t0)
	sw $t1, 3544($t0)
	sw $t1, 3548($t0)

	sw $t1, 3164($t0)
	sw $t1, 3292($t0)
	sw $t1, 3420($t0)
	sw $t1, 3548($t0)
	
	li $v0, 32
	la $a0, 250
	syscall
	j ENDtouch
	
cool:
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, currCol
	lw $t1, 16($s0)
	
	# C
	sw $t1, 3104($t0)
	sw $t1, 3108($t0)
	sw $t1, 3112($t0)
	
	sw $t1, 3232($t0)
	sw $t1, 3360($t0)
	sw $t1, 3488($t0)
	
	sw $t1, 3492($t0)
	sw $t1, 3496($t0)
	
	# O
	sw $t1, 3120($t0)
	sw $t1, 3124($t0)
	sw $t1, 3128($t0)
	
	sw $t1, 3248($t0)
	sw $t1, 3376($t0)
	sw $t1, 3504($t0)
	
	sw $t1, 3256($t0)
	sw $t1, 3384($t0)
	
	sw $t1, 3508($t0)
	sw $t1, 3512($t0)
	
	# O
	sw $t1, 3136($t0)
	sw $t1, 3140($t0)
	sw $t1, 3144($t0)
	
	sw $t1, 3264($t0)
	sw $t1, 3392($t0)
	sw $t1, 3520($t0)
	
	sw $t1, 3272($t0)
	sw $t1, 3400($t0)
	
	sw $t1, 3524($t0)
	sw $t1, 3528($t0)
	
	# L
	sw $t1, 3152($t0)
	sw $t1, 3280($t0)
	sw $t1, 3408($t0)
	
	sw $t1, 3536($t0)
	sw $t1, 3540($t0)
	sw $t1, 3544($t0)	
	
	li $v0, 32
	la $a0, 250
	syscall
	j ENDtouch
	
CONTbottom:
	
	jal base
	li $v0, 10
	syscall	
		
