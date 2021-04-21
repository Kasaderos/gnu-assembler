ASM=as
ASM_FLAGS=--64 -g
LINKER=ld
LINKER_FLAGS=-m elf_x86_64 -dynamic-linker=/lib64/ld-linux-x86-64.so.2
LIBS=-L . -lc -lscalar_mul 
SOURCES=main.s dot.s

PROGRAMS=scalar 

all: $(PROGRAMS)

dot.o: dot.s 
	$(ASM) $(ASM_FLAGS) dot.s -o dot.o 

libscalar_mul.so: dot.o
	gcc -shared -o libscalar_mul.so dot.o

main.o: main.s
	$(ASM) $(ASM_FLAGS) main.s -o main.o

scalar: libscalar_mul.so main.o
	$(LINKER) $(LINKER_FLAGS) -o scalar main.o $(LIBS)  

clean:
	rm -f *.o scalar

run: scalar
	LD_LIBRARY_PATH=${PWD} ./scalar
	


