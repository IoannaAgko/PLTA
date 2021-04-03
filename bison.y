%{
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
int pin[1048]; 
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

%%
//arxi Cfile BNF
cfile: openpar {printf("{\n");} ruleRESTART closepar {printf("}\n");};

//BNF GIA ;,[ ] : ...: 

ENTITIES {printf("\t\"entities\"");} COLON {printf(":\n\t");} openpar {printf("{\n");} kanonas closepar {printf("\n\t}\n");} 

kanonas: COMMA {printf(",\n");} kanonas 
|HASHTAGS {printf("\t\t\"hashtags\"");} colon {printf(":");} openagk {printf("[");} closeagk {printf("]");}
|URLS {printf("\t\t\"urls\"");} colon {printf(":");} openagk {printf("[\n");} openpar {printf("\t\t\t{\n");} kanonas closepar {printf("\t\t\t}\n");}  closepar {printf("\t\t]");}
|mentions{printf("\t\t\"user_mentions\"");} colon {printf(":");} openagk {printf("[");} closeagk {printf("]");};

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
		