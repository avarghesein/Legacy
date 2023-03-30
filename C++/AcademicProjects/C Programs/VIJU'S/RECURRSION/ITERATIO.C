/*----IF f(x)=a0+a1*x+a2*x^2+....+an*x^n=0,THEN WE CAN FIND X BY FIXED POINT
ITERATION BY MAKING THE EQN X(n+1)=g(Xn) .IF J IS THE INTERVAL CONTAINIG THE
SOLUTION OF X THEN |g'(X)|<1 THROUG OUT J,THEN THE ITERATION CONVERGES TO
THE SOLUTION ELSE WE GET  FALSE VALUES------------------------*/


#include<stdio.h>
float a[15];
int n;

void main()
{
void root(float);
float extern poly(float);
int i,j,l1,l2;
float r1,r2;
clrscr();

printf("Enter the degree of the equation:\n");
scanf("%d",&n);
printf("Enter the coefficients:\n");
for(i=0;i<=n;i++) scanf("%f",&a[i]);
printf("Enter range:\n\n");
scanf("%d%d",&l1,&l2);

	for(i=l1;i<=l2;i++)
	{	r1=poly(i);
     	r2=poly(i+1);
		if((r1<0&&r2>=0)||(r1>0&&r2<=0))
		  		break;
	}
     if(i<=l2) root(i+1);
     else printf("\n\nCannot find solution in this range:");

getch();
}

void root(float x2)
{
     float extern pow(float,int);
	float x1;
     int i,j;
     for(i=1;i<=500;i++)
     {	x1=x2;
     	for(x2=0,j=0;j<=n-1;j++)
          	x2+=a[j+1]*pow(x1,j);
          x2=(-a[0])/x2;
	}
	printf("\n\nSoulution by iteration=%f",x2);

}

float poly(float x)
{	float extern pow(float,int);
	float l;
     int j;

     for(l=0,j=0;j<=n;j++)
     	l+=a[j]*pow(x,j);
     return(l);
}

float pow(float x,int n)
{	float p;

if(n==0)return(1);
else p=x*pow(x,n-1);

return(p);
}
