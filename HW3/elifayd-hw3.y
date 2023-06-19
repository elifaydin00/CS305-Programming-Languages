%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
void yyerror (const char *s) 
{
}
int yylex();



typedef struct node
{
	int intnum;
	double realnum;
	int lineno;
	char * strval;
	int sonType;
	int type;
} node;
%}

%union {
	char * currstr;
	int linenumber;
	int integer_number;
	double real_number;
	
	struct{
		int intnum;
		double realnum;
		int lineno;
		char * strval;
		int sonType;
		int type;
	}node;
	
}

%token tPRINT tGET tSET tFUNCTION tRETURN tIDENT tEQUALITY tIF tGT tLT tGEQ tLEQ tINC tDEC
%token <linenumber> tADD
%token <linenumber> tSUB
%token <linenumber> tMUL
%token <linenumber> tDIV
%token <integer_number> tINT
%token <real_number> tREAL
%token <currstr> tSTRING
%type <node> operation
%type <node> expr
%type <node> returnStmt
%type <node> setStmt
%type <node> print

%start prog

%%
prog:		'[' stmtlst ']'
;

stmtlst:	stmtlst stmt |
;

stmt:		setStmt 		{
                                                if($1.type == 1)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                               	printf("Result of expression on %d is (%d)\n", $1.lineno, $1.intnum);
								
                                                        }
                                                }
                                                else if($1.type == 2)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%.1f)\n", $1.lineno, $1.realnum);
								
                                                        }
                                                }
                                                else if($1.type == 3)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%s)\n", $1.lineno, $1.strval);
								
                                                        }
                                                }
                                        }
		| if 
		| print 		{
                                                if($1.type == 1)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%d)\n", $1.lineno, $1.intnum);
								
                                                        }
                                                }
                                                else if($1.type == 2)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%.1f)\n", $1.lineno, $1.realnum);
								
                                                        }
                                                }
                                                else if($1.type == 3)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%s)\n", $1.lineno, $1.strval);
								
                                                        }
                                                }
                                        }
		| unaryOperation 
		| expr			{
						if($1.type == 1)
						{
							if($1.sonType == 2)
							{
								printf("Result of expression on %d is (%d)\n", $1.lineno, $1.intnum);
                                                        }
							
						}
						else if($1.type == 2)
                                                {
                                                        if($1.sonType == 2)
							{
                                                                printf("Result of expression on %d is (%.1f)\n", $1.lineno, $1.realnum);
								
                                                        }
                                                }
						else if($1.type == 3)
                                                {
                                                        if($1.sonType == 2)
							{
                                                                printf("Result of expression on %d is (%s)\n", $1.lineno, $1.strval);
                                                        }
                                                        
                                                }
					} 
		| returnStmt		{
						if($1.type == 1)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%d)\n", $1.lineno, $1.intnum);
								
                                                        }
                                                }
                                                else if($1.type == 2)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%.1f)\n", $1.lineno, $1.realnum);
								
                                                        }
                                                }
                                                else if($1.type == 3)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%s)\n", $1.lineno, $1.strval);
								
                                                        }
                                                }

					}
;

getExpr:	'[' tGET ',' tIDENT ',' '[' exprList ']' ']'	
		| '[' tGET ',' tIDENT ',' '[' ']' ']'		
		| '[' tGET ',' tIDENT ']'			
;

setStmt:	'[' tSET ',' tIDENT ',' expr ']'	{
								if($6.type == 1)
                                        			{
                                                			$$.intnum = $6.intnum;
                                                			$$.type = 1;
                                                			$$.sonType = $6.sonType;
									if($$.sonType == 2)
                                                                        { 
                                                                                $$.lineno = $6.lineno;
                                                                        }
                                        			}
                                        			else if($6.type == 2)
                                        			{
                                               				$$.realnum = $6.realnum;
                                                			$$.type = 2;
                                                			$$.sonType = $6.sonType;
                                                			if($$.sonType == 2)
                                                                        { 
                                                                                $$.lineno = $6.lineno;
                                                                        }
                                        			}
                                        			else if($6.type == 3)
                                        			{
                                                			$$.strval = $6.strval;
                                                			$$.type = 3;
                                                			$$.sonType = $6.sonType;
									if($$.sonType == 2)
									{
										$$.lineno = $6.lineno;
									}
                                        			}
                                        			else
                                        			{
                                                			$$.type = 4;
                                                			$$.sonType = 1;
                                        			}							
							}
