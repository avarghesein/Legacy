/*------INSERTION SORTING(TRUE METHOD)----------*/

#include<stdio.h>
void main()
{
int n,i,x[20],p,j,c,k;
clrscr();
printf("Enter number of numbers:\n");
scanf("%d",&n);
printf("Enter numbers to be sorted:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);

for(i=1;i<=n-1;i++)
{	for(p=i,j=i-1;j>=0;j--)
		if(x[i]<x[j])p=j;
	c=x[i];
     for(k=i-1;k>=p;k--)
     	x[k+1]=x[k];
     x[p]=c;
}

printf("\nNumbers in ascending order is:\n\n");
for(i=0;i<n;i++)printf("%d\n",x[i]);
getch();
}