//#define _CRT_SECURE_NO_WARNINGS
#include <iostream>

void myRank() {

	printf("%s ","Enter a line of integers, separated by spaces\n");
	char ch;
	int list[100];
	int count = 0;

	scanf("%d", &list[count]);
	count=count+1;
	scanf("%c",&ch);
	while (ch != '\n')
	{
	    scanf("%d", &list[count]);
		count=count+1;
		scanf("%c",&ch);
	}

	int i, j, temp;
	i=1;
	while(i<count)
	{
	    j=0;
	    while(j<count-i)
	    {
	        if (list[j] > list[j + 1])
			{
				temp = list[j];
				list[j] = list[j + 1];
				list[j + 1] = temp;
			}
	        j=j+1;
	    }
	    i=i+1;
	}

    i=0;
    while(i<count)
    {
        printf("%d ", list[i]);
        i=i+1;
    }
    return;
}

int main()
{
	myRank();

	return 0;
}