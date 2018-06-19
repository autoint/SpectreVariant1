sv1.exe : main.o spectreVairant1.o
        cc -o edit spectreVairant1.o

main.o : main.c spectreVairant1.h
        cc -c main.c
spectreVairant1.o : spectreVairant1.c
        cc -c spectreVairant1.c
clean :
        rm sv1.exe main.o spectreVairant1.o 
