#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#include "simple.h"

char lexeme[1000];
#define makestr(s,c)  {s[0] = c; s[1] = 0;}

int mylex (FILE * ff)
{
  int car; 
  int ll = 0;


  do {
    car = fgetc (ff);
    if (car == '\n')
      return -1;
    if (car == '\r')
      return -1;
  }
  while isspace(car);

  if (car == '+')
  {
    makestr (lexeme,car);
    return T_ADD;
  }
  if (car == '*')
  {
    makestr (lexeme,car);
    return T_MUL;
  }
  if (car == '-')
  {
    makestr (lexeme,car);
    return T_SUB;
  }
  if (car == '/')
  {
    makestr (lexeme,car);
    return T_DIV;
  }

  if (car == EOF)
    return -1;

  if (isdigit(car)) {
    while (isdigit(car)) {
      lexeme[ll++] = car;
      car = fgetc(ff);  
    }
    lexeme[ll] = '\0';
    printf ("lexeme = [%s]\n", lexeme);
    ungetc(car, ff);
    return T_NUM;
  }

  if (isalpha(car)) {
    while (isalnum(car)) {
      lexeme[ll++] = car;
      car = fgetc(ff);  
    }
    lexeme[ll] = '\0';
    printf ("lexeme = [%s]\n", lexeme);
    ungetc(car, ff);
    return T_ID;
  }
  makestr (lexeme,car);
  return car;
}


