org 0x7c00

; set video mode. empty screen
mov ah, 0x00
mov al, 0x03
int 0x10

;change color
mov ah, 0x0B
mov bh, 0x00
mov bl, 0x01
int 0x10

mov ah, 0x0e
mov bx, testString
call printString
mov bx, testString2
call printString


;print sample hex
mov dx, 0x12AB
call printHex


endPrg:
   jmp $
;include file

include 'printString.asm'
include 'printHex.asm'




testString: db 'Test print chars ',0xA,0xD ,0
testString2: db 'Hex test: ',0


   times 510-($-$$) db 0

   dw 0xaa55


