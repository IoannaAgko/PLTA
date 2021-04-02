
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
boolean		("true"|"false")
ws 			[ \t\n\r]
string		(\\.|[^\"])* 
int			[1-9][0-9]*|0
%%


^("PROGRAM")      {printtokens(T_PROGRAM); return T_PROGRAM;}
"IF"           {printtokens(T_if); return T_if;}
"+"	{ return '+'; }
"*"	{ return '*'; }
"\n"	{ return '\n'; }
"."       	        {printtokens(T_telia); return T_telia ;}
";"                 {printtokens(T_semicolon); return T_semicolon ;}
":"				    {printtokens(T_colon); return T_colon;}
","				    {printtokens(T_komma); return T_komma;}
\{					{printtokens(T_openagk); return T_openagk;}
\}					{printtokens(T_closeagk); return T_closeagk;}
\[					{printtokens(T_openpar); return T_openpar;}
\]					{printtokens(T_closepar); return T_closepar;}
{boolean} 			{printtokens(T_boolean); return T_boolean;}
\"{string}\"		{printtokens(T_string); return T_string;}
{int}				{printtokens(T_int ); return T_int ;}
\n					{printtokens(T_n); return T_n;}
{ws}				{printtokens(T_ws); return T_ws;}


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
  printf("found token \'%s\' (%d) at line %d \n",yytext,tokennum,yylineno
