#include<stdio.h>
void main()
{
 int fac(int);
 int n,r,n1;
clrscr();
printf("Enter n & r:\n");
scanf("%d%d",&n,&r);
n1=fac(n)/(fac(r)*fac(n-r));
printf("\nnPr=%d",fac(n)/fac(r));
printf("\nnCr=%d",n1);
getch();
}
/*------FUNCTON STARTS---------*/
fac(int x)
{
int fa,i;
for(i=fa=1;i<=x;i++) fa*=i;
return(fa);
}
/*-------FUNCTION ENDS----------*/