%{
#include <stdio.h>
void yyerror(const char *s) /* Called by yyparse on error */
{

}
%}
%token tSTRING tGET tSET tFUNCTION tPRINT tIF tRETURN
%token tADD tSUB tMUL tDIV
%token tEQUALITY tGT tLT tGEQ tLEQ tINC tDEC 
%token tNUM tIDENT
%start program_jisp

%%
program_jisp:	'[' statements ']'
	      | '[' ']'
;

statements:	statement 
              | statement statements
;

statement:	set_statement
              | if_statement
              | print
              | increment
	      | decrement
              | return_statement
              | expression
;

expression:	  tNUM
              | tSTRING
              | get_expression
              | function_declaration
              | operator_application
              | condition
      ;

condition:		'[' condition_tokens ',' expression ',' expression ']'
;

condition_tokens:	tGT
                      | tLT
                      | tGEQ
                      | tLEQ
                      | tEQUALITY
;

set_statement:	'[' tSET ',' tIDENT ',' expression ']'
;


if_statement:     '[' tIF ',' condition ',' then_body else_opt ']'
        ;

then_body:    '[' statements ']'
         | '[' ']'
        ;

else_opt:   else_body 
            | 
            ;

else_body:    '[' statements ']'
        | '[' ']'
        ;

print:		'[' tPRINT ',' expression ']'		
;

increment:	'[' tINC ',' tIDENT ']'
;

decrement:	'[' tDEC ',' tIDENT ']'
;


get_expression:	 '[' tGET ',' tIDENT ']'
	| '[' tGET ',' tIDENT ',' '[' expressions ']' ']'
;

expressions:	 expression ',' expressions
	| expression
	| 
;


function_declaration:	 '[' tFUNCTION ',' '[' parameter ']' ',' '[' ']' ']'
		| '[' tFUNCTION ',' '[' parameter ']' ',' '[' statements ']' ']'
;

parameter:       parameter ',' tIDENT
		| tIDENT 
		| 
;

                
operator_application:		'[' tADD ',' expression ',' expression ']'
              	      | '[' tSUB ',' expression ',' expression ']'
                      | '[' tDIV ',' expression ',' expression ']'
                      | '[' tMUL ',' expression ',' expression ']'
;


return_statement:	'[' tRETURN ']'
              | '[' tRETURN ',' expression ']'
;

%%
int main()
{
  if(yyparse())
  {
    printf("ERROR\n");
    return 1;
  }
  else
  {
    printf("OK\n");
    return 0;
  }
}
