%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"

    // Declare the functions
    extern int yylex();
    extern void yyerror(const char *s);

    // Node for the syntax tree
    typedef struct Node {
        char* value;
        struct Node* left;
        struct Node* right;
        struct Node* next;
    } Node;

    // Function to create a new node
    Node* create_node(char* value, Node* left, Node* right) {
        Node* new_node = (Node*)malloc(sizeof(Node));
        new_node->value = value;
        new_node->left = left;
        new_node->right = right;
        new_node->next = NULL;
        return new_node;
    }

    // Function to print the syntax tree (Pre-order traversal)
    void print_tree(Node* root) {
        if (root == NULL) return;
        printf("%s ", root->value);
        print_tree(root->left);
        print_tree(root->right);
        print_tree(root->next);
    }

%}

%union {
    char* str;
    int num;
    Node* node;
}

%token <str> ID NUM
%token FOR IF ELSE RETURN PRINT
%token DATATYPE
%token BINARY UNARY
%token SEPERATOR COLON

%type <node> program stmt expr block for_loop if_else_statement

%%

program:
    program stmt
    | stmt
    ;

stmt:
    expr SEPERATOR                { $$ = create_node("expr_stmt", $1, NULL); }
    | for_loop                    { $$ = create_node("for_stmt", $1, NULL); }
    | if_else_statement           { $$ = create_node("if_else_stmt", $1, NULL); }
    | RETURN expr                 { $$ = create_node("return_stmt", $2, NULL); }
    | PRINT expr                  { $$ = create_node("print_stmt", $2, NULL); }
    ;

expr:
    NUM                          { $$ = create_node("num", $1, NULL); }
    | ID                         { $$ = create_node("id", $1, NULL); }
    | expr BINARY expr           { $$ = create_node("binary_expr", $1, $3); }
    | UNARY expr                 { $$ = create_node("unary_expr", $2, NULL); }
    ;

for_loop:
    FOR ID COLON expr block     { $$ = create_node("for_loop", $3, $4); }
    ;

if_else_statement:
    IF expr block               { $$ = create_node("if_stmt", $2, $3); }
    | IF expr block ELSE block  { $$ = create_node("if_else_stmt", $2, $3); }
    ;

block:
    '{' program '}'             { $$ = $2; }
    ;

%%

int main() {
    printf("Enter your program:\n");
    yyparse();
    return 0;
}

int yywrap() {
    return 1;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
