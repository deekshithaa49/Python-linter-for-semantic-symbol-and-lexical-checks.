%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    extern int yylineno;
    void yyerror(const char *s);
    int yylex();
    void add(char *symbol_type, char *symbol_name, char *data_type, int line_no);
    int search(char *symbol_name);

    struct symbol {
        char *name;
        char *type;
        char *data_type;
        int line_no;
    } symbol_table[100];
    int symbol_count = 0;
%}

%token INCLUDE FOR IF ELSE RETURN ID NUMBER DATATYPE UNARY BINARY STRLT
%left '+' '-'
%left '*' '/'

%%

program:
    headers main body return_stmt
;

headers:
    INCLUDE {
        add("Header", "stdio.h", "N/A", yylineno);
    }
;

main:
    DATATYPE ID {
        add("Variable", $2, $1, yylineno);
    }
;

body:
    statements
;

statements:
    statement
    | statements statement
;

statement:
    DATATYPE ID ';' {
        add("Variable", $2, $1, yylineno);
    }
    | ID BINARY statement
    | ID UNARY ';'
    | RETURN NUMBER ';' {
        add("Return", "N/A", "int", yylineno);
    }
;

return_stmt:
    RETURN NUMBER ';' {
        add("Return", "N/A", "int", yylineno);
    }
    | RETURN ID ';' {
        add("Return", $2, "N/A", yylineno);
    }
;

%%

/* Function to add a symbol to the symbol table */
void add(char *symbol_type, char *symbol_name, char *data_type, int line_no) {
    if (search(symbol_name) == 0) {
        symbol_table[symbol_count].name = strdup(symbol_name);
        symbol_table[symbol_count].type = strdup(symbol_type);
        symbol_table[symbol_count].data_type = strdup(data_type);
        symbol_table[symbol_count].line_no = line_no;
        symbol_count++;
    }
}

/* Function to search the symbol table */
int search(char *symbol_name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, symbol_name) == 0) {
            return 1;  // Found the symbol
        }
    }
    return 0;  // Not found
}

/* Error handling function */
void yyerror(const char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}

/* Main function to parse input */
int main() {
    yyparse();
    printf("\nSymbol Table:\n");
    printf("#######################################################################################\n");
    printf("Name\t\tType\t\tData Type\tLine Number\n");
    printf("---------------------------------------------------------------------------------------\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("%s\t\t%s\t\t%s\t\t%d\n", symbol_table[i].name, symbol_table[i].type, symbol_table[i].data_type, symbol_table[i].line_no);
    }
    return 0;
}
