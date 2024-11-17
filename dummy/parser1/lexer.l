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

"for"               {printf("FOR: %s\n", yytext);return FOR;}
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
"("                 {printf("LPAREN: %s\n", yytext);return LPAREN;}
")"                 {printf("RPAREN: %s\n", yytext);return RPAREN;}
"=" 		    {printf("ASSIGNMENT: %s\n", yytext);return ASSIGNMENT;}



{num}               {printf("NUM: %s\n", yytext);return NUM;}
{datatype}          {printf("DATATYPE: %s\n", yytext);return DATATYPE;}
{id}                {printf("ID: %s\n", yytext);yylval.id = strdup(yytext); return ID;}
{binary}            {printf("BINARY: %s\n", yytext);return BINARY;}
{unary}             {printf("UNARY: %s\n", yytext);return UNARY;}
{string}            {printf("STRING: %s\n", yytext);return STRING;}
{float_num}         {printf("FLOAT_NUM: %s\n", yytext);return FLOAT_NUM;}
{comments}          {printf("COMMENT: %s\n", yytext);return COMMENT;}

[ \t]+    { /* Ignore whitespace */ }
\n        {return NEWLINE;}

.                   {fprintf(stderr, "Unexpected character: %s\n", yytext); return ERROR;}

%%

int yywrap() {
    return 1;
}
