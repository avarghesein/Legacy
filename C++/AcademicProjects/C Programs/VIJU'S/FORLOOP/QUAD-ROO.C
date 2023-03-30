/*--------Program to find the roots of a quadratic equation------*/
#include<stdio.h>
#include<math.h>
/*-------------------Program begins----------------------------*/
void main()
{
float a,b,c,d,x1,x2;
clrscr();

printf("Enter a,b,c for a*X*X+b*X+c=0:\n");
scanf("%f%f%f",&a,&b,&c);
d=b*b-4*a*c;
if(d==0) printf("\nOnly one root,x1=x2=%f\n",-b/(2*a));else
if(d>0)
{    x1=(-b+sqrt(d))/2*a;
	 x2=(-b-sqrt(d))/2*a;
	 printf("\n1st root is %f\n2nd root is %f",x1,x2);
}
else
{	d=-d;
	x1=-b/2*a;
	x2=sqrt(d)/2*a;
	printf("\nRoots are imaginary they are:\n");
	printf("\n%f+%fi\n%f-%fi\n",x1,x2,x1,x2);
}

getch();
}