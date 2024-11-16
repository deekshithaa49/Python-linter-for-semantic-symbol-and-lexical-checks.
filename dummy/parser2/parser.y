%{
  #include<stdio.h>
  
  int yylex();
  int yywrap();
  void yyerror(const char* s); 
%}

%token FOR IF ELSE ID DIGIT UNARY BINARY DATATYPE TRUE FALSE RETURN RANGE INPUT PRINT SEPERATOR COLON DEF BREAK NONE ELIF CONTINUE PASS TRY EXCEPT IMPORT AS CLASS FINNALLY FROM TYPE LEN MIN MAX SORT REVERSE SUM SLICE 

%%

program: headers main '(' ')' '{' body return '}'
;

body: expressions 
|loops 
|conditionals
|body expression
|body loops
|body conditionals
;

looops: FOR ID IN block COLON body
;

expressions: expressions statement ';'

%%

def main:
  yyparse();

def yyerror(const char* msg):
  fprint(msg)
