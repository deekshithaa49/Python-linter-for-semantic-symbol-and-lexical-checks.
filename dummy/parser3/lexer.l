%{
#include "y.tab.h"
%}

%%
"def"          return DEF;
"if"           return IF;
"else"         return ELSE;
"for"          return FOR;
"return"       return RETURN;
"in"           return IN;
"print"        return PRINT;

[a-zA-Z_][a-zA-Z0-9_]*   return IDENTIFIER;
[0-9]+         return NUMERIC;
"'[^']*'"|\"[^\"]*\"   return STRING;

"="            return '=';
">"            return '>';
"+"            return '+';
","            return ',';
":"            return ':';
"("            return '(';
")"            return ')';

[ \t\n]+       ; /* Ignore whitespace */
.              ; /* Ignore unrecognized characters */
%%
