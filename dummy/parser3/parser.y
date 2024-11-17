%{
#include <stdio.h>
#include <stdlib.h>

/* Function declarations for error handling */
void yyerror(const char *s);
int yylex();
%}

/* Tokens */
%token DEF IF ELSE FOR RETURN IN PRINT IDENTIFIER NUMERIC STRING OPERATOR DELIMITER

/* Precedence and associativity (if needed) */
%right '='
%left '+' '>'
%left ','

%%

program:
    function
    ;

function:
    DEF IDENTIFIER '(' ')' ':' block
        { printf("Function: %s\n", $2); }
    ;

block:
    statement_list
    ;

statement_list:
    /* One or more statements */
    statement_list statement
    | statement
    ;

statement:
    assignment
    | if_statement
    | for_statement
    | return_statement
    | print_statement
    ;

assignment:
    IDENTIFIER '=' expression
        { printf("Assignment: %s = ...\n", $1); }
    ;

if_statement:
    IF expression ':' block
        { printf("If statement\n"); }
    | IF expression ':' block ELSE ':' block
        { printf("If-Else statement\n"); }
    ;

for_statement:
    FOR IDENTIFIER IN expression ':' block
        { printf("For loop with variable %s\n", $2); }
    ;

return_statement:
    RETURN expression
        { printf("Return statement\n"); }
    ;

print_statement:
    PRINT '(' STRING ')'
        { printf("Print statement: %s\n", $3); }
    ;

expression:
    IDENTIFIER
        { printf("Expression: variable %s\n", $1); }
    | NUMERIC
        { printf("Expression: number %d\n", $1); }
    | STRING
        { printf("Expression: string %s\n", $1); }
    ;

%%

/* Error handling function */
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

