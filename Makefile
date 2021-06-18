all:
	bison -d bison.y  
	flex calc.l  
	gcc bison.tab.c lex.yy.c -lfl  
	./a.out input  
	./a.out input1  