#include<stdio.h>
void main()
{
void fib(int);
int n;
clrscr();
printf("Enter no of terms:\n");
scanf("%d",&n);
printf("\nFibonacci-series:\n");
fib(n);
getch();
}

void fib(int n)
{
static int f1,f2;

if(n<2)
{	f1=0;
	f2=1;
}
else
{	fib(n-1);
	f2=f1+f2;
	 f1=f2-f1;
}
printf("%d\n",f2);
}