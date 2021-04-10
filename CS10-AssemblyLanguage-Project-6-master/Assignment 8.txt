;Marian Zlateva
; Finds the GCD of 2 arrays and finds the number of matches between the second array and the array of resulting GCDs

INCLUDE Irvine32.inc
CountMatchingBtwnArrays PROTO, array1Pointer:  SDWORD, array2Pointer:  SDWORD, arrayLength:  DWORD
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	xPairs SDWORD 20, 9, 432, 24, 49, 339, 63
	yPairs SDWORD 5, 7, 226, 18, 7, 9, 9
	gcdPairs SDWORD 7 DUP(?) ;should become 5, 1, 2, 6, 7, 3, 9


	num1 SDWORD ?
	num2 SDWORD ?
	gcd DWORD ?

	rem DWORD ?

	message1 BYTE "GCD of ", 0
	message2 BYTE " and ", 0
	message3 BYTE " is ", 0

	message4 BYTE "Matching count btwn gcd array and yPairs: ",0
.code
;performs the calculation
main proc
	call GenerateGCDFromArrays

	mov edx, OFFSET message4
	call writeString ;prints message4

	INVOKE CountMatchingBtwnArrays, ADDR yPairs,ADDR gcdPairs, LENGTHOF yPairs ;stores number of matching pairs in eax
	call writeInt ;prints the number of matching pairs
	
	INVOKE ExitProcess,0
main ENDP
;---------------------------------------------------------
CountMatchingBtwnArrays PROC USES ebx ecx edx esi,
	array1Pointer:  SDWORD, ;first array
	array2Pointer:  SDWORD, ;second array
	arrayLength:  DWORD ;length of arrays
;
;Counts number of alike pairs
;recives array1, array2, arrayLength
;returns eax = count
;---------------------------------------------------------
	
	mov eax, 0 ;sets eax to 0 so it can count alike pairs
	
	mov ecx, arrayLength
	mov edx, 0
	L1:
		mov esi,array1Pointer ;pointer to array1
		mov ebx, [esi+edx] ;pointer a spot in array1
		mov esi,array2Pointer ;pointer to array2
		cmp [esi+edx], ebx ;compares a spot in array1 with a spot in array2

		jne NOINCREMENT ; if array1[edx]!=array2[edx], then skip the increment of eax
		inc eax
		NOINCREMENT:

		add edx, TYPE xPairs ;increments to the next spot in the arrays
	loop L1

	ret ;return
CountMatchingBtwnArrays ENDP
;---------------------------------------------------------
GenerateGCDFromArrays PROC
;
;Generates the GCD(greatest common divisor) of two integers
;recives xPairs, yPairs, length
;returns gcd = GCD of num1 and num2
;---------------------------------------------------------
	pushad
	mov ecx, LENGTHOF xPairs ;counter
	mov esi, 0 ;index for the arrays
	L1:
		mov edx, OFFSET message1
		call writeString ;prints message1

		mov eax, xPairs[esi]
		mov num1, eax ;moves the current index of xPairs into num1
		call writeint ;prints the new num1

		mov edx, OFFSET message2
		call writeString ;prints message2

		mov eax, yPairs[esi]
		mov num2, eax ;moves the current index of yPairs into num2
		call writeint ;prints the new num2

		call GenerateGCD ;sets gcd to the GCD of num1 and num2
	
		mov edx, OFFSET message3
		call writeString ;prints message3
		
		mov eax, gcd
		mov gcdPairs[esi], eax ;stores the new gdc into the gcdPairs array

		mov eax, gcdPairs[esi]
		call writeint ;prints the gcd

		call crlf ;new line
		call crlf ;new line

		add esi, TYPE xPairs ;increments to the next spot in the arrays

		loop L1
	popad
	ret
GenerateGCDFromArrays ENDP
;---------------------------------------------------------
GenerateGCD proc
;
;Generates the GCD(greatest common divisor) of two integers
;recives num1, num2
;returns gcd = GCD of num1 and num2
;---------------------------------------------------------
	pushad ;pushes the 32 bit registers onto the stack
	;call writeint
	
	cmp num2,0 ;compares num2 to 0
	jle DONE ;if num2=0 then go to DONE


	mov eax, num1
	mov ebx, num2
	call GenerateMod ;does num1%num2 and stores value in rem

	mov ebx, num2
	mov num1, ebx ;sets num1 to num2
		
	mov ecx, rem
	mov num2, ecx ;sets num2 to rem
		
	call GenerateGCD

	
	
	DONE:
	mov eax, num1
	mov gcd, eax ;sets gcd to num1

	popad ;pops the 32 bit registers from the stack
	ret ;return
GenerateGCD ENDP

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
GenerateMod ENDP

end main

COMMENT !
GCD of +20 and +5 is +5

GCD of +9 and +7 is +1

GCD of +432 and +226 is +2

GCD of +24 and +18 is +6

GCD of +49 and +7 is +7

GCD of +339 and +9 is +3

GCD of +63 and +9 is +9

Matching count btwn gcd array and yPairs: +3
!