sv1.exe : main.o spectreVariant1.o
	cc -o sv1.exe main.o spectreVariant1.o

main.o : main.c spectreVariant1.h
	cc -c main.c
spectreVairant1.o : spectreVariant1.c
	cc -c spectreVariant1.c
clean :
	rm sv1.exe main.o spectreVariant1.o 
