
%{
#include "lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void printtokens(int tokenum);
%}

%option noyywrap
%option yylineno




letter       [a-zA-Z]
digit        [0-9]
fidentifier  ^([P][R][O][G][R][A][M])
alphanums    [a-zA-Z0-9]
strt_pg      {fidentifier}{alphanums}*


%%


^("PROGRAM")      {printtokens(T_PROGRAM); return T_PROGRAM;}
"IF"           {printtokens(T_if); return T_if;}
"+"	{ return '+'; }
"*"	{ return '*'; }
"\n"	{ return '\n'; }
.       	;

\r\n   {  }
<<EOF>>  {printtokens(T_eof); return T_eof;}

%%

int main(int argc, char *argv[]) {
     int token;
     if(argc>1){
       yyin=fopen(argv[1],"r");
       if(yyin==NULL){
         perror ("error open");
         return -1;
       }
     }
     do{
       token=yylex();

     }while(token != T_eof);

     fclose(yyin);
     yyterminate();

}

void printtokens(int tokennum){
  printf("found token \'%s\' (%d) at line %d \n",yytext,tokennum,yylineno);
}
