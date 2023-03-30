#include<stdio.h>
void main()
{
int a,n,i,j;
clrscr();
printf("Enter no of raws:");
scanf("%d",&n);
for(i=1;i<=n;i++)
{
     for(j=1;j<=n-i;j++) printf(" ");
     for(a=i,j=1;j<=i;j++,a++)
     if(a>=10) printf("%d",a%10); else
     printf("%d",a);
     for(a=2*i-2,j=1;j<=i-1;j++,a--)
     if(a>=10) printf("%d",a%10); else
     printf("%d",a);
     printf("\n");
 }
 getch();
 }