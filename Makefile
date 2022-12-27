OS: ./bin/bootSector.bin ./bin/fileTable.bin ./bin/kernel.bin
	cat ./bin/bootSector.bin ./bin/fileTable.bin ./bin/kernel.bin > ./bin/OS.bin
./bin/bootSector.bin:
	fasm ./bootSector.asm  ./bin/bootSector.bin
./bin/kernel.bin:
	fasm ./kernel.asm ./bin/kernel.bin
./bin/fileTable.bin:
	fasm ./fileTable.asm ./bin/fileTable.bin
clean:
	rm ./bin/*.bin
