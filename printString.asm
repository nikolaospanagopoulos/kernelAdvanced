;prints strings

printString:
   pusha
   mov ah, 0x0e
printChar:
   mov al, [si]
   cmp al, 0
   je endPrint
   int 0x10
   add si, 1
   jmp printChar

endPrint:
   popa
   ret
