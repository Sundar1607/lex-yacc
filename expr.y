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
      expr '\n'
        { printf("\n..Valid Expression..\n"); exit(0); }
    | error '\n'
        { printf("\n..Invalid..\n"); exit(0); }
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

int main()
{
    printf("Enter an expression to validate: ");
    yyparse();
    return 0;
}

int yylex()
{
    int ch;

    /* Skip spaces */
    while ((ch = getchar()) == ' ')
        ;

    /* Digit → token num */
    if (isdigit(ch))
        return num;

    /* Letter → token let */
    if (isalpha(ch))
        return let;

    /* Return operator '(' ')' '+' '-' '*' '/' and '\n' */
    return ch;
}

void yyerror(const char *s)
{
    printf("%s\n", s);
}
