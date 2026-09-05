#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#ifndef VERSION
#define VERSION "0.1.2"
#endif

void print_usage(void) { puts("usage: hello [-V] [-n name] [-x code]"); }

int main(int argc, char **argv)
{
    int opt = 0;
    const char *name = "World";
    int status = 0;

    opterr = 0;
    while ((opt = getopt(argc, argv, "Vn:x:")) != -1) {
        switch (opt) {
        case 'V':
            printf("hello v%s\n", VERSION);
            return 0;
        case 'n':
            name = optarg;
            break;
        case 'x':
            status = atoi(optarg);
            break;
        case '?':
            printf("hello: unknown option: '%c'\n", optopt);
            print_usage();
            return 1;
        default:
            print_usage();
            return 1;
        }
    }

    printf("Hello, %s!\n", name);
    return status;
}
