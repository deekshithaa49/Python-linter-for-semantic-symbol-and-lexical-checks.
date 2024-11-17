%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <string.h>

    int current_indent = 0; 
    int indent_stack[100];   
    int stack_top = 0;     

    void push_indent(int indent) {
        indent_stack[stack_top++] = indent;
    }

    int pop_indent() {
        return indent_stack[--stack_top];
    }
%}

num      [0-9]+
float_num  [0-9]+\.[0-9]+
id         [a-zA-Z_][a-zA-Z0-9_]*
unary      \+|\-|\|\||\/\/|\%|\*|~|and|or|not|is|is\ not
binary     &|^|<|>|==|!=|<=|>=|=|+=|-=|=|/=|%=|*=|/\/=|&=|\|=|^=|<<|>>
datatype   "int"|"float"|"char"|"tuple"|"list"|"set"|"dict"
comments   \#([^\n]*)|\'\'\'(.*?)(\'\'\')|\"\"\"(.*?)(\"\"\")
string      \"[^\"]*\"|'[^\']*\'

%%

"for"               {return FOR;}
"in"                {return IN;}
"True"              {return TRUE;}
"False"             {return FALSE;}
"return"            {return RETURN;} 
"range"             {return RANGE;}
"print"             {return PRINT;}
":"                 {return COLON;}

{num}               {return NUM;}
{id}                {return ID;}
{binary}            {return BINARY;}
{unary}             {return UNARY;}
{datatype}          {return DATATYPE;}
{string}            {return STRING;}
{float_num}         {return FLOAT_NUM;}
{comments}          {return COMMENT;}

[ \t]*              {/*ignore whitespace*/}
\n                  {
    int new_indent = strlen(yytext); 

    while (new_indent < current_indent) {
        current_indent = pop_indent();
        return DEDENT;
    }

    if (new_indent > current_indent) { 
        push_indent(current_indent);
        current_indent = new_indent;
        return INDENT;
    }
    return NEWLINE;
}

.                   {fprintf(stderr, "Unexpected character: %s\n", yytext); return ERROR;}

%%

int yywrap(){
  return 1;
}
