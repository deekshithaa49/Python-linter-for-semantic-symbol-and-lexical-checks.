%{
    #include "y.tab.h"
%}

digit  [0-9]+
id     [a-zA-Z]+
binary  =|>|<|!=|<=|>=|==|[+-/*]|**|//
unary  
datatype "int"|"float"|"char"
seperators ,|"||"|'||'|:

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
"and"               {return AND;}
{digit}             {return DIGIT;}
{id}                {return ID;}
{binary}            {return BINARY;}
{unary}             {return UNARY;}
{datatype}          {return DATATYPE;}
{seperators}        {return SEPERATORS;}

%%

int yywrap(){
  return 1;
}
