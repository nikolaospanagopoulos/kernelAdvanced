org 0x7c00

mov bx, 0x1000
mov es, bx
mov bx, 0  ;ES:BX = 0x1000:0
mov dh, 0 ;number of sectors to load
mov dl, 0h ;drive number to load
mov ch, 0x0
mov cl, 0x02
;;setup ES:BX to load sector to memory location

readDisk:
   mov ah, 0x02
   mov al, 0x01
   int 0x13

   jc readDisk
   mov ax, 0x1000
   mov ds, ax
   mov es, ax
   mov fs, ax
   mov gs, ax
   mov ss, ax



   jmp 0x1000:0


times 510-($-$$) db 0

dw 0xaa55


