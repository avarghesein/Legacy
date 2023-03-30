/*-------PASSING 2 ARRAYS TO A FUNCTION BY POINTERS----------------*/
#include<stdio.h>
void main()
{  int i,n,x[20],y[20];
   int fun(int *,int *,int);
   clrscr();
printf("Enter no of nos:\n");
scanf("%d",&n);
printf("\nEnter nos for 1st array:\n");
for(i=0;i<n;i++)scanf("%d",&x[i]);
printf("\nEnter nos for 2nd array:\n");
for(i=0;i<n;i++)scanf("%d",&y[i]);
fun(&x[0],&y[0],n);
getch();
}

fun(int *i1,int *i2,int n1)
{
int j,x1[20],y1[20],*p1,*p2;
	for(j=0,p1=i1,p2=i2;j<n1;j++,p1++,p2++)
	{	x1[j]=*p1;
    	     y1[j]=*p2;
	}
for(j=0;j<n1;j++)printf("\n%d",x1[j]);
printf("\n\n");
for(j=0;j<n1;j++)printf("\n%d",y1[j]);
return;
}