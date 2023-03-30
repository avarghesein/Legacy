#include<stdio.h>
void main()
{
void count();
static int x=545;
int i;
clrscr();
printf("Main-1,x=%d\n",x);
for(i=0;i<=3;i++) count();
x+=5;
printf("Main-2,x=%d\n",x);
count();
getch();
}
void count()
{
static int x=0;
x=x+1;
printf("Fun-%d,x=%d\n",x,x);
}