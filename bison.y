
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

program_commands : assign_commands extra_commands
                     | assign_commands
                     | extra_commands
                     | %empty
                     ;

assign_commands : comm ;

comm: variablecomm | variablecomm comm ;

variablecomm: variable T_ASSIGN expression T_semicolon ;

variable : d ;

Main_function: T_STARTMAIN variable_declaration program_commands T_ENDMAIN
             |  T_STARTMAIN program_commands T_ENDMAIN
             ;

expression : simple_expression
           | complex_expression
           ;

simple_expression : variable
                  | number
                // | function 
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




extra_commands : H /* loop_commands control_commands print_command
               | loop_commands print_command
               |  control_commands print_command
               | loop_commands  control_commands
               | print_command
               | loop_commands
               | control_commands
               | %empty
               ;  */


H : Q 
  |Q H 
  ;

Q : loop_commands control_commands print_command
               | loop_commands print_command
               | control_commands print_command
               | loop_commands  control_commands
               | print_command
               | loop_commands
               | control_commands
               ;






loop_commands : for
                | while
                ;

for : T_FOR counter T_colon T_ASSIGN noumero T_TO type T_STEP noumero {printf("\n");} program_commands L T_ENDFOR ;

type :T_intident 
     | T_charident ;

noumero : T_intident;

counter : variable ;

while : T_WHILE T_open condition T_close {printf("\n");} program_commands L T_ENDWHILE ;


comparison_operator: T_relop
 | T_equop
 ;

logic_operators: T_ANDOP
 | T_OROP
 ; 

L: %empty
 | break_command L
 ;

break_command : T_BREAK T_semicolon ;

print_command : T_PRINT T_open T_string X T_close T_semicolon ;

X : %empty 
  | F X  ;

F :   T_komma d  ;


control_commands: if
                | switch
                | if switch
                ;

if : T_IF T_open condition T_close T_THEN {printf("\n");} program_commands elseif else L T_ENDIF ;

condition : P 
          | T  
		  ;
	     
 P: A comparison_operator A ;
 
 T: %empty 
  | J T
  ;

 J: P logic_operators P 
  | logic_operators P
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

