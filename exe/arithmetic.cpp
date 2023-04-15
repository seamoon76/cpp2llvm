#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int lessPrior[6][6] = {
    {1, 1, 1, 1, 0, 1},
    {1, 1, 1, 1, 0, 1},
    {0, 0, 1, 1, 0, 1},
    {0, 0, 1, 1, 0, 1},
    {0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 0, 1}
};

struct Stack {
    int val[1000];
    int cur;
} op, value;

void init(int stack_kind) {
    if(stack_kind==0){
        (&op)->cur = 0;
    }
    else{
        if(stack_kind==1)
        {
            (&value)->cur=0;
        }
    }
    return;
}

void push(int stack_kind, int n) {
    int i = (&op)->cur;
    if(stack_kind==0){
        (&op)->val[i] = n;
        (&op)->cur = (&op)->cur + 1;
    }
    else{
        if(stack_kind==1)
        {
            i = (&value)->cur;
            (&value)->val[i] = n;
            (&value)->cur = (&value)->cur + 1;
        }
    }
    return;
}

int pop(int stack_kind) {
    if(stack_kind==0){
        (&op)->cur = (&op)->cur - 1;
        return (&op)->val[(&op)->cur];
    }
    else{
        if(stack_kind==1)
        {
            (&value)->cur = (&value)->cur - 1;
            return (&value)->val[(&value)->cur];
        }
    }
    return 0;
}

int top(int stack_kind) {
    if(stack_kind==0){
        if((&op)->cur<1)
        {
            printf("cannot get top of empty stack.\n");
            return 0;
        }
        return (&op)->val[(&op)->cur-1];
    }
    else{
        if(stack_kind==1)
        {
            if((&op)->cur<1)
            {
                printf("cannot get top of empty stack.\n");
                return 0;
            }
            return (&value)->val[(&value)->cur-1];
        }
    }
    return 0;
}


int indexOf(char ch) {
    int index =10;
    if(ch=='+')
    {
        index = 0;
    }
    else {
        if (ch=='-')
        {
            index = 1;
        }
        else {
            if (ch=='*')
            {
                index = 2;
            }
            else {
                if (ch=='/')
                {
                    index = 3;
                }
                else {
                    if (ch=='(')
                    {
                        index = 4;
                    }
                    else {
                        if (ch==')')
                        {
                            index = 5;
                        }
                    }
                }
            }
        }
    }
    return index;
}

void sendOp(char op) {
    int right = pop(1);
    if(op=='+')
    {
        push(1, pop(1) + right);
    }
    else
    {
        if(op=='-')
        {
            push(1, pop(1) - right);
        }
        else
        {
            if(op=='*')
            {
                push(1, pop(1) * right);
            }
            else
            {
                if(op=='/')
                {
                    push(1, pop(1) / right);
                }
            }
        }
    }
    return;
}

int main() {
    init(1);
    init(0);
    char str[101];
    printf("Please enter an expression:\n");
    gets(str);
    int i = 0;
    while (str[i]) {
        if (isdigit(str[i])) {
            int j = i;
            while (str[i] && isdigit(str[i])) { i = i + 1; }
            char buff[11];
            int count=i-1;
            while (count>=j)
            {
                buff[count-j]=str[count];
                count=count-1;

            }
            push(1, atoi(buff));
            continue;
        }
        int con=0;
        if(!((&op)->cur == 0))
        {
            if(lessPrior[indexOf(str[i])][indexOf(top(0))])
            {
                con=1;
            }
            else{
                con=0;
            }
        }
        else{
            con=0;
        }
        while ( con ) {
            sendOp(pop(0));
            if(!((&op)->cur == 0))
            {
            if(lessPrior[indexOf(str[i])][indexOf(top(0))])
            {
                con=1;
            }
            else{
                con=0;
            }
            }
            else{
                con=0;
            }
        }
        if(!((&op)->cur == 0)){
        if ((str[i] == ')') && (top(0) == '(')) {
            pop(0);
            i = i + 1;
            continue;
        }
        }
        if ((str[i] == '-') &&
            (!i || ((!isdigit(str[i - 1]) && (str[i - 1] != ')')))))
            push(1, 0);
        push(0, str[i]);
        i = i + 1;
    }
    while (!((&op)->cur == 0))
        sendOp(pop(0));
    int out = pop(1);
    printf("%d\n", out);
    return 0;
}