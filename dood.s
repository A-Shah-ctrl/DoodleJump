.data 
			
	colourDay: .word 0xBFFFF7, 0xF45F25, 0x050A45, 0x610000 # Sky, Sun, Bar, Doodle 
	colourNight: .word 0xF5F1D8, 0x000000, 0x2DF748, 0xF72D56 # Sky, Moon, Bar, Doodle 
	currCol: .word 0xBFFFF7, 0xF45F25, 0x050A45, 0x610000
	position: .word 16 # position of the sun or moon 
	playerPosition: .word 4028
	time: .word  1 # 1 = Day 0 = Night
	displayAddress:	.word	0x10008000 # Screen start
	bars: .word 4000, 3008, 1952, 976 # starting locations of the bars
	jump: .word 1 #If 1, doodler goes high, 0 falls down
	height: .word 0
	maxheight: .word -1920
	ourconstant: .word -1920 # Total height at which the doodler appears to jump
.text 

setUp:
	lw $s5, ourconstant
	lw $s4, maxheight
	lw $s2, height
	lw $s3, jump		# 1 = up, 0 = down
	li $t4, 1
	#lw $t6, playerAddress	# $t6 stores the address of player 1
	#addi $t6, $t6, 4028

main:  # while loop --> ends when touches the bottom of the
	
	lbu $t0, 0xffff0000
	#jal drawdoodle
	# Check if an event occured
	bne $t0, 0, direction

processes:		
	# Continue normal processes
	# Doodle calculations
	# If eligible --> move bars
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
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
#		jal base
#		jal jumpdoodle
#		jal touchbar
		
	REST:
		addi $t6, $t6, -4480
		bgtz $t6, END
		j main
	
direction: 
	#la $s0, key
	lbu $t0, 0xffff0004
	beq $t0, 0x00006a, moveLeft # j is left
	beq $t0, 0x00006b, moveRight # k is right
	j processes
	
# === Doodler moves one left ===
moveLeft:
	lw $s0, playerPosition
	addi $s0, $s0, -4
	sw $s0, playerPosition
	j processes

# === Doodler moves one left ===
moveRight:
	lw $s0, playerPosition
	addi $s0, $s0, 4
	sw $s0, playerPosition
	j processes
	# Check if time is 1 or 0
	# If time is 1 certain block of code loads colours from colourDay to currCol
	# If time is 0 certain block of code loads colours from colourNight to currCol
	
			
	#loop back
	
# ===== Only paints the screen =====
# 1) Sky
# 2) Sun/Moon
# 3) Bars
# 4) Doodler

base: 
	addi $sp, $sp, -4
	sw $ra, 0($sp) # Push address of main function onto the stack
	li $t2, 0
	lw $t0, displayAddress # Display address loaded
	jal sky
	jal paintSunMoon
	jal paintBar
	jal drawdoodle
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
	
# ==== Function ot paint Doodler ====

drawdoodle:
	
	la $s0, currCol
	lw $t1, 12($s0) # Loading doodler colour into regsiter $t1
	lw $t2, displayAddress # Display address loaded
	lw $t6, playerPosition
	add $t6, $t2, $t6
	sw $t1, 0($t6)
	sw $t1, 8($t6)
	sw $t1, -124($t6)
	sw $t1, -128($t6)
	sw $t1, -252($t6)
	sw $t1, -120($t6)
	
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


jumpdoodle:

	
	IFjump:
		lw $t6, playerPosition
		lw $s0, displayAddress
		add $t6, $t6, $s0
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

		sub $t8, $t8, $t5
	
		addi $t6, $t6, -128
		
		addi $t6, $t6, 136 	# bringing the left leg of doodler down and right 2 units
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
		
END: 
	li $v0, 10 
	syscall
