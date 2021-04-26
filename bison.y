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
%token T_if   "if" 
%token T_else  "else"
%token T_main  "main"
%token T_for   "for"
%token T_while "while"
%token T_FUNCTION  "FUNCTION"
%token T_PROGRAM  "PROGRAM"
%token T_semicolon  ";"
%token T_komma ","
%token T_openagk "{" 
%token T_closeagk "}"
%token T_openpar "["
%token T_closepar "]"
%token T_boolean "true or false"
%token <intval> T_intident "intnubmer"
%token T_int "INT"
%token T_VARS "VARS"
%token T_float "FLOAT"
%token <floatval> T_floatident "floatnumber" 
%token T_ws "kena"
%token T_telia "."
%token T_elseif "elseif"
%token T_ANDOP "&&"
%token T_OROP "||"
%token T_NOT "!"
%token T_adop  "+ or -"
%token T_equop " == or != "
%token T_end "ENDFUNCTION"
%token T_mulop "* or / or  % or ^"

%token T_char "CHAR"
%token T_endmain "ENDMAIN"
%token T_return "RETURN"
%token <charval> T_charident "charnumber"
%token T_pin "PINAKAS"
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
%token T_colon "colon"
%token T_CASE "CASE"




%%

arxiko_programma: T_PROGRAM onoma {printf("\n");} swma_programmatos ;

onoma: T_charident ;

swma_programmatos : Functions // MAIN comments ;

Functions : T_FUNCTION onoma T_open P1 T_close swma_Function T_return T_charident {printf("\n");} T_end ;

P1 : %empty 
   | V1 P1 
   ;

V1 : tupos_metavlitis d
   | tupos_metavlitis d T_komma
   ;

   d:onoma|pinakas


pinakas : T_pin ; 

tupos_metavlitis : T_int 
                 | T_float 
                 | T_char
                 ;

swma_Function : dilwsi_metavlitis entoles_programmatos 
             | dilwsi_metavlitis 
             | entoles_programmatos 
             | %empty
             ;

dilwsi_metavlitis : T_VARS tropos_dilwsis T_semicolon ; 

tropos_dilwsis : tupos_metavlitis P2 

P2 : V2 
   | V2 P2 
   ;
V2 : d
   | d T_komma | T_komma d G
   ;
   G:%empty ;

entoles_programmatos : entoles_anathesis loipes_entoles  
                     |entoles_anathesis   
                     | loipes_entoles 
                     | %empty
                     ;

entoles_anathesis : cock ;

cock: vcock|vcock cock ;
vcock:metavliti T_ASSIGN ekfrasi T_semicolon ;

metavliti : d ;

ekfrasi : apli_ekfrasi
        | suntheti_ekfrasi 
        ;

apli_ekfrasi : metavliti 
             | arithmos
             // | sunartisi
             ;

arithmos:T_intident|T_floatident ;

A:metavliti|arithmos;

suntheti_ekfrasi :  A  k ;

k : Vk 
  | Vk k
  ;

Vk:  T_adop A s| T_mulop A s;
 
s : %empty 
  | vs s
  ;

vs :T_adop T_open ekfrasi T_close |T_mulop T_open ekfrasi T_close; 

loipes_entoles : entoles_vrogxou /*entoles_elegxou*/ /*entoles_ekt*/
               /* |entoles_vrogxou entoles_ekt*/
               /*|entoles_elegxou entoles_ektupwsis 
               | entoles_ektp 
               | %empty */
               ; 
                                                 
entoles_vrogxou : for_entoles 
                /* | while_entoles */
                ;

for_entoles : T_for skatanathesi T_TO T_intident T_STEP arithmos {printf("\n");} entoles_programmatos L T_ENDFOR ;

skatanathesi:metavliti T_ASSIGN T_intident
L: %empty 
 | Vl L
 ;

Vl : T_BREAK ;

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
