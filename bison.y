%{
#include "lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern int yylex();
extern char* yytext;
extern int yyparse();
extern int line_num;
int errorline;
int errors;
int errors=0;
void yyerror(const char* s);

%}

%error-verbose //xriazete se periptwsi xrisis ekfrasewn me perisoteres lekseis apo oso xreiazete
%union { int num; char* string;}
%token colon komma openagk closeagk openpar closepar 
%token boolean
%token string
%token num
%type <string> string
%type <int> num
%token VARS
%token float
%start cfile 
%token ENTITIES HASHTAGS
%token URLS 
%token lineComment
%token blockComment
%token string
%token charLit
%token preDir
%token reserved
%token dt
%token number
%token letter
%token id
%token sumvola
%token isotites
%token logicalsymbol
%token bitwiseOp
%token arithematic
%token assignment
%token rLP
%token rRP
%token cLP
%token cRP
%token sLP
%token sRP
%token delim
%token bitShift
%token ws
%token arithematic
%token reserved
%token assignment
%token digits
%token <string> ID
%left int charLit 
%left id if else for continue break return delete 


%%


%%


int main (int argc, char **argv) {
	FILE *cfile= fopen(argv[1], "r");
	yyin = cfile;
	yyparse();
	if(errors!=0)
	{
		printf("\nError in line %i", errorline);
		exit(EXIT_FAILURE);}
	else
	{
		return 0;
	}
	}

void yyerror (const char *s) {fprintf (stderr, "%s\n", s);} 
		
