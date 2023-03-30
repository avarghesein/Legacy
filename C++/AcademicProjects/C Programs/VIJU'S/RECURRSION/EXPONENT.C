#include<stdio.h>
#include<math.h>
void main()
{
extern float ex(float,int);
float x;
int n;
clrscr();
printf("Enter x & no of terms:\n");
scanf("%f%d",&x,&n);
printf("\n\ne(%f)=%f\n\n",x,ex(x,n));
printf("e(%f) by function is %f\n",x,exp(x));
getch();
}

float ex(float x,int n)
{
extern float po(float,int);
extern int fac(int);
if(n==0) return(1);
else return(po(x,n)/fac(n)+ex(x,n-1));
}

float po(float x,int n)
{
if(n==0) return(1);
else return(x*po(x,n-1));
}

int fac(int n)
{
if(n==0) return(1);
else return(n*fac(n-1));
}