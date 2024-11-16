%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern int yylex();
    extern int countn;
    extern int sem_errors;
    extern void add(char);
    extern void check_declaration(char *c);
    extern void insert_type();
    extern struct node* mknode(struct node* left, struct node* right, char* token);
    extern void printtree(struct node* tree);
    
    struct node {
        struct node *left;
        struct node *right;
        char *token;
    };

    struct dataType {
        char *id_name;
        char *data_type;
        char *type;
        int line_no;
    } symbolTable[40];

    int count = 0;
    char type[10];
    struct node* head;
    int q;
%}

%union {
    struct var_name {
        char name[100];
        struct node *nd;
    } nam;
}

%token VOID PRINTFF SCANFF INT FLOAT CHAR FOR IF ELSE TRUE FALSE NUMBER ID LE GE EQ NE GT LT AND OR STR ADD MULTIPLY DIVIDE SUBTRACT UNARY INCLUDE RETURN
%type <nam> headers main body return datatype expression statement init value arithmetic relop program else condition

%%

program: headers main '(' ')' '{' body return '}' {
    $2.nd = mknode($6.nd, $7.nd, "main");
    $$.nd = mknode($1.nd, $2.nd, "program");
    head = $$.nd;
} ;

headers: headers headers { $$.nd = mknode($1.nd, $2.nd, "headers"); }
       | INCLUDE { add('H'); } { $$.nd = mknode(NULL, NULL, $1.name); }
       ;

main: datatype ID { add('K'); }
    ;

datatype: INT { insert_type(); }
        | FLOAT { insert_type(); }
        | CHAR { insert_type(); }
        | VOID { insert_type(); }
        ;

body: FOR '(' statement ';' statement ';' statement ')' '{' body '}' {
    struct node *temp = mknode($6.nd, $8.nd, "CONDITION");
    struct node *temp2 = mknode($4.nd, temp, "CONDITION");
    $$.nd = mknode(temp2, $11.nd, $1.name);
}
    | IF '(' condition ')' '{' body '}' else {
        struct node *iff = mknode($4.nd, $7.nd, $1.name);
        $$.nd = mknode(iff, $9.nd, "if-else");
    }
    | statement ';' { $$.nd = $1.nd; }
    | body body { $$.nd = mknode($1.nd, $2.nd, "statements"); }
    | PRINTFF '(' STR ')' ';' { $$.nd = mknode(NULL, NULL, "printf"); }
    | SCANFF '(' STR ',' '&' ID ')' ';' { $$.nd = mknode(NULL, NULL, "scanf"); }
    ;

else: ELSE '{' body '}' { $$.nd = mknode(NULL, $4.nd, $1.name); }
    | { $$.nd = NULL; }
    ;

condition: value relop value { $$.nd = mknode($1.nd, $3.nd, $2.name); }
         | TRUE { add('K'); $$.nd = NULL; }
         | FALSE { add('K'); $$.nd = NULL; }
         | { $$.nd = NULL; }
         ;

statement: datatype ID { add('V'); } init {
    $2.nd = mknode(NULL, NULL, $2.name);
    $$.nd = mknode($2.nd, $4.nd, "declaration");
}
    | ID '=' expression { check_declaration($1.name); $1.nd = mknode(NULL, NULL, $1.name); $$.nd = mknode($1.nd, $4.nd, "="); }
    | ID relop expression { check_declaration($1.name); $1.nd = mknode(NULL, NULL, $1.name); $$.nd = mknode($1.nd, $4.nd, $3.name); }
    | ID UNARY { check_declaration($1.name); $1.nd = mknode(NULL, NULL, $1.name); $3.nd = mknode(NULL, NULL, $3.name); $$.nd = mknode($1.nd, $3.nd, "ITERATOR"); }
    | UNARY ID { check_declaration($2.name); $1.nd = mknode(NULL, NULL, $1.name); $2.nd = mknode(NULL, NULL, $2.name); $$.nd = mknode($1.nd, $2.nd, "ITERATOR"); }
    ;

init: '=' value { $$.nd = $2.nd; }
    | { $$.nd = mknode(NULL, NULL, "NULL"); }
    ;

expression: expression arithmetic expression { $$.nd = mknode($1.nd, $3.nd, $2.name); }
          | value { $$.nd = $1.nd; }
          ;

arithmetic: ADD { return ADD; }
          | SUBTRACT { return SUBTRACT; }
          | MULTIPLY { return MULTIPLY; }
          | DIVIDE { return DIVIDE; }
          ;

relop: LT { return LT; }
     | GT { return GT; }
     | LE { return LE; }
     | GE { return GE; }
     | EQ { return EQ; }
     | NE { return NE; }
     ;

value: NUMBER { add('C'); $$.nd = mknode(NULL, NULL, $1.name); }
     | ID { check_declaration($1.name); $$.nd = mknode(NULL, NULL, $1.name); }
     ;

return: RETURN value ';' { $1.nd = mknode(NULL, NULL, "return"); $$.nd = mknode($1.nd, $3.nd, "RETURN"); }
      | { $$.nd = NULL; }
      ;

%%

int yyerror(const char* msg) {
    fprintf(stderr, "Error: %s\n", msg);
    return 0;
}

int main() {
    yyparse();
    printf("\n\n");
    printf("\t\t\t\t\t\t\t\t PHASE 1: LEXICAL ANALYSIS \n\n");
    printf("\nSYMBOL   DATATYPE   TYPE   LINE NUMBER \n");
    printf("_______________________________________\n\n");

    // Print symbol table
    for (int i = 0; i < count; i++) {
        printf("%s\t%s\t%s\t%d\t\n", symbolTable[i].id_name, symbolTable[i].data_type, symbolTable[i].type, symbolTable[i].line_no);
    }

    for (int i = 0; i < count; i++) {
        free(symbolTable[i].id_name);
        free(symbolTable[i].type);
    }

    printf("\n\n");
    printf("\t\t\t\t\t\t\t\t PHASE 2: SYNTAX ANALYSIS \n\n");

    // Print the parse tree
    printtree(head);

    printf("\n\n\n\n");
    printf("\t\t\t\t\t\t\t\t PHASE 3: SEMANTIC ANALYSIS \n\n");
    if (sem_errors > 0) {
        printf("Semantic analysis completed with %d errors!\n", sem_errors);
    } else {
        printf("Semantic analysis completed with no errors\n");
    }
    return 0;
}

