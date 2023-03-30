/*-----LARGEST AMONG 5---------*/
#include<stdio.h>
void main()
{
int a,b,c,d,e,k,l,m;
clrscr();
printf("\aenter the 5 nos:\n");
scanf("%d%d%d%d%d",&a,&b,&c,&d,&e);
m=(l=(k=(a>b)?(a>c)?a:c : (b>c)?b:c)>d?k:d)>e?l:e;
printf("\nLargest=%d",m);
getch();
}