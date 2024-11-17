%{
    #include "y.tab.h"
    #include<string.h>
    #include<stdio.h>
%}

num      [0-9]+
float_num  [0-9]+\.[0-9]+
id         [a-zA-Z_][a-zA-Z0-9_]*
unary      \+|\-|\|\||\/\/|\%|\*|~|and|or|not|is|is\ not
binary     &|^|<|>
datatype   "int"|"float"|"char"|"tuple"|"list"|"set"|"dict"
comments   \#([^\n]*)|\'\'\'(.*?)(\'\'\')|\"\"\"(.*?)(\"\"\")
string      \"[^\"]*\"|'[^\']*\'

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
"("                 {printf("LPAREN: %s\n", yytext);return LPAREN;}
")"                 {printf("RPAREN: %s\n", yytext);return RPAREN;}
"=" 		            {printf("ASSIGNMENT: %s\n", yytext);return ASSIGNMENT;}
"break"             {printf("BREAK: %s\n", yytext);return BREAK;}
"None"              {printf("NONE: %s\n", yytext);return NONE;}
"elif"              {printf("ELIF: %s\n", yytext);return ELIF;}
"continue"          {printf("CONTINUE: %s\n", yytext);return CONTINUE;}
"pass"              {printf("PASS: %s\n", yytext);return PASS;}
"try"               {printf("TRY: %s\n", yytext);return TRY;}
"except"            {printf("EXCEPT: %s\n", yytext);return EXCEPT;}
"import"            {printf("IMPORT: %s\n", yytext);return IMPORT;}
"as"                {printf("AS: %s\n", yytext);return AS;}
"class"             {printf("CLASS: %s\n", yytext);return CLASS;}
"finally"           {printf("FINALLY: %s\n", yytext);return FINALLY;}
"from"              {printf("FROM: %s\n", yytext);return FROM;}
"type"              {printf("TYPE: %s\n", yytext);return TYPE;}
"len"               {printf("LEN: %s\n", yytext);return LEN;}
"min"               {printf("MIN: %s\n", yytext);return MIN;}
"max"               {printf("MAX: %s\n", yytext);return MAX;}
"sort"              {printf("SORT: %s\n", yytext);return SORT;}
"reverse"           {printf("REVERSE: %s\n", yytext);return REVERSE;}
"sum"               {printf("SUM: %s\n", yytext);return SUM;}
"slice"             {printf("SLICE: %s\n", yytext);return SLICE;}

{num}               {printf("NUM: %s\n", yytext);return NUM;}
{datatype}          {printf("DATATYPE: %s\n", yytext);return DATATYPE;}
{id}                {printf("ID: %s\n", yytext);yylval.id = strdup(yytext); return ID;}
{binary}            {printf("BINARY: %s\n", yytext);return BINARY;}
{unary}             {printf("UNARY: %s\n", yytext);return UNARY;}
{string}            {printf("STRING: %s\n", yytext);return STRING;}
{float_num}         {printf("FLOAT_NUM: %s\n", yytext);return FLOAT_NUM;}
{comments}          {printf("COMMENT: %s\n", yytext);return COMMENT;}

[ \t]+              {printf("IGNORE");/*ignore whitespace*/}
\n                  {printf("NEWLINE: %s\n", yytext);return NEWLINE;}
.                   {fprintf(stderr, "Unexpected character: %s\n", yytext); return ERROR;}

%%

int yywrap(){
  return 1;
}
