printHex:
   pusha 
   mov cx, 0 ;initialize cx as a loop counter



hexLoop:
;;ASCII 0-9 = hex 0x30-0x39
;;ASCII A-F = hex 0x41-0x46
;;ASCII a-f = hex 0x61-0x66
   cmp cx, 4 ;we are in 16bit mode. Hex values are 4 digits. each one 4 bytes
   je endHexLoop

   ;convert dx values to ASCII
   mov ax, dx
   and ax, 0x000F ;keep only the last digit all the others 0s
   cmp al, 0x39 ;is value 0-9(<=0x39) or A-F (>0x39)
   jle moveIntoBx
   add al, 0x7

moveIntoBx:
   ;move ASCII char into bx string


endHexLoop:
   popa
   ret





hexString: db '0x0000', 0
