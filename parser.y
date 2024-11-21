%{
#include<stdio.h>
void yyerror(const char *s);
int yylex();
%}

%token FOR IF ELSE IN TRUE FALSE RETURN RANGE PRINT SEPERATOR COLON DEF ASSIGNMENT BREAK NONE ELIF CONTINUE PASS NUM ID BINARY UNARY DATATYPE STRING FLOAT_NUM COMMENTS NEWLINE ERROR PARA INPUT QUOTES

%left '+' '-'
%left '*' '/'

%%
%start program;

program:main
       |block1
       ;

main:DEF ID PARA PARA COLON NEWLINE block1 NEWLINE RETURN expression
;
   
block1:PRINT string
      |input
      |for_loop
      ;

for_loop:FOR ID IN RANGE PARA condition PARA COLON NEWLINE block
	|FOR ID IN DATATYPE COLON NEWLINE block
	|IF expression COLON NEWLINE block
	;

block:inner_if
     |inner_loop
     |PRINT string
     |input
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
;

condition:NUM COLON NUM COLON NUM
         |NUM COLON NUM COLON
         |COLON NUM COLON NUM
         |NUM
         ;

input:ID ASSIGNMENT DATATYPE PARA INPUT PARA string PARA PARA 
     |ID ASSIGNMENT expression
     ;

string:PARA QUOTES STRING QUOTES PARA
      |PARA expression PARA
      ;

%%

int main() {
    yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}
