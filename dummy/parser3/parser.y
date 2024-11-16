%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>

    struct symbol {
        char *name;
        char *type;
        int line_no;
    } symbol_table[100];
    
    int symbol_count=0;

    void add_symbol(char *name, char *type, int line_no);
    void print_symbol_table();
%}
%union {
    char *str;
}

%token <str> DEF RETURN IF ELIF ELSE FOR IN WHILE PRINT ID NUMBER FLOAT STRING
%token NEWLINE INDENT DEDENT
%%

program:statements
;

statements:statement statements
| statement
;

statement: 
func_def
| conditional
| loop
| PRINT '(' STRING ')' NEWLINE
| ID '=' expr NEWLINE { add_symbol($1, "Variable", yylineno);}
;

func_def:
    DEF ID '(' ')' ':' NEWLINE INDENT statements DEDENT
    { add_symbol($2, "Function", yylineno); }
;

conditional:
    IF condition ':' NEWLINE INDENT statements DEDENT elif_blocks else_block
;

elif_blocks:
    ELIF condition ':' NEWLINE INDENT statements DEDENT elif_blocks
    |
;

else_block:
    ELSE ':' NEWLINE INDENT statements DEDENT
    |
;

loop:
    FOR ID IN expr ':' NEWLINE INDENT statements DEDENT
    | WHILE condition ':' NEWLINE INDENT statements DEDENT
;

condition:
    expr LOGIC_OP expr
    | BOOL
;

expr:
    NUMBER
    | FLOAT
    | ID
    | STRING
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
;

%%

void add_symbol(char *name, char *type, int line_no) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return; // Symbol already exists
        }
    }
    symbol_table[symbol_count].name = strdup(name);
    symbol_table[symbol_count].type = strdup(type);
    symbol_table[symbol_count].line_no = line_no;
    symbol_count++;
}

void print_symbol_table() {
    printf("\n\t\tSymbol Table\n");
    printf("----------------------------------------\n");
    printf("Name\t\tType\t\tLine Number\n");
    printf("----------------------------------------\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("%s\t\t%s\t\t%d\n",
               symbol_table[i].name,
               symbol_table[i].type,
               symbol_table[i].line_no);
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}

int main() {
    yyparse();
    print_symbol_table();
    return 0;
}
    
