%{
#include<stdio.h>
void yyerror(const char *s);
int yylex();
%}

%token FOR WHILE IF ELSE IN TRUE FALSE RETURN RANGE PRINT SEPERATOR COLON DEF ASSIGNMENT BREAK NONE ELIF CONTINUE PASS NUM ID BINARY UNARY DATATYPE STRING FLOAT_NUM COMMENTS NEWLINE ERROR PARA INPUT QUOTES

%left '+' '-'
%left '*' '/'

%%
%start program;

program:main
       |block1
       ;

main:DEF ID PARA PARA COLON NEWLINE block1 NEWLINE RETURN expression
;
   
block1:PRINT PARA STRING PARA NEWLINE conditions_and_loops
      |PRINT string NEWLINE conditions_and_loops
      |input NEWLINE conditions_and_loops
      |conditions_and_loops
      ;

conditions_and_loops:FOR ID IN RANGE PARA condition PARA COLON NEWLINE block
		    |FOR ID IN DATATYPE COLON NEWLINE block
		    |WHILE expression COLON NEWLINE block
	            |IF expression COLON NEWLINE block
	            |block
	            ;

block:inner_if
     |inner_loop
     |PRINT PARA STRING PARA NEWLINE conditions_and_loops
     |PRINT string
     |input NEWLINE conditions_and_loops
     |false_condition
     |PASS NEWLINE false_condition
     |BREAK NEWLINE block1
     |CONTINUE NEWLINE false_condition
     ;
     
expression:NUM
 	  |ID
          |expression '+' expression
          |expression '*' expression
          |expression '/' expression
          |expression '-' expression
          |expression BINARY expression
 	  ;

inner_loop:FOR expression IN RANGE PARA condition PARA COLON NEWLINE block
	  |FOR expression IN DATATYPE COLON NEWLINE block
	  ;

inner_if:IF expression COLON NEWLINE block
	|ELIF expression COLON NEWLINE block
	;

condition:NUM COLON NUM COLON NUM
         |NUM COLON NUM COLON
         |COLON NUM COLON NUM
         |NUM
         ;

input:ID ASSIGNMENT DATATYPE PARA INPUT string PARA NEWLINE block1
     |ID ASSIGNMENT expression NEWLINE block1
     ;

string:PARA QUOTES ID QUOTES PARA NEWLINE
      |PARA expression PARA NEWLINE
      ;
      
false_condition:ELSE COLON NEWLINE block
;

%%

int main() {
    yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}
