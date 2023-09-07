sources = main.s io.s selection.s

main: main.o 
	# Criar executável de 32bits em sistema de 64bits
	ld main.o /usr/lib32/libc.so \
		-dynamic-linker /usr/lib/ld-linux.so.2 \
		-o main -m elf_i386 

main.o: $(sources)
	as -32 $(sources) -o main.o

