.data
displayAddress: .word 0x10008000
colours: .word 0xBFFFF7, 0x050A45, 0x66440E, 0xFF69B4

.text

	
message: 		
	li $v0, 42 # Generate random number for position from 0 to 3
	li $a1, 3
	syscall
	
	li $v0, 1 #print value of a0
	syscall

	beq $a0, 0, cool	
	beq $a0, 1, wow
	beq $a0, 2, yay
	beq $a0, 3, good
			
yay: 	
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, colours
	lw $t1, 12($s0)
	
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
	j end
		
good: 
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, colours
	lw $t1, 12($s0)
	
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
	j end
	
wow: 
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, colours
	lw $t1, 12($s0)
	
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
	j end
	
cool:
	la $s0, displayAddress
	lw $t0, 0($s0)
	la $s0, colours
	lw $t1, 12($s0)
	
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
	j end
	
end: