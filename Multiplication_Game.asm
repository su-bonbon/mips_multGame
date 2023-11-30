##   ##  ##   ##  ####      # #####  ######  ######   ####      ######    ####     ###     # #####  ######   #####   ##   ##            #####     ###    ##   ##  #######  
### ###  ##   ##   ##      ## ## ##    ##     ##  ##   ##         ##     ##  ##   ## ##   ## ## ##    ##    ### ###  ###  ##           ##   ##   ## ##   ### ###   ##   #  
#######  ##   ##   ##         ##       ##     ##  ##   ##         ##    ##       ##   ##     ##       ##    ##   ##  #### ##           ##       ##   ##  #######   ##      
## # ##  ##   ##   ##         ##       ##     #####    ##         ##    ##       ##   ##     ##       ##    ##   ##  #######           ## ####  ##   ##  ## # ##   ####    
##   ##  ##   ##   ##         ##       ##     ##       ##         ##    ##       #######     ##       ##    ##   ##  ## ####           ##   ##  #######  ##   ##   ##      
##   ##  ##   ##   ##  ##     ##       ##     ##       ##  ##     ##     ##  ##  ##   ##     ##       ##    ### ###  ##  ###           ##   ##  ##   ##  ##   ##   ##   #  
### ###   #####   #######    ####    ######  ####     #######   ######    ####   ##   ##    ####    ######   #####   ##   ##            #####   ##   ##  ### ###  #######  
                                                                                                                                                                           


.data
	InitialB: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15, 16, 18, 20, 21, 24, 25, 27, 28, 30, 32, 35, 36, 40, 42, 45, 48, 49, 54, 56, 63, 64, 72, 81
	Board: .space 148
	PlayerScore: .space 48
	ComputerScore: .space 48
	Space: .asciiz "  "
	Space2: .asciiz " "
	Newline: .asciiz "\n"
	Top: .asciiz "v \n"
	Middle: .asciiz " 1 2 3 4 5 6 7 8 9 \n"
	Bottom: .asciiz "^ \n \n"
	PlayerT: .asciiz "\nPlayer Turn: "
	ComputerT: .asciiz "\nComputer Turn: \n"
	Question1: .asciiz "\nEnter 't' or b' to move the top or bottom slider: "
	Question2: .asciiz "\nEnter the number you want to move the slider to: "
	Error1: .asciiz "\nPlease try another input: "
	Error2: .asciiz "\nThe number you entered is not available on the slider, please try again: "
	Error3: .asciiz "\nThis is turn 1, you can't move the top slider, please try again: "
	Error4: .asciiz "\nThis value is not available on the board, please try again: "
	Victory: .asciiz "\nCongratulations, you won! "
	Defeat: .asciiz "\nOh no, you lost! "
	Again: .asciiz "\nWould you like to play again? (y/n): "
	
.text
Main:
	li $v0, 4
	la $a0, Newline
	syscall
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	add $t5, $zero, $zero
	add $t6, $zero, $zero
	add $t7, $zero, $zero
	add $t8, $zero, $zero
	add $t9, $zero, $zero
	li $a1, 8
	li $v0, 42
	syscall
	move $t9, $a0
	add $t9, $t9, 1
	add $t8, $t9, $zero
	
PrintC:
	li $v0, 4
	la $a0, Space2
	syscall
PrintT:
	beq $t9, 1, PrintM
	li $v0, 4
	la $a0, Space
	syscall
	sub $t9, $t9, 1
	j PrintT
PrintM:
	la $a0, Top
	syscall
	la $a0, Middle
	syscall
	la $a0, Bottom
	syscall
	j BoardI
	
	
BoardI:
	lw $t2, InitialB($t1)
	sw $t2, Board($t1)
	beq $t1, 144, PrintB
	add $t1, $t1, 4
	j BoardI
	
PrintB:
	add $t1, $zero, $zero
PrintL:
	lw $t2, Board($t1)
	li $v0, 1
	add $a0, $t2, $zero
	syscall
	li $v0, 4
	la $a0, Space
	syscall
	bge $t2, 10, skip
	la $a0, Space2
	syscall
skip:
	add $t1, $t1, 4
	add $t3, $t3, 1
	beq $t3, 36, GameStart
	div $t4, $t3, 6
	mfhi $t5
	bne $t5, 0 PrintL
	la $a0, Newline
	syscall
	j PrintL
	
GameStart:
PlayerTurn:
	li $v0, 4
	la $a0, PlayerT
	syscall
