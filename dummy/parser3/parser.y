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
| PRINT 

    
