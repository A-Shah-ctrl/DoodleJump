.data
	colours: .word 0xBFFFF7, 0xF45F25, 0xF5F1D8, 0x000000
	sun: .word 16
	displayAddress:	.word	0x10008000
	
.text

dynamicSun:
	li $t2, 0
	lw $t0, displayAddress
	jal backcolourDay
	
	la $s0, sun
	lw $t0, 0($s0)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push address of star onto the stack
	
	la $s0, colours
	lw $t0, 4($s0)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push colour of star onto the stack
	
	jal paintSun
	
	lw $s0, sun
	beq $s0, 112, resetSun
	jal moveSun
	
	li $v0, 32
	la $a0, 250
	syscall
	j dynamicSun

resetSun: 
	li $t0, 16
	sw $t0, sun
	j dynamicMoon
		
dynamicMoon: 
	li $t2, 0
	lw $t0, displayAddress
	jal backcolourNight
	
	la $s0, sun
	lw $t0, 0($s0)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push address of star onto the stack
	
	la $s0, colours
	lw $t0, 8($s0)
	addi $sp, $sp, -4
	sw $t0, 0($sp) # Push colour of star onto the stack
	
	jal paintSun
	
	lw $s0, sun
	beq $s0, 112, resetMoon
	jal moveSun
	
	li $v0, 32
	la $a0, 250
	syscall
	j dynamicMoon
	
resetMoon: 
	li $t0, 16
	sw $t0, sun
	j dynamicSun
		
#======= Loop to paint background colour ======
backcolourDay:
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
	bne $t2, 32, backcolourDay
	jr $ra
	
backcolourNight:
	la $s0, colours
	lw $t1, 12($s0) # Colour of background loaded 
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
	bne $t2, 32, backcolourNight
	jr $ra
	
#====== Function to paint the bars ======

paintSun:
	
	lw $t2, displayAddress # Display address 
			
	lw $t1, 0($sp)
	addi $sp, $sp, 4 # Pop the colour from stack 
	
	lw $t0, 0($sp)
	addi $sp, $sp, 4 # Pop the address of bar from stack 
	add $t0, $t0, $t2 # Adds offset to diplay address
	
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

moveSun:
	lw $t0, sun
	addi $t0, $t0, 8
	sw $t0, sun
	jr $ra
end:
	li $v0, 10
	syscall	
