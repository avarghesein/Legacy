/*----function F(x,y) is for numerical calculation of dy/dx=F(x,y) for
y(x0)=y0, and calculating y for particular value of x---------------//

//------SI(x) is for single integral  ,  DI(x,y) for double integral
calculation,set them properly--------------------------------*/


#include "\tc\bin\viju's\sourse\mat.c"

#ifndef F
#error F(x,y) IS NOT DEFINED
#endif

#ifndef SI
#define SI(x)   1
#endif

#ifndef DI
#define DI(x,y) 1
#endif

double eulerm(double x0,double y0,double x,double h)
{
float i,nos;
double y1,y2;

nos=(x-x0)/h;
for(i=1;i<=nos;i++)
{	y1=y0+h*F(x0,y0);
	y2=y0+h*(F(x0,y0)+F(x0+h,y1))/2.0;
	while(abso(y1-y2)>=.00000001)
	{	y1=y2;
		y2=y0+h*(F(x0,y0)+F(x0+h,y1))/2.0;
	}
	y0=y1,x0+=h;
}
return(y0);
}



double rkmethod(double x0,double y0,double x,double h)
{
float i,nos;
double a,b,c,d,y1;

nos=(x-x0)/h;
for(i=1;i<=nos;i++)
{	a=h*F(x0,y0);
	b=h*F(x0+h/2,y0+a/2);
	c=h*F(x0+h/2,y0+b/2);
	d=h*F(x0+h,y0+c);
	y1=y0+(a+2*b+2*c+d)/6;
	y0=y1,x0+=h;
}
return(y0);
}



double adems(double x0,double y0,double x1,double h)
{
float i,n;
double x[100],y[100],y1[100];

n=(x1-x0)/h;
x[0]=x0,y[0]=y0,y1[0]=F(x0,y0);

for(i=1;i<n;i++) x[i]=x0+i*h,
				 y[i]=rkmethod(x[i-1],y[i-1],x[i],h/10),
				 y1[i]=F(x[i],y[i]);

x[n]=x1;
y[n]=y[n-1]+h*(55*y1[n-1]-59*y1[n-2]+37*y1[n-3]-9*y1[n-4])/24;
y1[n]=F(x[n],y[n]);
y[n]=y[n-1]+h*(9*y1[n]+19*y1[n-1]-5*y1[n-2]+y1[n-3])/24;

return(y[n]);
}


double sintegral(double a,double b)
{
double low,h=(b-a)/(2*TERM),s=0;
	for(low=a;low<=b-2*h;low+=2*h)
		s+=h*(SI(low)+4*SI(low+h)+SI(low+2*h))/3;
return(s);
}


double dintegral(double a,double b,double c,double d)
{
double h1=(b-a)/(2*TERM),h2=(d-c)/(2*TERM),low1,low2,s=0;

	for(low1=a;low1<=b-h1;low1+=h1)
		for(low2=c;low2<=d-h2;low2+=h2)
			s+=h1*h2*(DI(low1,low2)+DI(low1,low2+h2)+DI(low1+h1,low2)+DI(low1+h1,low2+h2))*SQRE(0.5);
	return(s);
}



double fbinterpol(int flag,float xa[],float ya[],int n,float x0)
{
int    i,j,k,fix;
static float x[50],f[50][50],term,h;
double s;

	if(flag==1)
		for(i=0;i<n;i++) x[i]=xa[i],f[0][i]=ya[i];
	else
		for(i=0;i<n;i++) x[i]=xa[n-1-i],f[0][i]=ya[n-1-i];



	for(i=0;i<n;i++)
	{	if(flag==1) if(x0<x[i]) break;
		if(flag==-1) if(x0>x[i]) break;
	}

	fix=(i==0?0:i-1);
	h=(x0-x[fix])/(x[1]-x[0])*flag;
	k=n-1;

	for(i=1;i<n;i++,k--)
		for(j=0;j<k;j++) f[i][j]=(f[i-1][j+1]-f[i-1][j])*flag;

	term=1;
	for(i=0;i<n;i++)
		s+=f[i][fix]*term,term*=(h-(i*flag))/(i+1);

return(s);
}


double everetinterpol(float xa[],float ya[],int n,float x0)
{
int i,j,k,fix;
static float x[50],f[50][50],r,q,term1,term2,temp1,temp2;
double s;

	for(i=0;i<n;i++) x[i]=xa[i],f[0][i]=ya[i];

	for(k=n-1,i=1;i<n;i++,k--)
		for(j=0;j<k;j++) f[i][j]=(f[i-1][j+1]-f[i-1][j]);


	for(i=0;i<n;i++)
		if(x0<x[i]) break;

	fix=(i==0?0:i-1);
	r=(x0-x[fix])/(x[1]-x[0]);
	q=1-r;


	for(s=i=0;(2*i)<n&&fix>=0;fix--,i++)
	{
		for(temp1=q+i,temp2=r+i,term1=term2=j=1;
			j<=2*i+1;j++,temp1-=1,temp2-=1) term1*=temp1/j,term2*=temp2/j;

		s+=term1*f[2*i][fix]+term2*f[2*i][fix+1];
	}

return(s);
}


double interpolation(float xa[],float ya[],int n,float x0)
{
 int i=(n%2==0?n/2:(n+1)/2);

 if(x0>=xa[i-1]&&x0<=xa[i])  return(everetinterpol(xa,ya,n,x0));   else
 if(x0<xa[i-1])              return(fbinterpol(1,xa,ya,n,x0));     else
							 return(fbinterpol(-1,xa,ya,n,x0));

}

