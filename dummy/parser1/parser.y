%{
    #include<stdio.h>
    void yyerror(const char *s);
    int yylex();
%}

%token FOR IN TRUE FALSE RETURN RANGE PRINT COLON NUM ID BINARY UNARY DATATYPE STRING FLOAT_NUM COMMENT NEWLINE INDENT DEDENT  

%%

program: statements
;

statement: for_loop
| ID '=' expression
| NUMBER
;

for_loop: FOR ID IN expression COLON block
;

expression: ID
| NUMBER
| expression '+' expression
;

block: statement
| block statement
;

%%

int main() {
    yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "%s\n", s);
}
