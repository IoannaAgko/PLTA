%option yylineno

%{
#include "bison.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int error_counter=0;
void yyerror(const char* err);
void printtokens(int tokenum);
%}

%option noyywrap
%option yylineno



letters [a-zA-z]
digit        [0-9]
intident     [1-9]

alphanums    ([a-zA-Z]+)[0-9]+
boolean		("true"|"false")
ws 			[\t\n\r]
string		(\\.|[^\"])*



%%


"PROGRAM"      {printtokens(T_PROGRAM); return T_PROGRAM;}
"FUNCTION"    {printtokens(T_FUNCTION); return T_FUNCTION;}
"VARS"        {printtokens(T_VARS); return T_VARS;}
"CHAR"        {printtokens(T_char); return T_char;}
"ENDFUNCTION" {printtokens(T_end); return T_end;}
"RETURN"      {printtokens(T_return); return T_return;}
"STARTMAIN"    {printtokens(T_main); return T_main;}
"ENDMAIN"      {printtokens(T_endmain); return T_endmain;}
"IF"          {printtokens(T_if); return T_if;}
"SWITCH"      {printtokens(T_SWITCH); return T_SWITCH;}    
"CASE"        {printtokens(T_CASE); return T_CASE;}
"BREAK"       {printtokens(T_BREAK); return T_BREAK;}
"WHILE"       {printtokens(T_WHILE); return T_WHILE;}      
"INT"         {printtokens(T_int); return T_int;}
"FLOAT"      {printtokens(T_float); return T_float;}
"ELSE"        {printtokens(T_else); return T_else;}
"ELSEIF"      {printtokens(T_elseif); return T_elseif;}
"FOR"         {printtokens(T_for); return T_for;}
"=="|"!="	    {printtokens(T_equop); return T_equop;}       
">"|"<"|">="|"<=" {printtokens(T_relop); return T_relop;}
"+"|"-"       {printtokens(T_adop); return T_adop;}
"*"|"/"|"%"|"^"  {printtokens(T_mulop); return T_mulop;}
"||"          {printtokens(T_OROP); return T_OROP;}
"&&"          {printtokens(T_ANDOP); return T_ANDOP;}
"."       	  {printtokens(T_telia); return T_telia ;}
";"           {printtokens(T_semicolon); return T_semicolon ;}
":"				    {printtokens(T_colon); return T_colon;}
","				    {printtokens(T_komma); return T_komma;}
"{"					  {printtokens(T_openagk); return T_openagk;}
"="           {printtokens(T_ASSIGN); return T_ASSIGN;}
"}"					  {printtokens(T_closeagk); return T_closeagk;}
"("           {printtokens(T_open); return T_open;}
")"           {printtokens(T_close); return T_close;}
"["					  {printtokens(T_openpar); return T_openpar;}
"]"					  {printtokens(T_closepar); return T_closepar;}
"STEP"        {printtokens(T_STEP); return T_STEP;}
"TO"           {printtokens(T_TO); return T_TO;}
"ENDFOR"       {printtokens(T_ENDFOR); return T_ENDFOR;}
{boolean} 		{printtokens(T_boolean); return T_boolean;}
{digit}+"."{digit}+  {printtokens(T_floatident); return T_floatident;}
{intident}+|0     {printtokens(T_intident ); return T_intident ;}
{alphanums}|{letters}+  {printtokens(T_charident ); return T_charident ;}
{alphanums}"["{digit}+"]"|{letters}+"["{digit}+"]" {printtokens(T_pin); return T_pin;}


{ws}				{     }
.           {yyerror("unrecognized character");}



<<EOF>>  {printtokens(T_eof); return T_eof;}

%%



void printtokens(int tokennum){
  printf("found token \'%s\' (%d) at line %d \n",yytext,tokennum,yylineno);
}

void yyerror(const char* err){
  error_counter++;
  printf("[error - LINE %d]%s\n",yylineno,err );
  if(error_counter==10){
    printf("found max errors");
  }
  
}

