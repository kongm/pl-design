#include <stdio.h>

#define N 1024
int main ()
{
  int i,j,k;
  float A[N][N];
  float B[N][N];
  float C[N][N];
  for (i = 0; i < N; i++)
    for (j = 0; j < N; j++)
      for (k = 0; k < N; k++)
        C[i][j] += A[i][k] * B[k][j];

  int show = 0;
  scanf ("%d", &show);

  if (show)
  {
    for (i = 0; i < N; i++)
      for (j = 0; j < N; j++)
        printf ("%f", C[i][j]);
  }

  return 0;
}
