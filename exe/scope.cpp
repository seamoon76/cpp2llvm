#include <stdio.h>

int b = 1;

void show1() {
	printf("%s %d\n", "int function show1, the global variable b is", b);
	return;
}
void show2() {
	int c = 3;
	printf("%s %d\n", "int function show2, the local variable c is", c);
	return;
}

int main()
{

	show1();
	show2();
	printf("%s %d\n", "in main fuction, the global variable b is", b);
	int a = 2;
	printf("%s %d\n", "in main fuction, the local variable a is", a);

	return 0;
}
