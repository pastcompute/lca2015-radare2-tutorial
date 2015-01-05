#include <stdio.h>
#include <stdlib.h>

extern void heads_or_tails(int c)
{
  switch (c) {
  case 'H' : printf("Heads\n"); break;
  case 'T' : printf("Tails\n"); break;
  default:
    printf("I dont understand!\n");
  }
}

int main(int argc, char *argv[])
{
  int c=0xfeedbeef;
  int m;

  printf("Hello, world\n");

  if (argc < 2) return 0;

  c = argv[1][0];

  heads_or_tails(c);

  m = rand();

  m = m / 13;
  m = m + c * 42;

  printf("Your magic cookie is 0x%.8x\n", m);
  
  return 0;
}
