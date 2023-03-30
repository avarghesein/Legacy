#include<stdio.h>
void main()
{ int l,i,j,n,k;
clrscr();
printf("Enter Odd no of raws:");
scanf("%d",&n);
printf("\n\n");
l=n/2;
for(i=0;i<=l;i++)
{	for(j=0;j<l-i;j++) printf(" ");
	for(j=0;j<=2*i;j++) printf("*");
	printf("\n");
}
for(k=2,j=0;j<l;j++,k+=2)
{	for(i=0;i<=j;i++) printf(" ");
	for(i=0;i<n-k;i++) printf("*");
	printf("\n");
}
getch();
}