;

if:		'[' tIF ',' condition ',' '[' stmtlst ']' ']'
		| '[' tIF ',' condition ',' '[' stmtlst ']' '[' stmtlst ']' ']'
;

print:		'[' tPRINT ',' expr ']'		{
                                                                if($4.type == 1)
                                                                {
                                                                        $$.intnum = $4.intnum;
                                                                        $$.type = 1;
                                                                        $$.sonType = $4.sonType;
                                                                        if($$.sonType == 2)
                                                                        {
                                                                                $$.lineno = $4.lineno;
                                                                        }
                                                                }
                                                                else if($4.type == 2)
                                                                {
                                                                        $$.realnum = $4.realnum;
                                                                        $$.type = 2;
                                                                        $$.sonType = $4.sonType;
                                                                        if($$.sonType == 2)
                                                                        {
                                                                                $$.lineno = $4.lineno;
                                                                        }
                                                                }
                                                                else if($4.type == 3)
                                                                {
                                                                        $$.strval = $4.strval;
                                                                        $$.type = 3;
                                                                        $$.sonType = $4.sonType;
                                                                        if($$.sonType == 2)
                                                                        {
                                                                                $$.lineno = $4.lineno;
                                                                        }
                                                                }
                                                                else
                                                                {
                                                                        $$.type = 4;
                                                                        $$.sonType = 1;
                                                                }
                                                        }

;

operation:	'[' tADD ',' expr ',' expr ']'		{ 
								if($4.type == 1 && $6.type == 1)
								{
									$$.type = 1;
									$$.lineno = $2;

									$$.intnum = $4.intnum + $6.intnum;
									$$.sonType = 2;
								}
								else if($4.type == 3 && $6.type == 3)
								{
									$$.type = 3;
									$$.lineno = $2;
									char * temp = (char*) malloc(1 + strlen($4.strval) + strlen($6.strval));
									strcpy(temp, $4.strval);
									strcat(temp, $6.strval);
									$$.strval = temp;
									$$.sonType = 2;
								}
								else if($4.type == 2 && $6.type == 2)
								{
									$$.type = 2;
									$$.lineno = $2;
									$$.realnum = $4.realnum + $6.realnum;
									$$.sonType = 2;
								}						
								else if($4.type == 2 && $6.type == 1)
								{
									$$.type = 2;
									$$.lineno = $2;
									$$.realnum = $4.realnum + $6.intnum;
									$$.sonType = 2;
								}
								else if($4.type == 1 && $6.type == 2)
								{
									$$.type = 2;
									$$.lineno = $2;
									$$.realnum = $4.intnum + $6.realnum;
									$$.sonType = 2; 
								}
								else if($4.type == 4 || $6.type == 4)
								{
									$$.type = 4;
									$$.lineno = $2;
									$$.sonType = 1;
								}
								else if($4.type != $6.type)
								{
									$$.type = 4;
									$$.lineno = $2;
									
									printf("Type mismatch on %d \n", $$.lineno);
									$$.sonType = 1;
								}		
							}
		| '[' tSUB ',' expr ',' expr ']'	{
								if($4.type == 1 && $6.type == 1)
                                                                {
                                                                        $$.type = 1;
                                                                        $$.lineno = $2;
                                                                        $$.intnum = $4.intnum - $6.intnum;
                                                                        $$.sonType = 2;
                                                                }
								else if($4.type == 2 && $6.type == 2)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.realnum - $6.realnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 2 && $6.type == 1)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.realnum - $6.intnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 1 && $6.type == 2)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.intnum - $6.realnum;
                                                                        $$.sonType = 2;
                                                                }
								else if($4.type == 4 || $6.type == 4)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
                                                                        $$.sonType = 1;
                                                                }
								else if($4.type == 3 && $6.type == 3)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
									
                                                                        printf("Type mismatch on %d \n", $$.lineno);
                                                                        $$.sonType = 1;
                                                                }
                                                                else if($4.type != $6.type)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
                
									printf("Type mismatch on %d \n", $$.lineno);
									$$.sonType = 1;
                                                                }
							}
		| '[' tMUL ',' expr ',' expr ']'	{ 
								if($4.type == 1 && $6.type == 1)
                                                                {
                                                                        $$.type = 1;
                                                                        $$.lineno = $2;
                                                                        $$.intnum = $4.intnum * $6.intnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 2 && $6.type == 2)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.realnum * $6.realnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 2 && $6.type == 1)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.realnum * $6.intnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 1 && $6.type == 2)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.intnum * $6.realnum;
                                                                        $$.sonType = 2;
                                                                }
								else if($4.type == 1  && $6.type == 3)
                                                                {
                                                                        $$.type = 3;
                                                                        $$.lineno = $2;
									if($4.intnum < 0)
									{
										$$.type = 4;
                                                                        	$$.lineno = $2;
                                                                        	printf("Type mismatch on %d \n", $$.lineno);
                                                                        	
                                                                        	$$.sonType = 1;
									}
									else if($4.intnum == 0)
									{
										char * temp = (char *) malloc(sizeof(char));
										$$.strval = temp;
										$$.sonType = 2;
									}
									else
									{
										char * temp = (char *) malloc(1 + $4.intnum * strlen($6.strval));
										strcpy(temp, $6.strval);
										int i;
										for(i = 1; i < $4.intnum; i = i + 1)
										{
											strcat(temp, $6.strval);
										}
                                                                        	$$.strval = temp;
                                                                        	$$.sonType = 2;
									}
                                                                }
                                                                else if($4.type == 4 || $6.type == 4)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
                                                                        $$.sonType = 1;
                                                                }
								else if($4.type == 3 && $6.type == 3)
								{
									$$.type = 4;
                                                                        $$.lineno = $2;
                                                                        printf("Type mismatch on %d \n", $$.lineno);
									
                                                                        $$.sonType = 1;
								}
                                                                else if($4.type != $6.type)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
                                                                        printf("Type mismatch on %d \n", $$.lineno);
									
									$$.sonType = 1;
                                                                }
							}
		| '[' tDIV ',' expr ',' expr ']'	{ 
								if($4.type == 1 && $6.type == 1)
                                                                {
                                                                        $$.type = 1;
                                                                        $$.lineno = $2;
                                                                        $$.intnum = $4.intnum / $6.intnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 2 && $6.type == 2)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.realnum / $6.realnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 2 && $6.type == 1)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
									$$.realnum = $4.realnum / $6.intnum;
                                                                        $$.sonType = 2;
                                                                }
                                                                else if($4.type == 1 && $6.type == 2)
                                                                {
                                                                        $$.type = 2;
                                                                        $$.lineno = $2;
                                                                        $$.realnum = $4.intnum / $6.realnum;
                                                                        $$.sonType = 2;
                                                                }
								else if($4.type == 4 || $6.type == 4)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
                                                                        $$.sonType = 1;
                                                                }
								else if($4.type == 3 && $6.type == 3)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
									
                                                                        printf("Type mismatch on %d \n", $$.lineno);
                                                                        $$.sonType = 1;
                                                                }
                                                                else if($4.type != $6.type)
                                                                {
                                                                        $$.type = 4;
                                                                        $$.lineno = $2;
									
                                                                        printf("Type mismatch on %d \n", $$.lineno);
									$$.sonType = 1;
                                                                }
							}
