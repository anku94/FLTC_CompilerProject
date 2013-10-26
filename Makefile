CC=gcc

fltc: fltc.l fltc.y
	bison -d fltc.y
	flex fltc.l
	$(CC) -o project fltc.tab.c lex.yy.c 
clean:
	rm fltc.tab.c fltc.tab.h lex.yy.c
