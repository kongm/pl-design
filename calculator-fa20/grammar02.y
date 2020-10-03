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


expr_list : expr_list ';' expr   
  ;

expr_list : expr 
  ;


expr: expr '+' term 
  | expr '-' { printf ("expr2a\n"); }term  { printf ("expr2b\n"); }
  | term   
  ;


term : term '*' fact
  | term '/' fact 
  | '-' fact
  | fact
  ;
 
fact  : T_NUM 
  | T_ID arr 
  | '(' expr ')'
  | T_ID '(' arg_list ')'
  ;

arr : '[' expr ']'
  |
  ;

arg_list : arg_list ',' expr   
  | expr
  |
  ;



%%

//void yyerror (YYLTYPE * loc, char const * msg)
void yyerror (char const * msg)
{
  #ifndef PL_GRADER
  printf ("Found error: %s (line %d, column %d)\n",
    yytext, yylloc.last_line - 1, yylloc.last_column);
  #endif
}
