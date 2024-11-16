%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  #define MAX_SYM_TABLE 100

  typedef struct{
      char name[50];
      int value;
  }symbol;

  symbol symbol_table[MAX_SYM_TABLE];
  int symbol_count=0;

  int add_symbol(char *name, int value){
    for(int i=0;i<symbol_count;i++){
      if(strcmp(symbol_table[i].name, name) == 0){
        symbol_table[i].value=value;
        return 0;
      }
    }

    if(symbol_count < MAX_SYM_TABLE){
      strcpy(symbol_table[symbol_count].name, name);
      synbol_table[symbol_count].value=value;
      symbol_count++;
      return 0;
    }
    return -1;
  }

  int get_symbol_value(char *name) {
        for (int i = 0; i < symbol_count; i++) {
            if (strcmp(symbol_table[i].name, name) == 0) {
                return symbol_table[i].value;
            }
        }
        return -1;  
    }

    void print_symbol_table() {
        printf("Symbol Table:\n");
        for (int i = 0; i < symbol_count; i++) {
            printf("Name: %s, Value: %d\n", symbol_table[i].name, symbol_table[i].value);
        }
    }

%}

%token NUM ID IF ELSE FOR RANGE INPUT PRINT SEPERATOR COLON DEF BREAK NONE ELIF CONTINUE PASS TRY EXCEPT IMPORT AS CLASS FINALLY FROM TYPE LEN MIN MAX SORT REVERSE SUM SLICE
%token UNARY BINARY DATATYPE STRING FLOAT_NUM COMMENT
%token NEWLINE INDENT DEDENT
%left '+' '-'
%left '*' '/'

%%
  program:
    statements
    ;

statements:
  statement
  |statements statement
  ;

statement:
  assignment
  |conditional
  |loop
  |print_statement
  |return_statement
  ;

assignment:
  ID '=' expression{
    int value=$3;
    if(add_symbol($1, value) == -1){
      fprintf(stderr, "Error: Symbol table overflow.\n");
      exit(1);
    }
  }
  ;

conditional:
  IF expression COLON statements ESLE COLON statements{
    if($2){
      $$=$5;
    }
    else{
      $$=$7;
    }
  }
  ;

loop:
  FOR ID IN RANGE expression COLON statements{
    int range_val=$5;
    for(int i=0;i<val_range;i++){
      add_symbol($2,i);
      $$=$7;
    }
  }
  ;

print_statement:
  PRINT expresion{
    printf("%d\n", $2);
  }
  ;

  return_statement:
    RETURN NUM {
        $$ = $2;
    }
    ;

expression:
    NUM {
        $$ = $1;
    }
    | ID {
        $$ = get_symbol_value($1);
    }
    | expression '+' expression {
        $$ = $1 + $3;
    }
    | expression '-' expression {
        $$ = $1 - $3;
    }
    | expression '*' expression {
        $$ = $1 * $3;
    }
    | expression '/' expression {
        $$ = $1 / $3;
    }
    ;
  
%%

int main(){
  yyparser();
  print_symbol_table();
  return 0;
}

int yywrap(){
  return 1;
}