;	

unaryOperation: '[' tINC ',' tIDENT ']'
		| '[' tDEC ',' tIDENT ']'
;

expr:		tINT 		{
					$$.type = 1;
					$$.sonType = 1;
					$$.intnum = $1;
				}
		| tREAL 	{
					$$.type	= 2;
                                        $$.sonType = 1;
                                        $$.realnum = $1;
				}
		| tSTRING 	{
					$$.type = 3;
                                        $$.sonType = 1;
                                        $$.strval = $1;
				}
		| getExpr 	{
					$$.type = 4;
					$$.sonType = 1;
				} 
		| function 	{
					$$.type = 4;
					$$.sonType = 1;
				} 
		| operation 	{
					if($1.type == 1)
					{
						$$.intnum = $1.intnum;
						$$.type = 1;
						$$.sonType = 2;
						$$.lineno = $1.lineno;
					}
					else if($1.type == 2)
                                        {
                                                $$.realnum = $1.realnum;
                                                $$.type	= 2;
                                                $$.sonType = 2;
                                                $$.lineno = $1.lineno;
                                        }
					else if($1.type == 3)
                                        {
                                                $$.strval = $1.strval;
                                                $$.type = 3;
                                                $$.sonType = 2;
                                                $$.lineno = $1.lineno;
                                        }
					else
					{
						$$.type = 4;
						$$.sonType = 1;
					}
			    	}
		| condition 	{
					$$.type = 4;
					$$.sonType = 1;
				}
;

