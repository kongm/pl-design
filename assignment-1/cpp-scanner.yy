%{ 

# undef yywrap
# define yywrap() 1


using namespace std;
using namespace yy;

#undef YY_DECL
#define YY_DECL int yylex()
YY_DECL;

yy::location loc;

// Code run each time a pattern is matched.
# define YY_USER_ACTION  loc.columns (yyleng);



%}

%option yylineno
%option noyywrap 

DIGIT [0-9] 
ALPHA [a-zA-Z]

%%

%{
  // Code run each time yylex is called.
  loc.step ();
%}




\/\/.*$   
[ \t]+						{ loc.step (); }
[\n]+							{ loc.lines (yyleng); loc.step (); }



":="							{ 
										return yy::aqcsl_parser::make_T_ASSIGN(loc); 
                  }

"+="							{ 
										return yy::aqcsl_parser::make_T_SEMICOLON(loc); 
                  }

"+"							  { 
										return yy::aqcsl_parser::make_T_SEMICOLON(loc); 
                  }
  
";"							  { 
										return yy::aqcsl_parser::make_T_SEMICOLON(loc); 
                  }

"foreach"				  { 
										return yy::aqcsl_parser::make_T_FOREACH(loc); 
                  }

"while"				    { 
										return yy::aqcsl_parser::make_T_WHILE(loc); 
                  }

"begin"					  { 
										return yy::aqcsl_parser::make_T_BEGIN(loc); 
                  }

"end"				      { 
										return yy::aqcsl_parser::make_T_END (loc); 
                  }

"print"						{ 
										return yy::aqcsl_parser::make_T_PRINT(loc); 
                  }

"int"							{ 
										return yy::aqcsl_parser::make_T_DT_INT(loc); 
                  }

"float"						{ 
										return yy::aqcsl_parser::make_T_DT_FLOAT(loc); 
                  }

"repeat"				  { 
										return yy::aqcsl_parser::make_T_DT_REPEAT(loc); 
                  }

"declare"					{ 
										return yy::aqcsl_parser::make_T_DT_DECLARE(loc); 
                  }


{DIGIT}+[.]{DIGIT}+	{ 
                      return yy::aqcsl_parser::make_T_FLOAT (string(yytext),loc);
									  }

{DIGIT}+					{ 
										//yylval->build (yytext);
										return yy::aqcsl_parser::make_T_INTEGER (string(yytext),loc);
									}

({ALPHA}|[_])({DIGIT}|{ALPHA}|[_])*     { 
																					//yylval->build (yytext);
																					return yy::aqcsl_parser::make_T_ID (string(yytext),loc);
																				}

<<EOF>>						{ return yy::aqcsl_parser::make_T_EOF (loc); }
.									{ printf ("Unexpected character\n"); exit (1); }





%%
