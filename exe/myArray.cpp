//#define _CRT_SECURE_NO_WARNINGS
#include <iostream>

int main()
{
	int a[2][2];
	int b[2][2];
	int c[2][2];
	printf("%s", " To create a matrix, please enter four numbers, separated by space.\n");
	scanf("%d %d %d %d", &a[0][0], &a[0][1], &a[1][0], &a[1][1]);
	printf("%s", "First matirx is:\n");
	printf("|%d %d|\n", a[0][0], a[0][1]);
	printf("|%d %d|\n", a[1][0], a[1][1]);

	printf("%s", " To create another matrix, please enter four numbers, separated by space.\n");
	scanf("%d %d %d %d", &b[0][0], &b[0][1], &b[1][0], &b[1][1]);
	printf("%s", "Second matirx is:\n");
	printf("|%d %d|\n", b[0][0], b[0][1]);
	printf("|%d %d|\n", b[1][0], b[1][1]);

	c[0][0] = ( a[0][0] * b[0][0] ) + ( a[0][1] * b[1][0] );
	c[0][1] = ( a[0][0] * b[0][1] ) + ( a[0][1] * b[1][1] );
	c[1][0] = ( a[1][0] * b[0][0] ) + ( a[1][1] * b[1][0] );
	c[1][1] = ( a[1][0] * b[0][1] ) + ( a[1][1] * b[1][1] );

	printf("%s", "The product of two matrices is : \n");
	printf("|%d %d|\n", c[0][0], c[0][1]);
	printf("|%d %d|\n", c[1][0], c[1][1]);

	return 0;
}