Q1:
	la $a0, Question1
	syscall
	li $v0, 12
	syscall
	add $t9, $v0, $zero
	beq $t9, 98, Q2
	beq $t9, 116, Q1check
	li $v0, 4
	la $a0, Error1
	syscall
	j Q1
Q1check: 
	bne $t7, $zero, Q2
	li $v0, 4
	la $a0, Error3
	syscall
	j Q1
	
Q2:
	li $v0, 4
	la $a0, Question2
	syscall
	li $v0, 5
	syscall
	add $t2, $v0, $zero
	bge $t2, 10, Q2error
	ble $t2, 0, Q2error
	j SpaceCheck
Q2error:
	li $v0, 4
	la $a0, Error2
	syscall
	j Q2

SpaceCheck:
	add $t4, $t7, $zero
	add $t5, $t8, $zero
	beq $t9, 98, ChangeB
	beq $t9, 116, ChangeT
SpaceCheckC:
	add $t4, $t7, $zero
	add $t5, $t8, $zero
	beq $t3, 1, ChangeB
	beq $t3, $zero, ChangeT
ChangeB:
	add $t4, $t2, $zero
	j Mult
ChangeT:
	add $t5, $t2, $zero
	j Mult

Mult:
	mul $t3, $t4, $t5
	add $t1, $zero, $zero
MultCheck:
	lw $t2, Board($t1)
	beq $t1, 144, CheckError
	beq $t2, 88, skip2
	beq $t2, 111, skip2
	beq $t2, $t3, Replace
	bgt $t2, $t3, CheckError
skip2:
	add $t1, $t1, 4
	j MultCheck
CheckError:
	add $t4, $t7, $zero
	add $t5, $t8, $zero
	add $t1, $zero, $zero
	beq $t6, 1, ComputerPick
	li $v0, 4
	la $a0, Error4
	syscall
	j Q1
	
Replace:
	add $t7, $t4, $zero
	add $t8, $t5, $zero
	beq $t6, $zero, ReplaceP
	bne $t6, $zero, ReplaceC
ReplaceP:
	add $t2, $zero, 111
	sw $t2, Board($t1)
	add $t6, $zero, 1
	j ScoreP
ReplaceC:
	add $t2, $zero, 88
	sw $t2, Board($t1)
	add $t6, $zero, $zero
	j ScoreC

Reprint:
	add $t1, $zero, $zero
	add $t3, $zero, $zero
ReprintT:
	add $t9 $t8, $zero
	li $v0, 4
	la $a0, Space2
	syscall
ReprintT2:
	beq $t9, 1, ReprintM
	li $v0, 4
	la $a0, Space
	syscall
	sub $t9, $t9, 1
	j ReprintT2
ReprintM:
	add $t9, $t7, $zero
	la $a0, Top
	syscall
	la $a0, Middle
	syscall
	la $a0, Space2
	syscall
ReprintB:
	beq $t9, 1, ReprintB2
	li $v0, 4
	la $a0, Space
	syscall
	sub $t9, $t9, 1
	j ReprintB
ReprintB2:
	la $a0, Bottom
	syscall
ReprintL:
	lw $t2, Board($t1)
	beq $t2, 88, CharPrint
	beq $t2, 111, CharPrint
	li $v0, 1
	add $a0, $t2, $zero
	syscall
skip3:
	li $v0, 4
	la $a0, Space
	syscall
	bge $t2, 10, skip4
	la $a0, Space2
	syscall
skip4:
	add $t1, $t1, 4
	add $t3, $t3, 1
	beq $t3, 36, Turncheck
	div $t4, $t3, 6
	mfhi $t5
	bne $t5, $zero, ReprintL
	la $a0, Newline
	syscall
	j ReprintL
CharPrint:
	li $v0, 11
	add $a0, $t2, $zero
	syscall
	li $v0, 4
	la $a0, Space2
	syscall
	j skip3
	
Turncheck:
	beq $t6, $zero, PlayerTurn
	beq $t6, 1, ComputerTurn

ComputerTurn:
	add $t1, $zero, $zero
	li $v0, 4
	la $a0, ComputerT
	syscall
ComputerPick:
	li $a1, 2
	li $v0, 42
	syscall
	add $t3, $a0, $zero
	li $a1, 9
	li $v0, 42
	syscall
	addi $t2, $a0, 1
	j SpaceCheckC
	
ScoreP:
	add $s0, $zero, $zero
	add $s2, $zero, $zero
	add $s4, $zero, $zero
	add $s5, $zero, $zero
