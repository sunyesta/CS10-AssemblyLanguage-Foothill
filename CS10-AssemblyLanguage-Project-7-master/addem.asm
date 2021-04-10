;Assembly Language
;The count longest Increasing list Subroutine
; This subroutine links to Visual C++.
; Marian Zlateva
.586
.model flat,C

CountLongestIncreasingList PROTO, arrayPointer: SDWORD, arrayLength: DWORD

.data
	longestLength DWORD ?

.code
;---------------------------------------------------------
CountLongestIncreasingList PROC USES ebx ecx edx esi,
	arrayPointer: SDWORD, ;first array
	arrayLength: DWORD ;length of arrays
;
; finds the length of the longest increasing subarray
;recives arrayPointer = address of array, arrayLength = length of array
;returns eax = length of the longest increasing subarray
;---------------------------------------------------------
	mov eax, 1 ;set up the counter for the count of the longest increasing subarray
	
	mov esi, arrayPointer ;points esi to the array
	

	mov ebx,[esi] ;holds previous array val

	mov edx, TYPE ebx ;array index
	
	mov ecx, arrayLength
	sub ecx,1
	L1:
		push ecx
		mov ecx, [esi+edx] ;sets ecx to the value inside the current index of the array
		cmp ecx,ebx
		jg SKIP_RETURN_TO_ZERO
			cmp eax, longestLength
			jl SKIP_CHANGE_LONGEST_LENGTH
				mov longestLength, eax
			SKIP_CHANGE_LONGEST_LENGTH:
			mov eax,0
		SKIP_RETURN_TO_ZERO:
		
		mov ebx,ecx
		inc eax ;increments eax by 1
		;call writeint
		add edx, TYPE ebx
		pop ecx
		
	loop L1
	mov eax,longestLength
	ret ;return to where the procedure was called
CountLongestIncreasingList ENDP
end


