#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

#define MAX 128
char lexeme[MAX];

#define T_ID 256
#define T_NUM_FLOAT 257
#define T_NUM_INT 258

int next_token ()
{
  int ii = 0;

  // get first character
  char cc = getchar ();;

  // skip all white space characters
  while (isspace(cc)) cc = getchar ();

  // Detect ID patterns. Must start with a letter, and
  // follow up with a combination of letters, digits and '_'.
  if (isalpha(cc))
  {
    ii = 0;
    while (isalnum(cc) || cc == '_') 
    {
      lexeme[ii++] = cc; 
      cc = getchar ();
    }
    lexeme[ii] = '\0';
    ungetc(cc,stdin);
    return T_ID;
  }

  // Similar, detect numbers.
  if (isdigit(cc))
  {
    ii = 0;
    while (isdigit(cc))
    {
      lexeme[ii++] = cc; 
      cc = getchar ();
    }
    /// 3.14
    #ifdef DETECT_FLOAT
    if (cc == '.')
    {
      lexeme[ii++] = cc;
      cc = getchar ();
      while (isdigit(cc))
      {
        lexeme[ii++] = cc; 
        cc = getchar ();
      }
      lexeme[ii] = '\0';
      ungetc(cc,stdin);
      return T_NUM_FLOAT;
    }
    #endif
    lexeme[ii] = '\0';
    ungetc(cc,stdin);
    return T_NUM_INT;
  }

  // Default case. Return ASCII code of current character.
  // Store character in string.
  lexeme[0] = cc;
  lexeme[1] = '\0';
  return cc;
}

int main () {
  int tok;
  int count = 0;
  while (1) {
    tok = next_token ();
    if (tok == EOF || tok == '$')
      break;
    printf ("Token %d ==> [%s,%d]\n", count++, lexeme, tok);
  }
  return 0;
}