function:	 '[' tFUNCTION ',' '[' parametersList ']' ',' '[' stmtlst ']' ']' 
		| '[' tFUNCTION ',' '[' ']' ',' '[' stmtlst ']' ']' 
;

condition:	'[' tEQUALITY ',' expr ',' expr ']'	{
								if($4.sonType == 2)
								{
									if($4.type == 1)
									{
										printf("Result of expression on %d is (%d)\n", $4.lineno, $4.intnum);
										
									}
									else if($4.type ==2)
									{
										printf("Result of expression on %d is (%.1f)\n", $4.lineno, $4.realnum);
										
									}
									else if($4.type == 3)
									{
										printf("Result of expression on %d is (%s)\n", $4.lineno, $4.strval);
										
									}
                                                                }
								if($6.sonType == 2)
                                                                {
                                                                        if($6.type == 1)
                                                                        {
                                                                                printf("Result of expression on %d is (%d)\n", $6.lineno, $6.intnum);
										
                                                                        }
                                                                        else if($6.type ==2)
                                                                        {
                                                                                printf("Result of expression on %d is (%.1f)\n", $6.lineno, $6.realnum);
										
                                                                        }
                                                                        else if($6.type == 3)
                                                                        {
                                                                                printf("Result of expression on %d is (%s)\n", $6.lineno, $6.strval);
										
                                                                        }
                                                                }
							}
		| '[' tGT ',' expr ',' expr ']'		{
                                                                if($4.sonType == 2)
                                                                {
                                                                        if($4.type == 1)
                                                                        {
                                                                                printf("Result of expression on %d is (%d)\n", $4.lineno, $4.intnum);
										
                                                                        }
                                                                        else if($4.type ==2)
                                                                        {
                                                                                printf("Result of expression on %d is (%.1f)\n", $4.lineno, $4.realnum);
										
                                                                        }
                                                                        else if($4.type == 3)
                                                                        {
                                                                                printf("Result of expression on %d is (%s)\n", $4.lineno, $4.strval);
										
                                                                        }
                                                                }   
                                                               if($6.sonType == 2)
                                                                {
                                                                        if($6.type == 1)
                                                                        {
                                                                                printf("Result of expression on %d is (%d)\n", $6.lineno, $6.intnum);
										
                                                                        }
                                                                        else if($6.type ==2)
                                                                        {
                                                                                printf("Result of expression on %d is (%.1f)\n", $6.lineno, $6.realnum);
										
                                                                        }
                                                                        else if($6.type == 3)
                                                                        {
                                                                                printf("Result of expression on %d is (%s)\n", $6.lineno, $6.strval);
										
                                                                        }
                                                                }
                                                        }
		| '[' tLT ',' expr ',' expr ']'		{
                                                              if($4.sonType == 2)
                                                                {  
                                                                        if($4.type == 1)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%d)\n", $4.lineno, $4.intnum);
                                                                        }
                                                                        else if($4.type ==2)
                                                                        {
                                                                               
										printf("Result of expression on %d is (%.1f)\n", $4.lineno, $4.realnum);
                                                                        }
                                                                        else if($4.type == 3)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%s)\n", $4.lineno, $4.strval);
                                                                        }
                                                                
                                                                }
                                                                if($6.sonType == 2)
                                                                {
                                                                        if($6.type == 1)
                                                                        {
                                                                             
										printf("Result of expression on %d is (%d)\n", $6.lineno, $6.intnum);
                                                                        }
                                                                        else if($6.type ==2)
                                                                        {
                                                                               
										printf("Result of expression on %d is (%.1f)\n", $6.lineno, $6.realnum);
                                                                        }
                                                                        else if($6.type == 3)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%s)\n", $6.lineno, $6.strval);
                                                                        }
                                                                }
                                                        }
		| '[' tGEQ ',' expr ',' expr ']'	{
                                                                if($4.sonType == 2)
                                                                {
                                                                        if($4.type == 1)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%d)\n", $4.lineno, $4.intnum);
                                                                        }
                                                                        else if($4.type ==2)
                                                                        {
                                                                                printf("Result of expression on %d is (%.1f)\n", $4.lineno, $4.realnum);
										
                                                                        }
                                                                        else if($4.type == 3)
                                                                        {
                                                                               
										printf("Result of expression on %d is (%s)\n", $4.lineno, $4.strval);
                                                                        }
                                                                }
                                                                if($6.sonType == 2)
                                                                {
                                                                        if($6.type == 1)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%d)\n", $6.lineno, $6.intnum);
                                                                        }
                                                                        else if($6.type == 2)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%.1f)\n", $6.lineno, $6.realnum);
                                                                        }
                                                                        else if($6.type == 3)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%s)\n", $6.lineno, $6.strval);
                                                                        }
                                                                }
                                                        }
		| '[' tLEQ ',' expr ',' expr ']'	{
                                                             if($4.sonType == 2)
                                                                {   
                                                                        if($4.type == 1)
                                                                        {
                                                                                printf("Result of expression on %d is (%d)\n", $4.lineno, $4.intnum);
										
                                                                        }
                                                                        else if($4.type ==2)
                                                                        {
                                                                                printf("Result of expression on %d is (%.1f)\n", $4.lineno, $4.realnum);
										
                                                                        }
                                                                        else if($4.type == 3)
                                                                        {
                                                                                printf("Result of expression on %d is (%s)\n", $4.lineno, $4.strval);
										
                                                                        }
                                                                }
                                                                if($6.sonType == 2)
                                                                {
                                                                        if($6.type == 1)
                                                                        {
                                                                               
										printf("Result of expression on %d is (%d)\n", $6.lineno, $6.intnum);
                                                                        }
                                                                        else if($6.type ==2)
                                                                        {
                                                                              
										printf("Result of expression on %d is (%.1f)\n", $6.lineno, $6.realnum);
                                                                        }
                                                                        else if($6.type == 3)
                                                                        {
                                                                                
										printf("Result of expression on %d is (%s)\n", $6.lineno, $6.strval);
                                                                        }
                                                                }
                                                        }
