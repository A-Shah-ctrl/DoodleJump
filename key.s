.data 
	currCol: .word 0xBFFFF7, 0xF45F25, 0x050A45, 0x610000
	playerPosition: .word 4028
	displayAddress:	.word	0x10008000 # Screen start
	event: .word 0xffff0000 # if a key was pressed
	key: .word 0xffff0004 # which key was pressed
	
.text

main: 
	lbu $t0, 0xffff0000
	#la $s0, event
	#lw $t0, 0($s0)
	jal drawdoodle
	# Check if an event occured
	bne $t0, 0, direction

processes:		
	# Continue normal processes
	jal drawdoodle
	li $v0, 32
	la $a0, 300
	syscall
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