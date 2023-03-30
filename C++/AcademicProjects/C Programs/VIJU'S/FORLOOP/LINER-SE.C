#include<stdio.h>
void main()
{
int i,n,p,x[20];
clrscr();
printf("Enter no of nos:\n");
scanf("%d",&n);
printf("Enter numbers:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);
printf("Enter no to be searched:\n");
scanf("%d",&p);
for(i=0;i<n;i++)
{	if(x[i]==p)
	{	printf("Number is in the array:");
		break;
	}
}
if(i==n) printf("Number is not in the array:");
getch();
}