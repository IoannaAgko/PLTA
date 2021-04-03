
%{
#include "lib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void printtokens(int tokenum);
%}

%option noyywrap
%option yylineno



letters [a-zA-z]
digit        [0-9]
alphanums    ([a-zA-Z]+)[0-9]+
boolean		("true"|"false")
ws 			[\t\n\r]
string		(\\.|[^\"])*



%%


"PROGRAM"      {printtokens(T_PROGRAM); return T_PROGRAM;}
"FUNCTION"    {printtokens(T_FUNCTION); return T_FUNCTION;}
"VARS"        {printtokens(T_VARS); return T_VARS;}
"CHAR"        {printtokens(T_CHAR); return T_CHAR;}
"ENDFUNCTION" {printtokens(T_end); return T_end;}
"RETURN"      {printtokens(T_return); return T_return;}
"STARTMAIN"    {printtokens(T_main); return T_main;}
"ENDMAIN"      {printtokens(T_endmain); return T_endmain;}
"IF"          {printtokens(T_if); return T_if;}
"/"           {printtokens(T_div); return T_div;}
"INTEGER"         {printtokens(T_int); return T_int;}
"FLOAT"      {printtokens(T_float); return T_float;}
"ELSE"        {printtokens(T_else); return T_else;}
"ELSEIF"      {printtokens(T_elseif); return T_elseif;}
"FOR"         {printtokens(T_for); return T_for;}
"+"	          { printtokens(T_plus); return T_plus; }
"^"           {printtokens(T_power); return T_power;}
"="           {printtokens(T_equop); return T_equop;}
"!="          {printtokens(T_NOT); return T_NOT;}
"&&"          {printtokens(T_ANDOP); return T_ANDOP;}
"||"          {printtokens(T_OROP); return T_OROP;}
"-"           {printtokens(T_minus); return T_minus;}
"*"	          {printtokens(T_mul); return T_mul; }
"."       	  {printtokens(T_telia); return T_telia ;}
";"           {printtokens(T_semicolon); return T_semicolon ;}
":"				    {printtokens(T_colon); return T_colon;}
","				    {printtokens(T_komma); return T_komma;}
"{"					  {printtokens(T_openagk); return T_openagk;}
"}"					  {printtokens(T_closeagk); return T_closeagk;}
"("           {printtokens(T_open); return T_open;}
")"           {printtokens(T_close); return T_close;}
"["					  {printtokens(T_openpar); return T_openpar;}
"]"					  {printtokens(T_closepar); return T_closepar;}
{boolean} 		{printtokens(T_boolean); return T_boolean;}
{letters}+    {printtokens(T_letters); return T_letters;}
{digit}+"."{digit}+  {printtokens(T_float); return T_float;}
{digit}*      {printtokens(T_intnum ); return T_intnum ;}
{alphanums}  {printtokens(T_word ); return T_word ;}
{alphanums}"["{digit}+"]"|{letters}+"["{digit}+"]" {printtokens(T_pin); return T_pin;}


{ws}				{printtokens(T_ws); return T_ws;}



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