;

returnStmt:	'[' tRETURN ',' expr ']'	{
							if($4.type == 1)
                                                        {
                                                                $$.intnum = $4.intnum;
                                                                $$.type = 1;
                                                                $$.sonType = $4.sonType;
                                                                if($$.sonType == 2)
                                                                {
                                                                        $$.lineno = $4.lineno;
                                                        	}
                                                        }
                                                        else if($4.type == 2)
                                                        {
                                                                $$.realnum = $4.realnum;
                                                                $$.type = 2;
                                                                $$.sonType = $4.sonType;
                                                                if($$.sonType == 2)
                                                                {
                                                                	$$.lineno = $4.lineno;
                                                                }
                                                        }
                                                    	else if($4.type == 3)
                                                        {
                                                                $$.strval = $4.strval;
                                                                $$.type = 3;
                                                                $$.sonType = $4.sonType;
                                                                if($$.sonType == 2)
                                                                {
                                                                        $$.lineno = $4.lineno;
                                                        	}
                                                        }
                                                        else
                                                        {
                                                                $$.type = 4;
                                                                $$.sonType = 1;
                                                	}
						}
		| '[' tRETURN ']'		{
							$$.type = 4;
							$$.type = 1;
						}
;

parametersList: parametersList ',' tIDENT | tIDENT
;

exprList:	exprList ',' expr	{
						if($3.type == 1)
                                                {
                                                        if($3.sonType == 2)
                                                        {
                                                                
								printf("Result of expression on %d is (%d)\n", $3.lineno, $3.intnum);
                                                        }
                                                }
                                                else if($3.type == 2)
                                                {
                                                        if($3.sonType == 2)
                                                        {
                                                               
								printf("Result of expression on %d is (%.1f)\n", $3.lineno, $3.realnum);
                                                        }
                                                }
                                                else if($3.type == 3)
                                                {
                                                        if($3.sonType == 2)
                                                        {
                                                                
								printf("Result of expression on %d is (%s)\n", $3.lineno, $3.strval);
                                                        }
                                                }
					} 
		| expr			{
						if($1.type == 1)
                                                {
                                                        
                                                         if($1.sonType == 2)
                                                        {      
								printf("Result of expression on %d is (%d)\n", $1.lineno, $1.intnum);
                                                        }
                                                }
                                                else if($1.type == 2)
                                                {
                                                        
                                                             if($1.sonType == 2)
                                                        {    
								printf("Result of expression on %d is (%.1f)\n", $1.lineno, $1.realnum);
                                                        }
                                                }
                                                else if($1.type == 3)
                                                {
                                                        if($1.sonType == 2)
                                                        {
                                                                printf("Result of expression on %d is (%s)\n", $1.lineno, $1.strval);
								
                                                        }
						}
					}
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
		return 0;
	}
}
