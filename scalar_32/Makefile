ASM=as
ASM_FLAGS=--32 -g
LINKER=ld
LINKER_FLAGS=-m elf_i386 --dynamic-linker=/lib/ld-linux.so.2
LIBS=-L . -lc 
SOURCES=main.s dot.s

PROGRAMS=scalar 

all: $(PROGRAMS)

dot.o: dot.s 
	$(ASM) $(ASM_FLAGS) dot.s -o dot.o 

libscalar_mul.so: dot.o
	gcc -m32 -v -shared -o libscalar_mul.so dot.o

main.o: main.s
	$(ASM) $(ASM_FLAGS) main.s -o main.o

scalar: dot.o main.o
	$(LINKER) $(LINKER_FLAGS) -o scalar main.o dot.o $(LIBS)  

clean:
	rm -f *.o scalar

run: scalar
	LD_LIBRARY_PATH=${PWD} ./scalar
	


