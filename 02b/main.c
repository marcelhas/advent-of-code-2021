#include "stdio.h"
#include "string.h"
#include "stdlib.h"
#include <limits.h>

#define FORWARD "forward"
#define UP "up"
#define DOWN "down"
#define DELIMITER " "

struct Submarine{
  long aim;
  long pos;
  long depth;
} Submarine;

int main(int const argc, char const **argv) {
  FILE* filePointer = argc >= 1 ? fopen(argv[1], "r") : stdin;
  if (filePointer == NULL) {
    printf("Error reading file!\n");
    return 1;
  }

  int const bufferLength = 255;
  char buffer[bufferLength];
  struct Submarine submarine = {.aim = 0, .pos = 0, .depth = 0};

  while (fgets(buffer, bufferLength, filePointer)) {
    char *command = strtok(buffer, DELIMITER);
    char *parameter = strtok(NULL, DELIMITER);
    long const amount = strtol(parameter, NULL, 10);

    if (strcmp(command, FORWARD) == 0) {
      submarine.pos += amount;
      submarine.depth += submarine.aim * amount;
    } else if (strcmp(command, UP) == 0) {
      submarine.aim -= amount;
    } else if (strcmp(command, DOWN) == 0) {
      submarine.aim += amount;
    }
  }
  fclose(filePointer);

  printf("%i\n", submarine.pos * submarine.depth);
}
