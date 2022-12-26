diskLoad:
   push dx ;store dx on the stack to read number of sectors read later
   mov ah, 0x02 ;bios read disk sectors into memory
   mov al, dh
   mov ch, 0x00 ;cylinder 0
   mov dh, 0x00 ;head 0
   mov cl, 2 ;sector to start reading from
   int 0x13
   jc diskError ;jump if error
   pop dx
   cmp dh, al
   jne diskError
   ret

diskError:
   mov bx, DISK_ERROR_MSG
   call printString
   hlt
DISK_ERROR_MSG: db 'Disk read error!', 0

include 'printString.asm'
