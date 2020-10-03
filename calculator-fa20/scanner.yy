%{ 
#include "simple.h"
# undef yywrap
# define yywrap() 1



#undef YY_DECL
#define YY_DECL int yylex()
YY_DECL;


// Code run each time a pattern is matched.
#undef  YY_USER_ACTION  
# define YY_USER_ACTION  {}



%}

%option yylineno
%option noyywrap 

DIGIT [0-9] 
ALPHA [a-zA-Z]

%%





\/\/.*$           { yylloc.last_line++; yylloc.last_column = 0;}	
[ ]+						  { yylloc.last_column++;}	
[\t]+						  { yylloc.last_column+=2;}	
[\n]+						  { yylloc.last_line++; yylloc.last_column = 0;}	


{DIGIT}+[.]{DIGIT}+	{ 
                      yylloc.last_column += strlen(yytext);
                      return T_NUM;
									  }

{DIGIT}+					{ 
                    yylloc.last_column += strlen(yytext);
										return T_NUM;
									}

({ALPHA}|[_])({DIGIT}|{ALPHA}|[_])*     { 
                                          yylloc.last_column += strlen(yytext);
																					return T_ID;
																				}

.									{  yylloc.last_column++; return yytext[0];}





%%
