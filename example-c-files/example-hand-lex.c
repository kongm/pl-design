#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

char lexeme[1000];

int mylex (FILE * ff)
{
  char car; 
  int ll = 0;

  do {
    car = fgetc (ff);
  }
  while isspace(car);

  if (isdigit(car)) {
    while (isdigit(car)) {
      lexeme[ll++] = car;
      car = fgetc(ff);  
    }
    lexeme[ll] = '\0';
    ungetc(car, ff);
    return 500;
  }

  if (isalpha(car)) {
    while (isalnum(car)) {
      lexeme[ll++] = car;
      car = fgetc(ff);  
    }
    lexeme[ll] = '\0';
    ungetc(car, ff);
    return 300;
  }
  return car;
}


int main ()
{
  int tok;
  while ((tok = mylex (stdin)) != -1) {
    printf ("Next token is : %d (%s)\n", tok, lexeme);
  }
  return 0;
}
