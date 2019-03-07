sv1.exe : main.o spectreVariant1.o test.o
	cc -o sv1.exe main.o spectreVariant1.o test.o

main.o : main.c spectreVariant1.h
	cc -c main.c
spectreVairant1.o : spectreVariant1.c
	cc -c spectreVariant1.c

test.o :
	cc -c test.c -Wall -DHIT_THRESHOLD={CYCLES}
clean :
	rm sv1.exe main.o spectreVariant1.o test.o *.exe *.o
