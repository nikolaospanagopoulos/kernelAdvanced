;prints strings

printString:
   pusha
printChar:
   mov al, [bx]
   cmp al, 0
   je endPrint
   int 0x10
   add bx, 1
   jmp printChar

endPrint:
   popa
   ret
