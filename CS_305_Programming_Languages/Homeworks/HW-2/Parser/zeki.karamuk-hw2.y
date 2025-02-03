%{
#include <stdio.h>
void yyerror (const char *s) /* Called by yyparse on error */
{return;}
extern int yylex();
%}
%token tINPUT
%token tOUTPUT
%token tNODE
%token tEVALUATE
%token tIDENTIFIER
%token tAND
%token tOR
%token tXOR
%token tNOT
%token tTRUE
%token tFALSE
%token tLPR
%token tRPR
%token tASSIGNMENT
%token tCOMMA

%left tASSIGNMENT
%left tLPR tRPR
%left tOR tXOR
%left tAND
%left tNOT /*highest priority*/

%start program

%% /*Grammar rules*/

// PROGRAM

program: non_empty_program
;

non_empty_program: declaration_block circuit_block evaluation_block
;

// Declaration Block

declaration_block: declaration_list
;

declaration_list: declaration
		| declaration_list declaration
;

declaration: tINPUT identifier_list
           | tOUTPUT identifier_list
           | tNODE identifier_list
;

identifier_list: tIDENTIFIER
               | identifier_list tCOMMA tIDENTIFIER /*For recursive actions such as tINPUT A,B,C,D,E,F*/
;

// Circuit Design Block

circuit_block: assignment_list;

assignment_list: assignment
	       | assignment_list assignment
;

assignment: tIDENTIFIER tASSIGNMENT expr
;

expr: expr tOR term
    | expr tXOR term
    | term
;

term: term tAND factor
    | factor
;

factor: tNOT factor
      | tLPR expr tRPR
      | tLPR expr tRPR tNOT
      | tIDENTIFIER
      | tIDENTIFIER tNOT
      | boolean_expression
;

boolean_expression: tTRUE
                  | tFALSE
;

// Evaluation Block

evaluation_block: evaluation_list
;

evaluation_list: evaluation 
	       | evaluation_list evaluation
;

evaluation: tEVALUATE tIDENTIFIER tLPR input_initialization_list tRPR
;

input_initialization_list: input_initialization
                         | input_initialization_list tCOMMA input_initialization
;

input_initialization: tIDENTIFIER tASSIGNMENT boolean_expression
;

%%

int main ()
{
if (yyparse())
{
// parse error
printf("ERROR\n");
return 1;
}
else
{
// successful parsing
printf("OK\n");
return 0;
}
}
