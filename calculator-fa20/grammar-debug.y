%language "c"
%skeleton "glr.c" 
%require "3.0.2"
%verbose
%defines 
%locations

%code
{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern void yyerror (char const *);
extern int yylex ();
extern char * yytext;
}

%token T_ID
%token T_NUM



%%

program : expr_list 
  ;


expr_list : expr_list ';' expr   { printf ("Result (1): %d\n", $3); }
  | expr { printf ("Result (2): %d\n", $1); }
  ;


expr: expr { printf ("We are are expr (1) = %d\n", $1); } '+' term  { $$ = $1 + $4; }
  | expr '-' term { $$ = $1 - $3; }
  | term   { $$ = $1;}
  ;


term : term { printf ("The term is %d\n", $1); $$ = $1 * 2; } '*' fact { $$ = $2 * $4; }
  | term '/' fact { $$ = $1 / $3; }
  | fact
  ;
 
fact  : T_NUM { $$ = atoi(yytext); }
  ;



%%

//void yyerror (YYLTYPE * loc, char const * msg)
void yyerror (char const * msg)
{
  #ifndef PL_GRADER
  printf ("Found error: %s (line %d, column %d)\n",
    yytext, yylloc.last_line, yylloc.last_column);
  #endif
}
