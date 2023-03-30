/*----WHETHER A NUMBER IS ARMSTRONG OR NOT--------*/

#include<stdio.h>
void main()
{
int a,s,n,m;
clrscr();
printf("enter the no");
scanf("%d",&n);
a=0;s=n;
while(n>0)
{ 	m=n%10;
	a=a+m*m*m;
	n=n/10;
}
if (a==s) printf(" the no %d is arm strong",s);
else printf("the no %d is not armstrong",s);
getch();
}