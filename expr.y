%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token num let
%left '+' '-'
%left '*' '/'

%%
stmt:
      expr '\n'  { printf("\n..Valid Expression..\n"); exit(0); }
    | error '\n' { printf("\n..Invalid..\n"); exit(0); }
    ;

expr:
      num
    | let
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'
    ;
%%

int main(void) {
    printf("Enter an expression to validate: ");
    yyparse();
    return 0;
}
void yyerror(const char *s) { printf("Error: %s\n", s); }
