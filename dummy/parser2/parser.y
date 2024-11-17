%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yywrap();
void yyerror(const char *s);
%}

%token FOR IF ELSE ID NUM UNARY BINARY DATATYPE TRUE FALSE RETURN RANGE INPUT PRINT SEPARATOR COLON DEF NEWLINE INDENT DEDENT STRING COMMENT

%%
main: 
    DEF "main" '(' ')' COLON NEWLINE INDENT statements RETURN DEDENT
    ;

statements: 
    statement 
    | statements statement
    ;

statement:
    assignment
    | conditional
    | loop
    | function_call
    | input
    | print_statement
    ;

assignment:
    ID "=" expr
    {
        printf("Assignment to %s\n", $1);
    }
    ;

expr: 
    DIGIT 
    | ID
    | expr '+' expr
    | expr '-' expr 
    | expr '*' expr 
    | expr '/' expr 
    ;

conditional:
    IF expr COLON NEWLINE INDENT statements DEDENT
    ;

loop:
    FOR ID IN RANGE '(' DIGIT ')' COLON NEWLINE INDENT statements DEDENT
    ;

input:
    ID "=" DATATYPE '(' INPUT '(' STRING ')' ')'
    ;

print_statement:
    PRINT '(' STRING ')'
    ;

return_stmt:
    RETURN expr
    ;
%%
int main() {
    printf("Parsing starts...\n");
    yyparse();
    printf("Parsing completed.\n");
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}
