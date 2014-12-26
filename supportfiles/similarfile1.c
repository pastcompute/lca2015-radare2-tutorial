#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  int z = rand() % 3;
  int i;
  for (i=0; i < 100; i++) { printf("x"); }
  switch (z) {
#ifdef EXAMPLE1
  case 1: printf("Here I am 1\n"); break;
#endif
#ifdef EXAMPLE2
  case 0: printf("There am I 1\n"); z+=111; break;
#endif
  case 2:
    printf("2\n");
    break;
  }
  exit(0);
}

