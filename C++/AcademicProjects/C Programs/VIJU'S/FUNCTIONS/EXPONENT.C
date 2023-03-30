/*---------EXPONENTIAL SERIES WILL CONVERGE IF |x|<=1,ie -1<x<1 e^x=1+X/1!+X^2/2!+X^3/3!...---------*/

#include<stdio.h>
#include<math.h>
void main()
{
int n;
float x,ex(float,int);
clrscr();
printf("Enter value of X & no of terms:\n");
scanf("%f%d",&x,&n);
printf("\nExponential series for X=%f is %f",x,ex(x,n));
printf("\n\nActual value by EXP function=%f",exp(x));
getch();
}

float ex(float x1,int n1)
{
int j,k,f;
float s,ter;

for(s=0,ter=1,j=0;j<n1;j++)
	{	for(f=1,k=1;k<=j;k++)f*=k;
		s+=ter/f;
     	ter*=x1;
	}
return(s);
}