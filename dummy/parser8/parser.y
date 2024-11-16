%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"

    extern char* get_symbol_type(char*);
    extern void add_symbol(char*, char*);
    int yylex();
    void yyerror(const char* s);
%}

%union {
    int intval;
    float floatval;
    char* strval;
}

%token <intval> DIGIT
%token <strval> ID
%token DATATYPE
%token BINARY
%token UNARY
%token FOR IF ELSE

%%

program:
    | program statement
    ;

statement:
      declaration
    | assignment
    | expression
    | control_statement
    ;

declaration:
    DATATYPE ID { 
        // Add variable to symbol table with its type
        add_symbol($2, $1); 
    }
    ;

assignment:
    ID '=' expression {
        // Check if variable is declared
        char* var_type = get_symbol_type($1);
        if (var_type == NULL) {
            printf("Error: Variable '%s' not declared.\n", $1);
            exit(1);
        }
    }
    ;

expression:
    DIGIT { $$ = $1; }
    | ID {
        // Type check for variable use
        char* var_type = get_symbol_type($1);
        if (var_type == NULL) {
            printf("Error: Variable '%s' not declared.\n", $1);
            exit(1);
        }
    }
    | expression '+' expression {
        // Check if types are compatible for addition
        if (strcmp($1, "int") == 0 && strcmp($3, "int") == 0) {
            $$ = "int";  // result is int
        } else if (strcmp($1, "float") == 0 || strcmp($3, "float") == 0) {
            $$ = "float";  // result is float
        } else {
            printf("Error: Incompatible types for addition.\n");
            exit(1);
        }
    }
    | expression '-' expression {
        // Similar type checking for subtraction
    }
    | expression '*' expression {
        // Similar type checking for multiplication
    }
    | expression '/' expression {
        // Similar type checking for division
    }
    ;

control_statement:
    FOR ID '=' DIGIT "to" DIGIT '{' statement '}' { 
        // Handle 'for' loop logic here
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
