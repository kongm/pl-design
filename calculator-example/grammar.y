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
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_LT
%token T_GT
%token T_LEQ
%token T_GEQ
%token T_EQ
%token T_NEQ
%token T_AND
%token T_OR
%token T_READ
%token T_WRITE
%token T_ASSIGN
%token T_BEGIN
%token T_END
%token T_FOREACH
%token T_IN
%token T_REPEAT
%token T_UNTIL
%token T_WHILE
%token T_IF
%token T_THEN
%token T_ELSE
%token T_DECLARE
%token T_INTEGER
%token T_FLOAT
%token T_LITERAL_STR



%%

program : stmt_list ';' ;

stmt_list : stmt_list ';' stmt
    | stmt
    ;

oprel : T_LT
  | T_GT
  | T_LEQ
  | T_GEQ
  | T_EQ
  | T_NEQ
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
