#include<stdio.h>
void main()
{
int n,p;
int fact(int*);
clrscr();
printf("Enter n:\n");
scanf("%d",&n);
p=n;
printf("\n\n%d!=%d",p,fact(&n));
getch();
}
int fact(int *n)
{
int p;
if(*n==0) return(1);
else
{   p=*n;
	*n=*n-1;
	return(p*fact(n));
}

}