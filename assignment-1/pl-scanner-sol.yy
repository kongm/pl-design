
%{ 

#include "tokens.h"
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





\/\/.*$   
[ \t]+						
[\n]+							



":="							{ 
										return T_ASSIGN; 
                  }

"+"							  { 
										return T_PLUS; 
                  }
  
";"							  { 
										return ';'; 
                  }

"foreach"				  { 
										return T_FOREACH; 
                  }

"while"				    { 
										return T_WHILE; 
                  }

"begin"					  { 
										return T_BEGIN; 
                  }

"end"				      { 
										return T_END ; 
                  }

"print"						{ 
										return T_PRINT; 
                  }

"int"							{ 
										return T_INTEGER; 
                  }

"float"						{ 
										return T_FLOAT; 
                  }

"repeat"				  { 
										return T_REPEAT; 
                  }

"declare"					{ 
										return T_DECLARE; 
                  }


{DIGIT}+[.]{DIGIT}+	{ 
                      return T_FLOAT;
									  }

{DIGIT}+					{ 
										return T_INTEGER;
									}

({ALPHA}|[_])({DIGIT}|{ALPHA}|[_])*     { 
																					return T_ID;
																				}

<<EOF>>						{ return T_EOF ; }
.									{ printf ("Unexpected character\n"); exit (1); }





%%
