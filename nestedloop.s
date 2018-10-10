.data
i:
	.word 0
j:
	.word 1
l:
	.word 0
return1:
	.word 0
space:
	.asciz " "
star:
	.asciz "*"
newline:
	.asciz "\n"
formatC:
	.asciz "%c"
formatS:
	.asciz "%s"
lastStars:
	.asciz "*******************\n"
.text
.global main
.extern printf
main:
	//store lr 
	ldr r1,addReturn1
	str lr,[r1]
	//store i add->r6 and value->r7
	ldr r6,addi
	ldr r7,[r6]
	//store j add->r8 and value->r9
	ldr r8,addj
	ldr r9,[r8]
	//store l add->r10 and value->r11 
	ldr r10, addl
	ldr r11,[r10]
 
loop1: //i loop

b test2
loop2: //l loop
	//prints leading ws 
	ldr r0,addFormatS
	ldr r1,addSpace
	bl printf
	add r11,r11,#1 //increment l
	str r11,[r10] //update in memory
test2:
	//test for second loop, l 	
	mov r5,#9
	sub r4,r5,r7
	cmp r11,r4
	blt loop2

	//9-i ws printed 
	mov r11,#0 //reset l for next line itr 
	str r11,[r10]

firststar:
	//print first star
	ldr r0,addFormatS
	ldr r1,addStar
	bl printf 

b test3 
loop3: // j loop 
	//print ws between 2 stars 
	ldr r0,addFormatS
	ldr r1,addSpace
	bl printf
	add r9,r9,#1 //increment j 
	str r9,[r8] //update in memory 

test3:
	//test for third loop, j
	/// j < i*2
	mov r4,#2 
	mul r5,r7,r4
	cmp r9,r5
	blt loop3
	// desired number of ws printed 
	mov r9,#1 //reset j to 1 for next itr 
	str r9,[r8] //update j value in memory 

newlineprint:
	//this condition handles first line which has only 1 star
	cmp r7,#0 // i=0, print 1 star, jump to newline
	beq printNewLine
	
	//otw print 2nd star
	ldr r0,addFormatS
	ldr r1,addStar
	bl printf 

printNewLine:
	ldr r0,addFormatS
	ldr r1,addNewLine
	bl printf
 
test1: //increment i, run loops for next line's stars   
	add r7,r7,#1
	str r7,[r6]
	cmp r7,#9
	blt loop1

laststars: //last line of 19 stars 
	ldr r0, addFormatS
	ldr r1,addLastStars //print last 19 stars 
	bl printf 
end:
	//restore lr to add before main was called 
	ldr r1,addReturn1
	ldr lr,[r1]
	bx lr 

addReturn1: .word return1 
addi: .word i
addj: .word j
addl: .word l
addSpace: .word space
addStar: .word star
addNewLine: .word newline
addFormatC: .word formatC
addFormatS: .word formatS
addLastStars: .word lastStars
.global printf
