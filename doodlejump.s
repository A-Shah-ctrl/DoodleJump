.data 
	colourDay: .word  # day colours
	colourNight: .word # night colours
	currCol: .word
	postion: .word # position of the sun or moon 
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

touchBar: 
	# load the value of hte currentbar colour into s0
	# find pixel below the left leg $t6 + 128
	# beq $t
	# $t6 + 8 below right leg  
	# beq $ 
