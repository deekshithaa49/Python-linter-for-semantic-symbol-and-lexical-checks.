%{
#include<stdio.h>
void yyerror(const char *s);
int yylex();
%}

%token FOR IN TRUE FALSE RETURN RANGE PRINT COLON NUM ID BINARY UNARY DATATYPE STRING FLOAT_NUM COMMENT DEDENT INDENT NEWLINE ERROR PARA 

%left '+' '-'
%left '*' '/'

%%

program: for_loop
;

for_loop: FOR ID IN  RANGE expression COLON block 
;

expression: ID
          | RANGE
          | PARA expression PARA
          | NUM
          | expression '+' expression
          | expression '*' expression
;

block: NEWLINE PRINT statement
;

statement: PARA STRING PARA NEWLINE assignment
;

assignment: ID UNARY expression
;



%%

int main() {
    yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}
