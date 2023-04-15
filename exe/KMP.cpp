#include <stdio.h>
#include <string.h>



char text[2048];
char pattern[2048];
int next[2048];

void getNext()
{
    next[0] = -1;
    int i = 0;
    int j = -1;
    while (i < strlen(pattern) - 1)
    {
        if ((j == -1) || (pattern[i] == pattern[j]))
        {
            i=i+1;
            j=j+1;
            if (pattern[i] == pattern[j])
            {
                next[i] = next[j];
            }
            else
            {
                next[i] = j;
            }
        }
        else
        {
            j = next[j];
        }
    }
    return;
}

int KMP(int start)
{
    int pattern_len = strlen(pattern);
    int text_len = strlen(text);

    int i = start;
    int j = 0;
    while ((i < text_len) && (j < pattern_len))
    {
        if ((j == -1) || (text[i] == pattern[j]))
        {
            i=i+1;
            j=j+1;
        }
        else
        {
            j = next[j];
        }
    }
    if (j == pattern_len)
    {
        return i - j;
    }
    else
    {
        return -1;
    }
    return -1;
}

int main()
{
    printf("Please enter the text : ");
    gets(text);

    printf("Please enter the pattern : ");
    gets(pattern);

    getNext();

    int start = 0;
    int pos = 0;
    int has_pattern = 0;
    int text_len = strlen(text);
    while (start < text_len)
    {
        pos = KMP(start);
        if (pos != -1)
        {
            printf("%d ", pos + 1);
            start = pos + 1;
            has_pattern = 1;
        }
        else
        {

            break;
        }
    }
    if (!has_pattern)
    {
        printf("False");
    }
    return 0;
}
