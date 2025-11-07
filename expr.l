%{
#include "expr.tab.h"
#include <ctype.h>
%}

%%
[0-9]+        { return num; }
[A-Za-z]      { return let; }
[ \t\r]+      { /* ignore spaces & tabs */ }
\n            { return '\n'; }
.             { return yytext[0]; }
%%

int yywrap() { return 1; }
