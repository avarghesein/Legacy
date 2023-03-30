/*-----------TYPE 2 INSERTION SORTING---------*/
#include<stdio.h>
void main()
{  int n,i,j,p;
   long int x[20],t;
   clrscr();
printf("Enter no of nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%ld",&x[i]);
/*---------INSERTION SORTING(TYPE 2) BEGINS-----------*/
for(i=1;i<=n-1;i++)
for(p=i,j=i-1;j>=0;p--,j--)
	if(x[p]<x[j])
	   {
	    t=x[p];
	    x[p]=x[j];
	    x[j]=t;
	    }
	else break;
/*----------INSERTION SORTING(TYPE 2) ENDS---------------*/
printf("\nNos in ASCENDING order:\n");
for(i=0;i<n;i++) printf("\n%ld",x[i]);
getch();
}