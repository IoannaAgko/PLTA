

%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>


extern void yyerror(const char* err);
extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
  extern int yyparse();
    extern int yylineno;
%}

%error-verbose

%union{
	int intval;
	float floatval;
	char charval;
}

%token T_eof   0 "end of file"
%token T_IF   "IF"
%token T_ELSE  "ELSE"
%token T_STARTMAIN "STARTMAIN"
%token T_FOR   "FOR"
%token T_FUNCTION  "FUNCTION"
%token T_PROGRAM  "PROGRAM"
%token T_semicolon  ";"
%token T_komma ","
%token T_openagk "{"
%token T_closeagk "}"
%token T_openpar "["
%token T_closepar "]"
%token T_boolean "true or false"
%token <intval> T_intident "intnumber"
%token T_int "INT"
%token T_VARS "VARS"
%token T_float "FLOAT"
%token <floatval> T_floatident "floatnumber"
%token T_ws "kena"
%token T_telia "."
%token T_ELSEIF "ELSEIF"
%token T_ANDOP "&&"
%token T_OROP "||"
%token T_NOT "!"
%token T_adop  "+ or -"
%token T_equop " == or != "
%token T_end "ENDFUNCTION"
%token T_mulop "* or / or  % or ^"
%token T_char "CHAR"
%token T_ENDMAIN "ENDMAIN"
%token T_return "RETURN"
%token <charval> T_charident "charnumber"
%token T_pin "TABLE"
%token T_open "("
%token T_close ")"
%token T_relop "< or > or <= or >="
%token T_ASSIGN "="
%token T_TO "TO"
%token T_STEP "STEP"
%token T_BREAK "BREAK"
%token T_ENDFOR "ENDFOR"
%token T_SWITCH "SWITCH"
%token T_WHILE "WHILE"
%token T_colon ":"
%token T_CASE "CASE" /**/
%token T_PRINT "PRINT"
%token T_ENDWHILE "ENDWHILE"
%token T_ENDIF "ENDIF"
%token T_THEN "THEN"
%token T_ENDSWITCH "ENDSWITCH"
%token T_DEFAULT "DEFAULT"
%token T_STRUCT "STRUCT"
%token T_ENDSTRUCT "ENDSTRUCT"
%token T_TYPEDEF "TYPEDEF"
%token T_string "string"

%%

PROGRAM: T_PROGRAM name {printf("\n");} body_program ;

name: T_charident ;

Struct : T_STRUCT name {printf("\n");} variable_declaration T_ENDSTRUCT
  |T_TYPEDEF T_STRUCT name {printf("\n");} variable_declaration {printf("\n");} name T_ENDSTRUCT
  ;


body_program : Struct Functions  Main_function
   | Struct Main_function
   | Main_function 
   ;

Functions : T_FUNCTION name T_open P1 T_close body_Function T_return T_charident {printf("\n");} T_end ;

P1 : %empty
   | V1 P1
   ;

V1 : type_variable d
   | type_variable d T_komma
   ;

d  : name| table;


table :T_pin ;

type_variable : T_int
                 | T_float
                 | T_char
                 ;

body_Function : variable_declaration program_commands
             | variable_declaration
             | %empty
             ;

variable_declaration : T_VARS format  T_semicolon ; // format = tropos dilosis 

format : type_variable P2 ;

P2 : V2
   | V2 P2
   ;
V2 : d
   | d T_komma | T_komma d G
   ;

G  : %empty
   ;

program_commands : entoles_anathesis loipes_entoles
                     |entoles_anathesis
                     | loipes_entoles
                     | %empty
                     ;

entoles_anathesis : cock ;

cock: vcock|vcock cock ;

vcock: variable T_ASSIGN expression T_semicolon ;

variable : d ;

Main_function: T_STARTMAIN variable_declaration program_commands T_ENDMAIN
 |  T_STARTMAIN program_commands T_ENDMAIN
 ;

expression : simple_expression
        | complex_expression
        ;

simple_expression : variable
                  | number
                // | sunartisi
                   ;

number : T_intident
       | T_floatident
       ;

A: variable
  | number
  ;

complex_expression :  A  k ;

k : Vk
  | Vk k
  ;

Vk:  T_adop A
  |  T_mulop A
  ;




loipes_entoles : H /* entoles_vroxou entoles_elegxou entoles_ekt
               | entoles_vroxou entoles_ekt
               | entoles_elegxou entoles_ekt
               | entoles_vroxou  entoles_elegxou
               | entoles_ekt
               | entoles_vroxou
               | entoles_elegxou
               | %empty
               ;  */


H : Q 
  |Q H 
  ;

Q : entoles_vroxou entoles_elegxou print
               | entoles_vroxou print
               | entoles_elegxou print
               | entoles_vroxou  entoles_elegxou
               | print
               | entoles_vroxou
               | entoles_elegxou
               //| %empty  ;//






entoles_vroxou : for
                | while
                ;

for : T_FOR counter T_colon T_ASSIGN noumero T_TO giwta T_STEP noumero {printf("\n");} program_commands L T_ENDFOR ;

giwta :T_intident | T_charident ;

noumero : T_intident;

counter : variable ;

while : T_WHILE T_open synthiki T_close {printf("\n");} program_commands L T_ENDWHILE ;


//telestes: telestes_sygkrisis
 | telestes_logikis
 ;//

telestes_sygkrisis: T_relop
 | T_equop
 ;

telestes_logikis: T_ANDOP
 | T_OROP
 ; 

L: %empty
 | break L
 ;

break : T_BREAK T_semicolon ;

print : T_PRINT T_open T_string X T_close T_semicolon ;

X: %empty | joe X  ;

joe:   T_komma d  ;


entoles_elegxou: if
               | switch
               | if switch
               ;

if : T_IF T_open synthiki T_close T_THEN {printf("\n");} program_commands elseif else L T_ENDIF ;

synthiki: P 
        | T   ;
	     
 P: A telestes_sygkrisis A ;
 T: %empty 
  | J T
  ;
 J: P telestes_logikis P 
  | telestes_logikis P
  ;


elseif : %empty                 
 //| T_ELSEIF  program_commands//
      | T_ELSEIF  program_commands elseif
      ;

 else : %empty
      | T_ELSE program_commands
      ;

 switch : T_SWITCH  T_open expression T_close {printf("\n");} case  T_ENDSWITCH ;

case : M L
     | M L case
     | M L default 
     ;

M : T_CASE T_open expression T_close T_colon {printf("\n");} program_commands ;

default : T_DEFAULT T_colon program_commands ;

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

			yyparse();

     fclose(yyin);
     return 0;
}

