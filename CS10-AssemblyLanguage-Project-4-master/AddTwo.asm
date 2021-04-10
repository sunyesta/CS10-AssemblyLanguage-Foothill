;Marian Zlateva
;Encripts and decripts a string from a KEY letter by letter
; Encryption Program (Encrypt.asm)
INCLUDE Irvine32.inc

BUFMAX = 128 ; maximum buffer size
.data
sPrompt BYTE "Enter the plain text:",0
sEncrypt BYTE "Cipher text: ",0
sDecrypt BYTE "Decrypted: ",0
buffer BYTE BUFMAX+1 DUP(0)
key BYTE "ABXmv#7",0
bufSize DWORD ?
.code
main PROC
	call InputTheString ; input the plain text
	call TranslateBuffer ; encrypt the buffer
	mov edx,OFFSET sEncrypt ; display encrypted message
	call DisplayMessage
	call TranslateBuffer ; decrypt the buffer
	mov edx,OFFSET sDecrypt ; display decrypted message
	call DisplayMessage	
	exit
main ENDP
;-----------------------------------------------------
ModforKeyLength PROC
;
; Performs the modulus operation of a%(size of key) for looping over the key
; Receives: eax points to 'a' for a%(size of key)
; Returns: eax points to the solution for a%(size of key)
;-----------------------------------------------------
	push edx ;saves the current val of edx
	push ebx ;saves the current val of ebx
	mov ebx, LENGTHOF key-1;sets the value of the ebx register to be the length of the key (-1 is for the 0 at the end)
	mov edx,0 ;sets edx to 0 so that remainder could be stored in there
	div ebx ;divides eax by ecx (auto puts remainder into edx)
	mov eax,edx ;mov the remainder into eax
	pop ebx ;returns the old val of ebx
	pop edx ;returns the old val of edx
	;call dumpregs
	ret ;ends procedure
ModforKeyLength ENDP
;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad ; save 32-bit registers
	mov edx,OFFSET sPrompt ; display a prompt
	call WriteString	; writes the value that is in the edx adress (1st prompt)
	mov ecx,BUFMAX ; maximum character count
	mov edx,OFFSET buffer ; point to the buffer
	call ReadString ; input the string
	mov bufSize,eax ; save the length
	call Crlf ;new line
	call Crlf
	popad ;restores the registers (should be used with pushad)
	ret
InputTheString ENDP
;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns: nothing
;-----------------------------------------------------
	pushad
	call WriteString
	mov edx,OFFSET buffer ; display the buffer
	call WriteString
	call Crlf
	call Crlf
	popad
	ret
DisplayMessage ENDP
;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov ecx,bufSize ; loop counter
	mov esi,0 ; index 0 in buffer
	mov eax,esi ;key index set to 0
	L1:
		call ModforKeyLength ;performs eax%(key length) and stores the result in the eax register
		mov ebx,OFFSET key ;get the memory adress of the key
		add ebx,eax ;adds the memory index to the key index to get the correct byte
		movzx ebx, BYTE PTR [ebx] ;moves the byte into the ebx register
		xor buffer[esi],bl; translate a byte ;oxrs the byte
		inc esi ; point to next byte for the buffer
		inc eax ; point to next byte for the key index
		loop L1
	popad
	ret
TranslateBuffer ENDP


END main

COMMENT !

Enter the plain text:This is a Plaintext message


Cipher text: *1VJDa#x=B^/6=Z$1+F ;note this decription may be off when pasted into here because of the unkown askii symbols

Decrypted: This is a Plaintext message

! COMMENT