ScorePH:
	lw $s1, Board($s0)
	add $s0, $s0, 4
	beq $s1, 111, ScorePincH
	bne $s1, 111, ScorePdecH
ContinueP1:
	add $s2, $s2, 1
	beq $s2, 36, ScorePV
	div $s3, $s2, 6
	mfhi $s3
	beq $s3, 0, PNextRow
	j ScorePH
	
ScorePincH:
	add $s4, $s4, 1
	beq $s4, 4 PlayerWin
	j ContinueP1
ScorePdecH:
	bge $s4, 1, ScorePdecH2
	j ContinueP1
ScorePdecH2:
	add $s4, $zero, $zero
	j ContinueP1

PNextRow:
	sw $s4, PlayerScore($s5)
	add $s4, $zero, $zero
	add $s5, $s5, 4
	j ScorePH
	
ScorePV:
	add $s0, $zero, $zero
	add $s2, $zero, $zero
	add $s4, $zero, $zero
	add $s6, $zero, $zero
ScorePV2:
	lw $s1, Board($s0)
	add $s0, $s0, 24
	beq $s1, 111, ScorePincV
	bne $s1, 111, ScorePdecV
ContinueP2:
	add $s2, $s2, 1
	beq $s2, 36, ScoreC
	div $s3, $s2, 6
	mfhi $s3
	beq $s3, $zero, PNextColumn
	j ScorePV2
	
ScorePincV:
	add $s4, $s4, 1
	beq $s4, 4 PlayerWin
	j ContinueP2
ScorePdecV:
	bge $s4, 1, ScorePdecV2
	j ContinueP2
ScorePdecV2:
	add $s4, $zero, $zero
	j ContinueP2

PNextColumn:
	sw $s4, PlayerScore($s5)
	add $s4, $zero, $zero
	add $s5, $s5, 4
	add $s6, $s6, 4
	add $s0, $s6, $zero
	j ScorePV2

ScoreC:
	add $s0, $zero, $zero
	add $s2, $zero, $zero
	add $s4, $zero, $zero
	add $s5, $zero, $zero
ScoreCH:
	lw $s1, Board($s0)
	add $s0, $s0, 4
	beq $s1, 88, ScoreCincH
	bne $s1, 88, ScoreCdecH
ContinueC1:
	add $s2, $s2, 1
	beq $s2, 36, ScoreCV
	div $s3, $s2, 6
	mfhi $s3
	beq $s3, 0, CNextRow
	j ScoreCH
	
ScoreCincH:
	add $s4, $s4, 1
	beq $s4, 4, ComputerWin
	j ContinueC1
ScoreCdecH:
	bge $s4, 1, ScoreCdecH2
	j ContinueC1
ScoreCdecH2:
	add $s4, $zero, $zero
	j ContinueC1

CNextRow:
	sw $s4, ComputerScore($s5)
	add $s4, $zero, $zero
	add $s5, $s5, 4
	j ScoreCH
	
ScoreCV:
	add $s0, $zero, $zero
	add $s2, $zero, $zero
	add $s4, $zero, $zero
	add $s6, $zero, $zero
ScoreCV2:
	lw $s1, Board($s0)
	add $s0, $s0, 24
	beq $s1, 88, ScoreCincV
	bne $s1, 88, ScoreCdecV
ContinueC2:
	add $s2, $s2, 1
	beq $s2, 36, Reprint
	div $s3, $s2, 6
	mfhi $s3
	beq $s3, $zero, CNextColumn
	j ScoreCV2
	
ScoreCincV:
	add $s4, $s4, 1
	beq $s4, 4 ComputerWin
	j ContinueC2
ScoreCdecV:
	bge $s4, 1, ScoreCdecV2
	j ContinueC2
ScoreCdecV2:
	add $s4, $zero, $zero
	j ContinueC2

CNextColumn:
	sw $s4, ComputerScore($s5)
	add $s4, $zero, $zero
	add $s5, $s5, 4
	add $s6, $s6, 4
	add $s0, $s6, $zero
	j ScoreCV2


PlayerWin:
	li $v0, 4
	la $a0, Victory
	syscall
	j Playagain
ComputerWin:
	li $v0, 4
	la $a0, Defeat
	syscall
	j Playagain
Playagain:
	la $a0, Again
	syscall
	li $v0, 12
	syscall
	beq $v0, 121, Main
	beq $v0, 110, Exit

Exit:
	li $v0, 10
	syscall
