; set video mode. empty screen
mov ah, 0x00
mov al, 0x03
int 0x10

;change color
mov ah, 0x0B
mov bh, 0x00
mov bl, 0x01
int 0x10

;print welcome
;promt
mov si, testString
call printString

;get user input
getInput:
    mov di, cmdString
keyloop:
	mov ax, 0x00
	int 0x16 ;->interrupt for keystroke. char in AL
	mov ah, 0x0e
	cmp al, 0xD ;-> did they press enter?
	je runCommand
	int 0x10
	mov [di], al ;-> get user input into buffer
	inc di ;->go to next byte at di
	jmp keyloop

runCommand:
	mov byte [di], 0 ;->put null terminator
	mov al, [cmdString]
	cmp al, 'F'
	jne notFound
	cmp al, 'N'
	je endProgram
	mov si, successString
	call printString
	jmp getInput
notFound:
    mov si, failString
	call printString
	jmp getInput
endProgram:
	;end pgm
		cli
		hlt 
successString: db 'Command run OK',0xA, 0xD,0
failString: db 'Command failed', 0xA, 0xD, 0
testString: db 'Welcome to PanOs!',0xA,0xD,'****************************',0xA, 0xD, 0xA, 0xD ,'F) file & program browser', 0xA, 0xD, 0
cmdString: db ''




;include file
include 'printHex.asm'
;pad sector
times 510-($-$$) db 0
