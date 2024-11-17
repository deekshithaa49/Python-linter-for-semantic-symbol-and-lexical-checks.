%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

int yylex();
void yyerror(const char *s);
%}

%union {
    int num;
    char* id;
    float float_num;
}

%token <id> ID
%token <num> NUM
%token <float_num> FLOAT_NUM
%token FOR IF ELSE IN DATATYPE TRUE FALSE RETURN RANGE INPUT PRINT SEPERATOR COLON DEF NEWLINE INDENT DEDENT STRING COMMENT BINARY UNARY ERROR
%token LPAREN RPAREN  ASSIGNMENT

%left '+' '-'
%left '*' '/'
%left '='

%%

main: 
    DEF ID LPAREN RPAREN COLON NEWLINE INDENT statements RETURN DEDENT
    ;

statements: 
    statement 
    | statements statement
    ;

statement:
    assignment
    | loop
    | function_call
    | input
    | print_statement
    ;

assignment:
    ID '=' expr
    {
        printf("Assignment to %s\n", $1);
    }
    ;

expr: 
    NUM 
    | ID
    | expr '+' expr
    | expr '-' expr 
    | expr '*' expr 
    | expr '/' expr 
    ;

loop:
    FOR ID IN RANGE LPAREN NUM RPAREN COLON NEWLINE INDENT statements DEDENT
    ;

input:
    ID '=' DATATYPE LPAREN INPUT LPAREN STRING RPAREN RPAREN
    ;

print_statement:
    PRINT LPAREN STRING RPAREN
    ;

function_call:
    ID LPAREN args RPAREN
    {
        printf("Function call to %s\n", $1); 
    }
;

args:
    expr
    | args SEPERATOR expr
;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

int main() {
    printf("Parsing starts...\n");
    yyparse();
    printf("Parsing completed.\n");
    return 0;
}
