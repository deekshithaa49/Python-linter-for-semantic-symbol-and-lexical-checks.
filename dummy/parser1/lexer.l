%{
    #include "y.tab.h"
%}

num	    [0-9]+
id	    [a-zA-Z]+
unary	+|-|*|//|%|**|~|and|or|not|is|is\ not
binary   &|||^|<|>|==|!=|<=|>=|=|+=|-=|*=|/=|%=|**=|/\/=|&=|\|=|^=|<<|>>
separator   "||"|,|:|'||'|
string   "\.*?\"|'[^'*']
%%

"for"	    { return FOR; }
"in"        { return IN; }
"range"     { return RANGE;}
"print"     { return PRINT;}
","         { return SEPARATOR;}
":"         { return COLON;}
{binary}	{ return BINARY;}
{unary}	    { return UNARY;}
{num}	    { return NUMBER;}
{id}	    { return ID;}
{string}    { return STRING;}
[ \t]+	    { /*ignore whitespace */ } 
"\n"        { return NEWLINE;}
.	        { return *yytext; }

%%

int yywrap() {
    return 1;
}
