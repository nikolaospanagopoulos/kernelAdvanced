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
	je fileBrowser
	cmp al, 'R'
	je reboot    ;warm reboot
	cmp al, 'N'
	je endProgram
	mov si, failString
	call printString
	jmp getInput



;;;;;;;;;;;;;FILE BROWSER
;;MENU F__________
fileBrowser:
	;RESET SCREEN
	; set video mode. empty screen
	mov ah, 0x00
	mov al, 0x03
	int 0x10

	;change color
	mov ah, 0x0B
	mov bh, 0x00
	mov bl, 0x01
	int 0x10

    mov si, fileTableHeading
	call printString
	xor cx, cx
	mov ax, 0x1000
	mov es, ax
	xor bx, bx
	mov ah, 0x0e
filetableLoop:
    inc bx
	mov al, [ES:BX]
	cmp al, '}'
	je stop
	cmp al, '-'
	je sectorNumLoop
	cmp al, ','
	je nextElement
	inc cx
	int 0x10
	jmp filetableLoop
sectorNumLoop:
    cmp cx, 21
	je filetableLoop
	mov al, ' '
	int 0x10
	inc cx
	jmp sectorNumLoop
nextElement:
    xor cx, cx
	mov al, 0xA
	int 0x10
	mov al, 0xD
	int 0x10
	mov al, 0xA
	int 0x10
	mov al, 0xD
	int 0x10
	jmp filetableLoop
stop:
    hlt





notFound:
    mov si, failString
	call printString
	jmp getInput


;;;;;;;;;;END PROGRAM
;;MENU N__________
endProgram:
	;end pgm
		cli
		hlt 
   
;;;;;;;;;REBOOT
;;MENU R__________
reboot:
   jmp 0xFFFF:0x0000






fileTableHeading:db \
'File/Program      Sector', 0xA, 0xD, \
'************      ******', 0xA, 0xD, 0

successString: db 0xA, 0xD ,'Command run OK',0xA, 0xD,0
failString: db 0xA, 0xD,'Command failed', 0xA, 0xD, 0
testString: db 'Welcome to PanOs!',0xA,0xD,'****************************',0xA, 0xD, 0xA, 0xD ,'F) file & program browser', 0xA, 0xD,\
'R) Reboot',0xA, 0xD, 0
cmdString: db ''




;include file
include 'printHex.asm'
;pad sector
times 510-($-$$) db 0
