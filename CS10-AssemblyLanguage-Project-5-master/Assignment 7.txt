;Marian Zlateva
; Finds the GCD of 2 numbers that the client inputs 3 times

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	num1 SDWORD ?
	num2 SDWORD ?
	gcd DWORD ?

	rem DWORD ?

	message1 BYTE "Input first number:  ", 0
	message2 BYTE "Input second number:  ", 0
	message3 BYTE "The GCD is:  ", 0
.code
;performs the calculation
main proc
	mov ecx, 3
	L1:
		call GetUserInput ;get the user's 2 numbers assign the 1st number to num1 and the 2nd number to num2
	
		call GenerateGCD ;sets gcd to the GCD of num1 and num2
	
		mov edx, OFFSET message3
		call writeString ;prints message3
	
		mov eax, gcd
		call writeDec ;prints the gcd

		call crlf ;new line
		call crlf ;new line
		loop L1
	invoke ExitProcess,0
main endp

;---------------------------------------------------------
GetUserInput proc
;
;Get the users inputs and stores them
;recives nothing
;returns num1 = first input, num2 = second input
;---------------------------------------------------------
	pushad ;pushes the 32 bit registers onto the stack
	

	;storing first int
	mov edx, OFFSET message1 ;moves the first message into the edx register so that it could be called by writeString
	call writeString ;writes the value that is in the edx register
	
	call readint ;reads the user's input and puts the value into the eax register
	mov esi, OFFSET num1 ;esi now has the memory address of num1
	mov [esi], eax ;num1 now has the value that was passed in by the user


	;storing second int
	mov edx, OFFSET message2 ;moves the second message into the edx register so that it could be called by writeString
	call writeString ;writes the value that is in the edx register
	
	call readint ;reads the user's input and puts the value into the eax register
	mov esi, OFFSET num2 ;esi now has the memory address of num2
	mov [esi], eax ;num2 now has the value that was passed in by the user


	popad ;pops the 32 bit registers from the stack
	ret	;return
GetUserInput endp

;---------------------------------------------------------
OrganizeValues proc
;
;Organizes the num1 and num2 from least to greatest
;recives num1, num2
;returns num1 = greater of num1 and num2, num2 = lesser of num1 and num2
;---------------------------------------------------------
	pushad ;pushes the 32 bit registers onto the stack

	mov eax, num1
	mov ebx, num2

	cmp eax, ebx ;
	jg L1;(jg means that if destination>source (eax>ebx), then jump to the label)
		;swap num1 and num2 if num1<num2
		mov num1, ebx
		mov num2, eax
	L1:
	
	popad ;pops the 32 bit registers from the stack
	ret ;return
OrganizeValues endp

;---------------------------------------------------------
GenerateGCD proc
;
;Generates the GCD(greatest common divisor) of two integers
;recives num1, num2
;returns gcd = GCD of num1 and num2
;---------------------------------------------------------
	pushad ;pushes the 32 bit registers onto the stack

	;make num1 positive
	mov eax, num1
	call GenertateAbs
	mov num1, eax

	;make num2 positive
	mov eax, num2
	call GenertateAbs
	mov num2, eax

	

	call OrganizeValues ;organizes num1 and num2 from least to greatest

	

	L1:
		mov eax, num1
		mov ebx, num2
		call GenerateMod ;does num1%num2 and stores value in rem

		mov ebx, num2
		mov num1, ebx ;sets num1 to num2
		
		mov ecx, rem
		mov num2, ecx ;sets num2 to rem
		
		mov eax, 0
		cmp num2,eax ;compares num2 to 0
		jg L1 ;if num2>0 then go to L1
		
	mov eax, num1
	mov gcd, eax ;sets gcd to num1

	popad ;pops the 32 bit registers from the stack
	ret ;return
GenerateGCD endp

;---------------------------------------------------------
GenertateAbs proc uses ebx ;'uses' tells the assembler to push and pop the register
;
;Generates the absolute value of an integer
;recives eax
;returns eax = absolute value of eax
;---------------------------------------------------------
	cmp eax, 0 ; 
	jg L1 ;(jg means that if destination>source (eax>0), then jump to the label)
		mov ebx, -1
		mul ebx	;multiplies eax by -1 and stores value in eax
	L1: ;Jump here if 0 is greater 

	ret ;return
GenertateAbs endp

;---------------------------------------------------------
GenerateMod proc
;
;Generates the modulus of 2 numbers
;recives eax,ebx
;returns rem = eax%ebx
;---------------------------------------------------------
	pushad ;pushes the 32 bit registers onto the stack

	mov edx, 0 ;sets edx to 0 so that the remainder could be stored in there
	div ebx ;divides eax by ebx (auto puts remainder into edx)
	mov esi, OFFSET rem ;points esi to rem
	mov rem, edx ;stores the remainder in rem
	
	popad ;pops the 32 bit registers from the stack
	ret ;return
GenerateMod endp

end main

COMMENT !
Input first number:  7
Input second number:  21
The GCD is:  7

Input first number:  -7
Input second number:  21
The GCD is:  7

Input first number:  5
Input second number:  255
The GCD is:  5
!