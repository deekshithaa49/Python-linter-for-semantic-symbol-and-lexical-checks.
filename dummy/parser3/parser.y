%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>

    
    
    int symbol_count=0;

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

    
