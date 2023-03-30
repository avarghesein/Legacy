/*----IF f(x)=a0+a1*x+a2*x^2+....+an*x^n=0,THEN WE CAN FIND X BY
NEWTON-RAPHSON METHOD BY THE FORMULA Xn+1=Xn-(f(Xn)/f'(Xn)) .FUNCTION f
MUST HAVE CONTINUOUS FIRST DERIVATIVE.CHOOSE AN X0 SUCH THAT
f'(X0)!=0.------------------------*/


#include<stdio.h>
float a[15];
int n;

void main()
{
void newton(float);
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
	{	r1=poly(i),r2=poly(i+1);
		if((r1<=0&&r2>=0)||(r1>=0&&r2<=0))
				break;
	}
if(i<=l2) newton(i+1);
else printf("\n\nCannot find solution in this range:");

getch();
}

void newton(float x2)
{
	 float extern pow(float,int),poly(float);
	float x1,l1,l2;
     int i,j;
     for(i=1;i<=500;i++)
	 {	x1=x2,l1=poly(x1);
		for(l2=0,j=1;j<=n;j++)
			l2+=j*a[j]*pow(x1,j-1);

		x2=x1-(l1/l2);
	 }
	printf("\n\nSoulution by Newton-Raphson method=%f",x2);

}

float poly(float x)
{	float extern pow(float,int);
	float l=0;
	int j;

	 for(j=0;j<=n;j++)
		l+=a[j]*pow(x,j);
	 return(l);
}

float pow(float x,int i)
{	float p;

if(i==0)return(1);
else p=x*pow(x,i-1);

return(p);
}
