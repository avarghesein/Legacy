
/*-----Program to print fibonacci series upto 'n' terms----*/
#include<stdio.h>
/*-------------------Program begins--------------------*/
void main()
{
/*-------------------Variable declaration--------------*/
	int f1,f2,f3,n,i;
	clrscr();
/*-------------------Variable initialisation-----------*/
	i=1,f1=0,f2=1,f3=0;
	printf("Enter number of terms:\n");
/*-------------------Scannig the value of 'n'------------*/
	scanf("%d",&n);
	printf("\nFibonacci Series upto %d terms is\n",n);
/*--------------------while loop begins---------------*/
	while(i<=n)
	{
		f1=f2;
		f2=f3;
		f3=f1+f2;
		printf("\n %d",f3);
		i++;
	}
/*--------------------while loop ends---------------*/
	getch();
}
/*--------------------Program ends-------------------*/