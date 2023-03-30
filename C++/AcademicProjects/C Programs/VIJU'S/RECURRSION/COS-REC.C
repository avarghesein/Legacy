#include<stdio.h>
#include<math.h>
void main()
{
extern float cosi(float,int);
float x,a;
int n;
clrscr();

printf("Enter angle & no of terms:\n");
scanf("%f%d",&x,&n);
a=x;
x*=3.141519/180;
printf("\n\nCOS%f=%f\n\n",a,cosi(x,n-1));
printf("COS%f=%f(By function)\n",a,cos(x));
getch();
}

float cosi(float x,int n)
{
extern float po(float,int);
extern int fa(int),si(int);

if(n==0) return(1);
else return((si(n)*po(x,2*n)/fa(2*n))+cosi(x,n-1));
}

float po(float x,int n)
{
if(n==0) return(1);
else return(x*po(x,n-1));
}

int fa(int n)
{
if(n==0) return(1);
else return(n*fa(n-1));
}

int si(int n)
{
if(n==0) return(1);
else return(-1*fa(n-1));
}