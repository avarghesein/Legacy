/*-----LARGEST AMONG 4---------*/
#include<stdio.h>
void main()
{
int a,b,c,d,k,l;
clrscr();
printf("Enter the 4 nos:\n");
scanf("%d%d%d%d",&a,&b,&c,&d);
l=(k=(a>b)?(a>c)?a:c : (b>c)?b:c)>d?k:d;
printf("\nLargest=%d",l);
getch();
}