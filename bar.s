.data
	colours: .word 0xBFFFF7, 0x050A45, 0x66440E 
	bars: .word 4000, 3008, 1952, 976 #starting locations of the bars
	displayAddress:	.word	0x10008000
	
.globl main

.text
	li $t3, 0
	
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
	j end
	
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
		
