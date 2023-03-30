#include<stdio.h>
void main()
{
void fibo(int,int,int);
int n,a=1,b=1;
clrscr();
printf("Enter terms:\n");
scanf("%d",&n);
if(n>0)
{	printf("The Fiboncci series is:\n");
	fibo(n,a,b);
}
else printf("No of terms is 0");
getch();
}

void fibo(int n1,int a,int b)
{
printf("%d\n",a);
if(n1==1) return;
else  fibo(n1-1,b,a+b);
}