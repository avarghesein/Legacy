/*-----------EVALUATING n-ORDER POLYNOMIAL FOR A GIVEN 'x'----
f(x)=(....(((a0*X+a1)*X+a2)*X+a3)*X+....+an)-----------*/

#include<stdio.h>
void main()
{
float extern poly(float[],int,float);
float a[15],x,s;
int n,i;
clrscr();
printf("Enter 'n' for the n-order polynomial:\n");
scanf("%d",&n);
printf("Enter the value of x:\n");
scanf("%f",&x);
printf("Enter coefficients ai's:\n");
for(i=0;i<=n;i++)scanf("%f",&a[i]);
s=poly(a,n,x);
printf("\n\nValue of Polynomial=%f",s);
getch();
}

float poly(float a1[15],int n1,float x1)
{    float p;
	int i;
     p=a1[0];
     for(i=1;i<=n1;i++)p=p*x1+a1[i];
     return(p);
}