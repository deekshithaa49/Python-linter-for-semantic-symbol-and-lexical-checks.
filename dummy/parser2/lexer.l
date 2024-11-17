%{
    #include "y.tab.h"
    #include <string.h>
    #include <stdio.h>
%}

num         [0-9]+
float_num   [0-9]+\.[0-9]+
datatype    int|float|char|tuple|list|set|dict
id          [a-zA-Z_][a-zA-Z0-9_]*
unary       \+|\-|\|\||\/\/|\%|\*|~|and|or|not|is|is\ not
binary      &|^|<|>
comments    \#([^\n]*)|\'\'\'([^\']*|\'\'\'[^\']*\')*\'\'\'|\"\"\"([^\"]*|\"\"\"[^\"]*\")*\"\"\" 
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

{num}               {return NUM;}
{datatype}          {return DATATYPE;}
{id}                {return ID;}
{binary}            {return BINARY;}
{unary}             {return UNARY;}
{string}            {return STRING;}
{float_num}         {return FLOAT_NUM;}
{comments}          {return COMMENT;}

[ \t]*              {/ignore whitespace/}
\n                  {return NEWLINE;}

.                   {fprintf(stderr, "Unexpected character: %s\n", yytext); return ERROR;}


%%

int yywrap(){
  return 1;
}
