%{
#include <stdio.h>
#include <math.h>
#include <lib.h> 

void yyerror(char *); 
extern FILE *yyin;								
extern FILE *yyout;		


%}

%token Return 
%token find_Function 
%token ; 
%token Vars
%token =
%token +,-,/,*
%token =
%token (
%token )
%token to 
%token step
%token endfor
%token Break 
%token while
%token endwhile
%token sugkritikostelestis
%token logicop 
%token T_FUNCTION  
%token T_PROGRAM  
%token T_char 
%token %empty
%token T_pin 
%token T_int 
%token T_float 
%token T_Char
%token Break 





%%

arxiko programma: PROGRAM onoma swma_programmatos
onoma: T_char 
swma_programmatos:Functions  Main comments>|Main comments
Functions: FUNCTION onoma ( P1 ) swma_Function Return find_Function
P1 : %empty | V1 P1 
V1: tupos metavlitis (onoma|pinakas) | tupos metavlitis (onoma|pinakas) ;
pinakas: T_pin 
tupos_metavlitis:T_int|T_float|T_Char
swma_Funtion:dilwsi_metavlitis entoles_programmatos | dilwsi_metavlitis | entoles_programmatos |%empty
dilwsi metavlitis: Vars tropos_dilwsis
tropos_dilwsis: tupos_metavlitis P2 ;
P2: V2 | V2 P2 
v2:(onoma|pinakas) | (onoma|pinakas) ;
entoles_programmatos: entoles_anathesis loipes_entoles  entoles_anathesis   | loipes_entoles | %empty
entoles_anathesis : metavliti = ekfrasi ;
metavliti : onoma 
ekfrasi: apli_ekfrasi| sunthethi_ekfrasi 
apli ekfrasi:metavliti|arithmos sunartisi
suntheti ekfrasi:( metavltii | arithmos) k
k: Vk | Vk k
Vk: +,-,/,* (arithmos|metavliti) s 
s:%empty |vs s
vs: ( (ekfrasi) )
loipes_entoles: entoles_vrogxou entoles_elegxou
                                                 |entoles_ektupwsis
                                                 |entoles_vrogxou entoles_ektupwsis
                                                 |entoles_elegxou entoles_ektupwsis
                                                 |entoles_ektupwsis | %empty 
                                                 
entoles_vrogxou:for_entoles while_entoles
for_entoles:for entoles_anathesis to (arithmos|metavliti) step arithmos entoles_programmatos L endfor
L:%empty | Vl L
Vl:Break
while entoles: while ( sunthiki ) entoles_programmatos L  endwhile
sunthiki:(metavliti|arithmos) sugkritikostelestis (metavliti|arithmos) | PN  VN
PN: %empty  | VN PN
VN:VZ logicop VZ

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
		
