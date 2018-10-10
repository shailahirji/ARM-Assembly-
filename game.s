.data
guessPrompt:
	.asciz "Guess the number:" 
high:
	.asciz "Too high Guess again. \n"
low:
	.asciz "Too low Guess again. \n"
win:
	.asciz "You guessed correctly in %d tries \n"
formatS:
	.ascii "%s"
formatD:
	.ascii "%d"
count:
	.word 0
number:
	.word 0
input: 
	.word 0
returnMain:
	.word 0

.text
.global main
.global random


main:
	//store lr
	ldr r1,addReturnMain
	str lr,[r1]

 	//get a random number into R0 and manipulate its range
	bl random 
	mov r1,#20
	sdiv r2,r0,r1 //mod number here
	mul r3,r2,r1 //divide by our rand number
	sub r0,r0,r3 // mult quotient by rand number
	
	//lets store rand into variable called Number in stack memory
	ldr r2,addNumber
	str r0,[r2]
 	
loop:
	//print prompt asking user to guess #
	ldr r0,addGuess 
	bl printf
	ldr r0,addFormatD
	
	//get user input
	ldr r1,addInput
	bl scanf
	
	//get user input and store it inside r0 
	ldr r0,addInput
	ldr r0,[r0]

	//compare the output with rand number 
	ldr r1,addNumber //get rand number
	ldr r3,[r1]
	sub r6,r0,r3 //compare, store result in r6
	
//update counter
	ldr r1,addCount
	ldr r0,[r1]
	add r0,r0,#1
//give user hint, too high or too low? Guessed it right?
	str r0,[r1]
	cmp r6, #0
	blt low_guess 
	bgt high_guess
	b end 

low_guess:
	//print guess too low msg
	ldr r0,addLow 
	bl printf
	//re direct to loop for next guess
	b loop

high_guess:
	//print guess too high msg
	ldr r0,addHigh
	bl printf
	//redirect to loop for next guess
	b loop

end:
	// user guessed it correct
	mov r1,r0 //count (number of tries) is already in r0 from loop assignment 
	ldr r0,addWin //pass win prompt
	bl printf
	//restore LR, address of instruction before main was executed
	ldr r1,addReturnMain
	ldr lr,[r1]
	bx lr

addGuess: .word guessPrompt
addHigh: .word high
addLow: .word low
addWin: .word win
addFormatS: .word formatS
addFormatD: .word formatD
addCount: .word count
addNumber: .word number
addInput: .word input 
addReturnMain: .word returnMain
.global printf
.global scanf
