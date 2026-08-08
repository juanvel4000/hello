#include <stdio.h>
#include <string.h>

int
main(int argc, char **argv)
{
    if (argc == 2) {
        printf("usage: hello [-n name]\n");
        return 1;
    }
    if (argc == 3) {
        if (strcmp(argv[1], "-n") == 0) {
            printf("Hello, %s!\n", argv[2]);
            return 0;
        }
        printf("usage: hello [-n name]\n");
        return 1;
    }
    printf("Hello, World!\n");
    return 0;
}
