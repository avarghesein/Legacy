/*--------IF f(x)=a0+a1*x+....+an*x^n=0,WE CAN FIND THE ROOTS BY METHOD
OF FALSE POSITON c0=(b0*f(a0)-a0*f(b0))/(f(a0)-f(b0)).WHERE f(a0)<=0 &
f(b0)>=0 .IF f(c0)<=0 THEN a0=c0 & b0=b0 else a0=a0 & b0=c0 AND SO ON---*/

#include<stdio.h>
int n;
float a[15];

void main()
{
void extern falsepos(float,float);
float extern poly(float);
float r1,r2;
int l1,l2,i,a0,b0;
clrscr();

printf("Enter the degree:\n");
scanf("%d",&n);
printf("Enter the coefficients:\n");
for(i=0;i<=n;i++) scanf("%f",&a[i]);
printf("Enter the range:\n");
scanf("%d%d",&l1,&l2);

for(i=l1;i<=l2;i++)
{	r1=poly(i);
	r2=poly(i+1);
     if((r1<=0&&r2>=0)||(r1>=0&&r2<=0))
     {	if(r1<=0)
		{ 	a0=i;
			b0=i+1;
          }
          else
          {	a0=i+1;
          	b0=i;
          }
          break;
     }
}

if(i<=l2) falsepos(a0,b0);
else printf("\nCannot find solution in this range:\n");

getch();
}

void falsepos(float a0,float b0)
{    float extern poly(float);
	float c0;
     int i;

	for(i=1;i<=500;i++)
     {	c0=(b0*poly(a0)-a0*poly(b0))/(poly(a0)-poly(b0));
     	if(poly(c0)<=0) a0=c0;
          else b0=c0;
     }
printf("Solution by method of False position=%f",c0);
}

float poly(float x)
{     float extern pow(float,int);
	 float l;
      int j;
      for(l=0,j=0;j<=n;j++)
      	l+=a[j]*pow(x,j);

      return(l);
}

float pow(float x,int i)
{	float p;
	if(i==0)return(1);
     else p=x*pow(x,i-1);
     return(p);
}


