#include <iostream>
#include <stdio.h>
#include <string.h>
using namespace std;

int main()
{
	freopen("../my_test.hex","r",stdin);
	freopen("Instructions.txt","w",stdout);
    char s[100];
    int i = 0;
    fgets(s, 100, stdin);
    while(~scanf("%s", s)){
        if(s[0] == 'v')continue;
        printf("im_mem[%d] = 32'h%s;\n", i++,s);
    }
}