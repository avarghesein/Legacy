/*--------------FACTORIAL BY RECURRSION OF FUNCTION--------------*/

#include<stdio.h>
void main()
{
	 extern int fac(int);
	 int n,r,x;
	 clrscr();
	 printf("Enter number:\n");
	 scanf("%d",&x);
/*-----Calling the function & printing the value returned by it----*/
	 printf("\nFactorial of %d ie, %d!=%d \n",x,x,fac(x));
	 getch();
}
/*--------------Function to find the factorial starts--------------*/
	 int fac(int x1)
	 {   if(x1==0) return(1);
		 else return(x1*fac(x1-1));
	 }
/*------------Function to find the factorial ends------------------*/