%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "y.tab.h"

    void add(char *symbol_type, char *symbol_name, char *data_type, int line_no);
    int search(char *symbol_name);

    struct symbol {
        char *name;
        char *type;
        char *data_type;
        int line_no;
    } symbol_table[100]; // Simple symbol table with a maximum of 100 symbols
    int symbol_count = 0;
    extern int yylineno; // Line number from the lexer
%}

%option noyywrap

/* Token definitions */
INCLUDE  "#include"
FOR      "for"
IF       "if"
ELSE     "else"
RETURN   "return"
ID       [a-zA-Z_][a-zA-Z0-9_]*
NUMBER   [0-9]+
DATATYPE int|float|char
UNARY    \+|\-|\|\||\/\/|\%|\*|~|and|or|not
BINARY   &|^|<|>|==|!=
STRLT    \"[^\"]*\"

/* Skip spaces and tabs */
%ignore [ \t]

%%

"#include"      { return INCLUDE; }
"for"           { return FOR; }
"if"            { return IF; }
"else"          { return ELSE; }
"return"        { return RETURN; }
{DATATYPE}      { return DATATYPE; }
{ID}            { return ID; }
{NUMBER}        { return NUMBER; }
{UNARY}         { return UNARY; }
{BINARY}        { return BINARY; }
{STRLT}         { return STRLT; }
\n              { yylineno++; } /* Track line numbers */
.               { return ERROR; }

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yylex();
    return 0;
}
