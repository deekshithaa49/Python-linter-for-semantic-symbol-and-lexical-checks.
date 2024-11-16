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

%

%%

%%

int main(){
  yyparser();
  print_symbol_table();
  return 0;
}

int yywrap(){
  return 1;
}
