; set video mode. empty screen
mov ah, 0x00
mov al, 0x03
int 0x10

;change color
mov ah, 0x0B
mov bh, 0x00
mov bl, 0x01
int 0x10

mov si, testString
call printString
mov si, testString2
call printString


;print sample hex
mov dx, 0x12AB
call printHex

hlt 

testString: db 'Test print chars ',0xA,0xD ,0
testString2: db 'Hex test: ',0




;include file
include 'printHex.asm'
;pad sector
times 510-($-$$) db 0
