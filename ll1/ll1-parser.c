#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "simple.h"

int next;
extern char lexeme[1000];
FILE * infile;
extern int mylex (FILE * ff);

#ifdef DEBUG
#define myprint(x) printf("%s", x);
#else
#define myprint(x)
#endif

int fact ();
int term ();
int expr ();


int expr ()
{
  int ret = term ();
  if (ret)
    return ret;

  if (next == T_ADD || next == T_SUB)
  {
    next = mylex (infile); 
    ret = expr ();
    return ret;
  }

  return ret;
}

int term ()
{
  int ret = fact ();
  if (ret)
    return ret;

  if (next == T_MUL || next == T_DIV)
  {
    next = mylex (infile); 
    ret = term ();
    return ret;
  }

  return ret;
}

int fact ()
{
  myprint ("About to test ID\n");
  if (next == T_ID)
  {
    myprint ("Found ID\n");
    next = mylex (infile);
    return 0;
  }
  myprint ("About to test NUM\n");
  if (next == T_NUM)
  {
    myprint ("Found NUM\n");
    next = mylex (infile);
    return 0;
  }
  myprint ("About to test ID: ( expr )\n");
  if (next == '(')
  {
    next = mylex (infile);
    int ret = expr ();
    if (ret)
      return ret;
    if (next == ')')
    {
      next = mylex (infile);     
      return 0;
    }
    return 1;
  }
  myprint ("About to test: - fact\n");
  if (next == T_SUB)
  {
    next = mylex (infile);
    return fact ();
  }
  myprint ("About to test ID\n");
  return 1;
}


int main ()
{
  infile = stdin;
  next = mylex (infile);
  int ret = expr ();
  if (ret) 
  {
    printf ("FAIL 1\n");
  }
  else
  {
    printf ("Next token = %d (%s)\n", next, lexeme);
    if (next == -1 || next == '\n' || next == '\r') // || next == ';')
      printf ("PASS\n");
    else
    {
      printf ("next = %d\n", next);
      printf ("FAIL 2\n");
    } 
  }
  return 0;
}
