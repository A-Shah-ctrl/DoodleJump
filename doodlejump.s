.data 
			
	colourDay: .word 0xBFFFF7, 0xF45F25, 0x050A45, 0x610000 # Sky, Sun, Bar, Doodle 
	colourNight: .word 0xF5F1D8, 0x000000, 0x2DF748, 0xF72D56 # Sky, Moon, Bar, Doodle 
	currCol: .word 0xBFFFF7, 0xF45F25, 0x050A45, 0x610000
	position: .word 16 # position of the sun or moon 
	playerPosition: .word 4028
	time: .word  1 # 1 = Day 0 = Night
	displayAddress:	.word	0x10008000 # Screen start
	bars: .word 4000, 3008, 1952, 976 # starting locations of the bars
	
.text 

main:  # while loop --> ends when touches the bottom of the

	# base
	# moveSun/Moon
	# jumpDoodle
	# base
	
	# Check if time is 1 or 0
	# If time is 1 certain block of code loads colours from colourDay to currCol
	# If time is 0 certain block of code loads colours from colourNight to currCol
	
	# Doodle calculations
		# If eligible --> move bars
			# addBar
			# movement
			
	#loop back
	
# ===== Only paints the screen =====
# 1) Sky
# 2) Sun/Moon
# 3) Bars
# 4) Doodler

base: 
	lw $t0, displayAddress # Display address loaded
	jal sky
	jal paintSunMoon
	jal paintBar
	jal drawdoodle
	j END

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

END: 
	li $v0, 10 
	syscall