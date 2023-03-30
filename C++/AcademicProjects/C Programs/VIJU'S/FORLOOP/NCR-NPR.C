#include<stdio.h>
void main()
{
long int n,r,m,s,i,a,p;
clrscr();
printf("Enter n&r ");
scanf("%ld%ld",&n,&r);
m=n;s=n;
for(;m>n-(r-1);m--)   s*=(m-1);
for(p=1,i=r;i>0;i--) p=p*i;
a=s/p;
printf("nCr=%ld & nPr=%ld",a,s);
getch();
}
