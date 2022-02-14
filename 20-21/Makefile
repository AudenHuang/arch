CC = clang
CFLAGS = -c -Wall -Wextra -O0
AFLAGS = -c -S -Wall -Wextra -fno-verbose-asm
LFLAGS = -Wall -Wextra
DEPS = array.h

all: main array0.s array1.s array2.s array3.s array0-arm.s array1-arm.s
clean:
	rm -f *.o main array0.s array1.s array2.s array3.s array0-arm.s array1-arm.s

main: main.o array.o $(DEPS)
	${CC} ${LFLAGS} main.o array.o -o main

main.o: main.c $(DEPS)
	${CC} ${CFLAGS} main.c -o main.o

array.o: array.c $(DEPS)
	${CC} ${CFLAGS} array.c -o array.o

array0.s: array.c $(DEPS)
	${CC} ${AFLAGS} -O0 array.c -o array0.s

array1.s: array.c $(DEPS)
	${CC} ${AFLAGS} -O1 array.c -o array1.s

array2.s: array.c $(DEPS)
	${CC} ${AFLAGS} -O2 array.c -o array2.s

array3.s: array.c $(DEPS)
	${CC} ${AFLAGS} -O3 array.c -o array3.s

array0-arm.s: array.c $(DEPS)
	${CC} ${AFLAGS} -O0 -target arm64 array.c -o array0-arm.s

array1-arm.s: array.c $(DEPS)
	${CC} ${AFLAGS} -O1 -target arm64 array.c -o array1-arm.s
