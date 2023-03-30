/*------------ARMSTRONG NUMBERS IN A RANGE--------------------*/

#include<stdio.h>
void main()
{
	int a,m,r1,r2,i,j,flag=0;
	clrscr();
	printf("Finding Armstrog numbers in the given range\n\n");
	printf("Enter the range:");
	scanf("%d%d",&r1,&r2);
	i=r1;
	while(i<=r2)
	{     a=0,j=i;
		  while(j>0)
		  {		  m=j%10;
				  a=a+m*m*m;
				  j=j/10;
		  }
		  if (a==i)
		  {		  printf("\n%d",i);
				  flag=1;
		  }
		  i++;
	}
	if(flag==0) printf("\nNo Armstrong numbers in the given range");
	getch();
}
