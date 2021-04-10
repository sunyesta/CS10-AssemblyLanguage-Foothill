;Marian Zlateva
; performs the calculation (a+b)-(c+d)

INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
;performs the calculation
main proc
	;Fills the registers with assigned values
	mov	eax,1
	mov ebx,2
	mov ecx,3
	mov edx,4

	;Adds the required registers together
	add eax,ebx	;1+2 = 3
	add ecx,edx	;3+4 = 7

	;substracts the value in ecx from the value in eax
	sub eax,ecx ;3-7 = -4

	call dumpregs;
	invoke ExitProcess,0
main endp
end main

COMMENT !
	  EAX=FFFFFFFC  EBX=00000002  ECX=00000007  EDX=00000004
	  ESI=0040100A  EDI=0040100A  EBP=0019FF80  ESP=0019FF74
	  EIP=0040367F  EFL=00000297  CF=1  SF=1  ZF=0  OF=0  AF=1  PF=1
!