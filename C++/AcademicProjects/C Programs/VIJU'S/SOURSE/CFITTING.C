

#include "\tc\bin\viju's\sourse\statfuns.c"

/*---------*****
	CURVE FITTINGS:DIFFERENT FORMS:
	----------------------------------
1.	Y=A*B^X  ------------------->abtox
2.	Y=A*e^(B*X)  --------------->aetobx
3.	Y=A+B*X  ------------------->abx
4.	Y=A+B*X+C*X*X  ------------->quad
5.	Y=A+B*LnX  ----------------->ablnx
6.	Y=A*X^B  ------------------->axtob
7.	Y=A+B*1/X  ----------------->abinvx
								 ********--------------------*/




void abtox(double x[],double y[],int f[],int n)
{
double z[100],a,b,d;
int i,flag=1;

for(i=0;i<n;i++) z[i]=lne(y[i]);

b=cov(x,z,f,n)/cov(x,x,f,n);
a=expec(z,f,n)-(b*expec(x,f,n));
b=e(b);
a=e(a);
printf("\nCurve fitted Y=(%lf)*(%lf^X)",a,b);

while(flag!=0)
{
printf("\n\nEnter value of x:");
scanf("%lf",&d);
printf("\n%lf=F(%lf)",a*power(b,d),d);
printf("\nEnter 0 to Discontinue:\n");
scanf("%d",&flag);
}

return;
}


void aetobx(double x[],double y[],int f[],int n)
{
double z[100],a,b,d;
int i,flag=1;
for(i=0;i<n;i++) z[i]=lne(y[i]);
b=cov(x,z,f,n)/cov(x,x,f,n);
a=expec(z,f,n)-b*expec(x,f,n);
a=e(a);
printf("\nCurve fitted Y=(%lf)*e^(%lf*X)",a,b);

while(flag!=0)
{
printf("\n\nEnter value of x:");
scanf("%lf",&d);
printf("\n%lf=F(%lf)",a*e(b*d),d);
printf("\nEnter 0 to Discontinue:\n");
scanf("%d",&flag);
}
return;
}


void abx(double x[],double y[],int f[],int n)
{
double a,b,d;
int flag=1;
b=cov(x,y,f,n)/cov(x,x,f,n);
a=expec(y,f,n)-(b*expec(x,f,n));
printf("\ncurve fitted Y=(%lf)+(%lf)*X",a,b);

while(flag!=0)
{
printf("\n\nEnter value of x:");
scanf("%lf",&d);
printf("\n%lf=F(%lf)",a+b*d,d);
printf("\nEnter 0 to Discontinue:\n");
scanf("%d",&flag);
}
return;
}



void quad(double x[],double y[],int f[],int n)
{
double z[100],a,b,c,d;
int i,flag=1;

arraymul(x,x,z,n);
d=cov(z,x,f,n);
c=(cov(z,y,f,n)*cov(x,x,f,n)-d*cov(x,y,f,n));
c/=(cov(z,z,f,n)*cov(x,x,f,n)-d*d);
b=(cov(x,y,f,n)-c*d)/cov(x,x,f,n);
a=expec(y,f,n)-b*expec(x,f,n)-c*expec(z,f,n);
printf("\nCurve fitted,Y=(%lf)+(%lf)*X+(%lf)*X*X",a,b,c);

while(flag!=0)
{
printf("\n\nEnter value of x:");
scanf("%lf",&d);
printf("\n%lf=Q(%lf)",a+b*d+c*d*d,d);
printf("\nEnter 0 to Discontinue:\n");
scanf("%d",&flag);
}
return;
}


void ablnx(double x[],double y[],int f[],int n)
{
double a,b,d,z[100];
int flag=1;

for(a=0;a<n;a++) z[a]=lne(x[a]);
b=cov(z,y,f,n)/cov(z,z,f,n);
a=expec(y,f,n)-(b*expec(z,f,n));
printf("\ncurve fitted Y=(%lf)+(%lf)*Ln(X)",a,b);

while(flag!=0)
{
printf("\n\nEnter value of x:");
scanf("%lf",&d);
printf("\n%lf=F(%lf)",a+b*lne(d),d);
printf("\nEnter 0 to Discontinue:\n");
scanf("%d",&flag);
}
return;
}


void axtob(double x[],double y[],int f[],int n)
{
double a,b,d,z[100],w[100];
int flag=1;

for(a=0;a<n;a++) z[a]=lne(x[a]),w[a]=lne(y[a]);
b=cov(z,w,f,n)/cov(z,z,f,n);
a=expec(w,f,n)-(b*expec(z,f,n));
a=e(a);
printf("\ncurve fitted Y=(%lf)*X^(%lf)",a,b);

while(flag!=0)
{
printf("\n\nEnter value of x:");
scanf("%lf",&d);
printf("\n%lf=F(%lf)",a*power(d,b),d);
printf("\nEnter 0 to Discontinue:\n");
scanf("%d",&flag);
}
return;
}


void abinvx(double x[],double y[],int f[],int n)
{
double a,b,d,z[100];
int flag=1;

for(a=0;a<n;a++) z[a]=(1/x[a]);
b=cov(z,y,f,n)/cov(z,z,f,n);
a=expec(y,f,n)-(b*expec(z,f,n));
printf("\ncurve fitted Y=(%lf)+(%lf)*1/X",a,b);

while(flag!=0)
{
printf("\n\nEnter value of x:");
scanf("%lf",&d);
printf("\n%lf=F(%lf)",a+b*(1.0/d),d);
printf("\nEnter 0 to Discontinue:\n");
scanf("%d",&flag);
}
return;
}


