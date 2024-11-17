%{
#include<stdio.h>
void yyerror(const char *s);
int yylex();
%}

%token FOR IN TRUE FALSE RETURN RANGE PRINT COLON NUM ID BINARY UNARY DATATYPE STRING FLOAT_NUM COMMENT DEDENT INDENT NEWLINE ERROR 

%left '+' '-'
%left '*' '/'

%%

program: statements
;

statements: statement
          | statements statement 
;

statement: for_loop
         | ID '=' expression
         | '(' NUM ')'
         | INDENT statement DEDENT
;

for_loop: FOR ID IN expression COLON block
;

expression: NUM
          | ID
          | expression '+' expression
          | expression '*' expression
;

block:  statement 
;

%%

int main() {
    yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}
