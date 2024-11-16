%{
    #include "y.tab.h"
%}

digit      [0-9]+
id         [a-zA-Z]+
unary      +|-||//|%|*|~|and|or|not|is|is\ not
binary     &|||^|<|>|==|!=|<=|>=|=|+=|-=|=|/=|%=|*=|/\/=|&=|\|=|^=|<<|>>
datatype   "int"|"float"|"char"|"tuple"|"list"|"set"|"dict"

%%

#.*                 {/* Ignore comments */ }
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
{digit}             {return DIGIT;}
{id}                {return ID;}
{binary}            {return BINARY;}
{unary}             {return UNARY;}
{datatype}          {return DATATYPE;}
[ \t]*              {/*ignore whitespace*/}
[ \t]+              {/* Handle indentation*/}
[\n]                {return NEWLINE;}
.                   {return *yytext;}

%%

int yywrap(){
  return 1;
}
