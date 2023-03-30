/*-------------FINDING (a+b)^n=a^n+nC1*a^n-1*b+nC2*a^n-2*b^2+.....+nCn*b^n---
-----------*/
#include<stdio.h>
int n;

void main()
{
float extern bino(float,float,int);
float a,b,s;
clrscr();
printf("Enter the value of a & b & power:\n");
scanf("%f%f%d",&a,&b,&n);
s=bino(a,b,n);
printf("\nThe value of (%f+%f)^%d is %f\n",a,b,n,s);
getch();
}

float bino(float a1,float b1,int i1)
{
extern float power(float,int),ncr(float,float);
float s1;
if(i1==0) return(power(a1,n));
else s1=ncr(n-i1+1,i1)*power(a1,n-i1)*power(b1,i1)+bino(a1,b1,i1-1);
return(s1);
}

float ncr(float n1,float i1)
{
float k;
if(i1==0) return(1);
else k=(n1/i1)*ncr(n1+1,i1-1);
return(k);
}

float power(float x,int r)
{
float k;
if(r==0)return(1);
else k=x*power(x,r-1);
return(k);
}