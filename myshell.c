//Naveh Benveniste 305079253

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
void forkexample()
{
    fork();
    fork();
    fork();
    printf("Hello from Parent!\n");
}
int main()
{
    forkexample();
    return 0;
}