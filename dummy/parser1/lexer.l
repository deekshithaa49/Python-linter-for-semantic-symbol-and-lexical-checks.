%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <string.h>
%}

num        [0-9]+
float_num  [0-9]+\.[0-9]+
datatype   int|float|char|tuple|list|set|dict 
id         [a-zA-Z][a-zA-Z0-9_]*  
unary      \+|\-|\|\||\/\/|\%|\*|~|and|or|not|is|is\ not
binary     &|^|<|>|==|!=
comments   \#([^\n])|\'\'\'(.?)(\'\'\')|\"\"\"(.*?)(\"\"\")
string     \"[^\"]\"|'[^\']\'

%%

"for"               {return FOR;}
"in"                {return IN;}
"True"              {return TRUE;}
"False"             {return FALSE;}
"return"            {return RETURN;} 
"range"             {return RANGE;}
"print"             {return PRINT;}
":"                 {return COLON;}

{num}               {printf("NUM: %s\n", yytext); return NUM;}
{datatype}          { printf("DATATYPE: %s\n", yytext); return DATATYPE; }
{id}                { printf("ID: %s\n", yytext); return ID; }
{binary}            {printf("BINARY: %s\n", yytext);return BINARY;}
{unary}             {printf("UNARY: %s\n", yytext);return UNARY;}
{string}            {printf("STRING: %s\n", yytext);return STRING;}
{float_num}         {printf("FLOAT_NUMBER: %s\n", yytext);return FLOAT_NUM;}
{comments}          {printf("COMMENT: %s\n", yytext);return COMMENT;}

[ \t]*              {/*ignore whitespace*/}
\n                  {return NEWLINE;}

.                   {fprintf(stderr, "Unexpected character: %s\n", yytext); return ERROR;}

%%

int yywrap(){
   return 1;
}
