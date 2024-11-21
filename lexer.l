%{
    #include "parser.tab.h"
    #include <stdio.h>
    #include <string.h>
%}

num        [0-9]+
float_num  [0-9]+\.[0-9]+
datatype   int|float|char|tuple|list|set|dict 
id         [a-zA-Z][a-zA-Z0-9_]*  
unary      \+|\-|\|\||\/\/|\%|\*|~|and|or|not|is|is\ not|=
binary     &|^|<|>|==|!=
comments   \#([^\n])|\'\'\'(.?)(\'\'\')|\"\"\"(.*?)(\"\"\")
string     (\"[^\"]*\")|(\'[^\']*\')
para       \(|\)
quotes     "\""|"\'"  


%%

"for"               {printf("FOR: %s\n", yytext);return FOR;}
"if"                {printf("IF: %s\n", yytext);return IF;}
"else"              {printf("ESLE: %s\n", yytext);return ELSE;}
"in"                {printf("IN: %s\n", yytext);return IN;}
"True"              {printf("TRUE: %s\n", yytext);return TRUE;}
"False"             {printf("FALSE: %s\n", yytext);return FALSE;}
"return"            {printf("RETURN: %s\n", yytext);return RETURN;} 
"range"             {printf("RANGE: %s\n", yytext);return RANGE;}
"input"             {printf("INPUT: %s\n", yytext);return INPUT;}
"print"             {printf("PRINT: %s\n", yytext);return PRINT;}
","                 {printf("SEPEERATOR: %s\n", yytext);return SEPERATOR;}
":"                 {printf("COLON: %s\n", yytext);return COLON;}
"def"               {printf("DEF: %s\n", yytext);return DEF;}
"=" 		    {printf("ASSIGNMENT: %s\n", yytext);return ASSIGNMENT;}
"break"             {printf("BREAK: %s\n", yytext);return BREAK;}
"None"              {printf("NONE: %s\n", yytext);return NONE;}
"elif"              {printf("ELIF: %s\n", yytext);return ELIF;}
"continue"          {printf("CONTINUE: %s\n", yytext);return CONTINUE;}
"pass"              {printf("PASS: %s\n", yytext);return PASS;}
{num}               {printf("NUM: %s\n", yytext); return NUM;}
{datatype}          {printf("DATATYPE: %s\n", yytext); return DATATYPE; }
{id}                {printf("ID: %s\n", yytext); return ID;}
{binary}            {printf("BINARY: %s\n", yytext);return BINARY;}
{unary}             {printf("UNARY: %s\n", yytext);return UNARY;}
{string}            {printf("STRING: %s\n", yytext);return STRING;}
{float_num}         {printf("FLOAT_NUMBER: %s\n", yytext);return FLOAT_NUM;}
{comments}          {printf("COMMENT: %s\n", yytext);return COMMENTS;}
{para}              {printf("PARENTHESIS: %s\n", yytext);return PARA;}
{quotes}	    {printf("QUOTES: %s\n", yytext);return QUOTES;}
[ \t]*              {/*ignore whitespace*/}
\n                  {return NEWLINE;}
.                   {fprintf(stderr, "Unexpected character: %s\n", yytext); return ERROR;}

%%

int yywrap(){
return 1;
}
