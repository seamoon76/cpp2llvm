//#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <string.h>

int main()
{
	int n = 0;
	char a[999];
	printf("type in a string\n");
	gets(a);
	n=strlen(a);
	int i=0;
	while(i<n)
	{
	    if (a[i] != a[(n - i) - 1]) {
			printf("this string is not a palindrome.\n");
			return 0;
		}
		i=i+1;
	}
	printf("this string is a palindrome.\n");

	return 0;
}