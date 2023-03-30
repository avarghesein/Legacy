#include<stdio.h>
void main()
{
int i,j,n;
clrscr();
printf("enter no of raws");
scanf("%d",&n);
for (i=0;i<n;i++)
{
	for(j=0;j<=n-i;j++)
	 printf(" ");
	for(j=0;j<=i;j++)
	printf("%d",j+1);
	for(j=i-1;j>=0;j--)
	printf("%d",j+1);
	printf("\n");
}
getch();
}