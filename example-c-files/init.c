

void f (int a)
{
  const int b = 3;
  const int c = a + 1;
  printf ("a = %d\n", a);
  printf ("b = %d\n", b);
  printf ("c = %d\n", c);
  printf ("----------------\n");
  if (a >= 0)
    f (a - 1);
}

void main ()
{
  f (2);
}
