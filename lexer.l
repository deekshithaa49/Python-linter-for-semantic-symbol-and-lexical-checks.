%{
    #include "y.tab.h"
    #include<string.h>
    #include<stdio.h>

    int current_indent = 0;        
    int indent_stack[100];          
    int indent_top = -1;            

    void push_indent(int indent) {
        if (indent_top < 99) { 
            indent_stack[++indent_top] = indent;
        }
    }

    int pop_indent() {
        if (indent_top >= 0) {
            return indent_stack[indent_top--];
        }
        return 0;  
    }
%}

num      [0-9]+
float_num  [0-9]+\.[0-9]+
id         [a-zA-Z][a-zA-Z0-9_]*
unary      \+|\-|\|\||\/\/|\%|\*|~|and|or|not|is|is\ not
binary     &|||^|<|>|==|!=|<=|>=|=|+=|-=|=|/=|%=|*=|/\/=|&=|\|=|^=|<<|>>
datatype   "int"|"float"|"char"|"tuple"|"list"|"set"|"dict"
comments   \#([^\n]*)|\'\'\'(.*?)(\'\'\')|\"\"\"(.*?)(\"\"\")
string      \"[^\"]*\"|'[^\']*\'

%%

"for"               {return FOR;}
"if"                {return IF;}
"else"              {return ELSE;}
"in"                {return IN;}
"True"              {return TRUE;}
"False"             {return FALSE;}
"return"            {return RETURN;} 
"range"             {return RANGE;}
"input"             {return INPUT;}
"print"             {return PRINT;}
","                 {return SEPERATOR;}
":"                 {return COLON;}
"def"               {return DEF;}
"break"             {return BREAK;}
"None"              {return NONE;}
"elif"              {return ELIF;}
"continue"          {return CONTINUE;}
"pass"              {return PASS;}
"try"               {return TRY;}
"except"            {return EXCEPT;}
"import"            {return IMPORT;}
"as"                {return AS;}
"class"             {return CLASS;}
"finally"           {return FINALLY;}
"from"              {return FROM;}
"type"              {return TYPE;}
"len"               {return LEN;}
"min"               {return MIN;}
"max"               {return MAX;}
"sort"              {return SORT;}
"reverse"           {return REVERSE;}
"sum"               {return SUM;}
"slice"             {return SLICE;}

{num}               {return NUM;}
{id}                {return ID;}
{binary}            {return BINARY;}
{unary}             {return UNARY;}
{datatype}          {return DATATYPE;}
{string}            {return STRING;}
{float_num}         {return FLOAT_NUM;}
{comments}          {return COMMENT;}

[ \t]*              {/*ignore whitespace*/}
\n                  {return NEWLINE;}
.                   {fprintf(stderr, "Unexpected character: %s\n", yytext); return ERROR;}


[ \t]+ {
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
}

%%

int yywrap(){
  return 1;
}
