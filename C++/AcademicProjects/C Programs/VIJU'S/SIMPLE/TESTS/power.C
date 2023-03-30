
/*--THIS FILE INCLUDES FUNCTIONS FOR "power(x^y),LNe(X),e(X),X!,|x|,---//
----roundf(X,to total decimal spaces) & LOG(BASE,VALUE) ie LOGn(X)"----//
sinh(x),cosh(x),tanh(x),sinh~1(x).......... --------------------------*/
#define LN10  2.30258509299404568402
#define TRAP  100000
#define TERM  100000000
#define ADIF .000000001
#define F(x)  (1.0/(x))
//----------------------------------------------------------------------//
double   e(double);
double   power(double,double);
double   fact(double);
double   abso(double);
double   lne(double);
double   ln(double x);
double   roundf(double,int);
double   round(double);
double   loga(double,double);
double   cosin(double,int);
//----------------------------------------------------------------------//
#define SIN(x)    (cosin(x,1))
#define COS(x)    (cosin(x,0))
#define TAN(x)    (SIN(x)/COS(x))
#define COT(x)    (1.0/TAN(x))
#define SEC(x)    (1.0/COS(x))
#define CSC(x)    (1.0/SIN(x))
//-----------------------------------------------------------------------//
#define SINH(x)    ((e(x)-e(-x))/2.0)
#define COSH(x)    ((e(x)+e(-x))/2.0)
#define TANH(x)    (SINH(x)/COSH(x))
#define COTH(x)    (1.0/TANH(x))
#define SECH(x)    (1.0/COSH(x))
#define CSCH(x)    (1.0/SINH(x))
//-----------------------------------------------------------------------//
#define SINHI(x)   (lne((x)+powers((x)*(x)+1,.5)))
#define COSHI(x)   (lne((x)+powers((x)*(x)-1,.5)))
#define TANHI(x)   (lne((1+(x))/(1-(x)))*.5)
#define COTHI(x)   (TANHI((1/(x))))
#define SECHI(x)   (COSHI((1/(x))))
#define CSCHI(x)   (SINHI((1/(x))))
//-----------------------------------------------------------------------//
double powers(double x,double y)
{
long int k=y;

 if(y-k==0) return(power(x,y));  else
 if(x>0) return(e(y*lne(x)));
 else printf("\n\nImaginary condition,returning NULL,press any key!!!\n"),
	  getch();
 return(0);
}
//----------------------------------------------------------------------//
double lne(double x)
{
	if(x>0)
	{   long int c;
		if(x>=1.0)
		{   for(c=0;((long int)x)!=0;x/=10.0,c++);
			return(ln(x)+((double)c*LN10));
		}
		else
		{   for(c=0;(x*10.0)<1.0;x*=10.0,c++);
			return(ln(x)-((double)c*LN10));
		}

	}
	else printf("\n\nImaginary condition,returning NULL,press any key!!!\n"),
	getch(),exit(1);
	return(0);
}
//-----------------------------------------------------------------------//
double ln(double x)
{
	if(x>0)
	{	double a=1,b=x,y0=0,low,h,t;
		int f=0;

		if(a>b) t=a,a=b,b=t,f=1;
		h=(b-a)/(2*TRAP);

		for(low=a;low<=b-h;low+=h)
			y0+=h*(F(low)+F(low+h))*.5;

		if(f==1) y0*=-1;
		return(y0);
	}
	else printf("\n\nImaginary condition,returning NULL,press any key!!!\n"),
	getch(),exit(1);
return(0);
}
//---------------------------------------------------------------------//
double ln(double x)
{
	#define F(x)  (1.0/(x))
	if(x>0)
	{	double a=1,b=x,y0=0,low,h,t;
		int f=0;

		if(a>b) t=a,a=b,b=t,f=1;
		h=(b-a)/(2*TRAP);

		for(low=a;low<=b-2*h;low+=2*h)
			y0+=h*(F(low)+4*F(low+h)+F(low+2*h))/3;

		if(f==1) y0*=-1;
		return(y0);
	}
	else printf("\n\nImaginary condition,returning NULL,press any key!!!\n"),
	getch(),exit(1);
return(0);
}
//----------------------------------------------------------------------//

double e(double x)
{
	double s=0,i;

	for(i=0.0;i<=TERM&&abso(power(x,i)/fact(i))>=ADIF;i++)
		s+=power(x,i)/fact(i);
	return(s);
}

//------------------------------------------------------------------------//
double power(double x,double n)
{
double p,i;
	if(n>=0)
	{  	for(p=1,i=n;i>=1;i--) p*=x;
		return(p);
	}
	else
	{	n=-n;
		for(p=1,i=n;i>=1;i--) p*=x;
		return((double)1/p);
	}

}

//----------------------------------------------------------------------//
double fact(double n)
{
	if(n==0) return(1);
	else return(n*fact(n-1));
}
//-----------------------------------------------------------------------//

double abso(double x)
{
	if(x<=0.0) return(-x);
	else return(x);
}

//------------------------------------------------------------------------//
double round(double num)
{
long int t=num,k=1;

	if(t<0) k=-k;

	if(abso((num-(double)t))>=.5) return((double)t+k);
	else return((double)t);
}
//----------------------------------------------------------------------//

double roundf(double num,int n)
{
long int p=num,i;
double k=num-p,b;

	for(i=1;i<=n;i++) k*=10;
	b=round(k);
	for(i=1,k=b;i<=n;i++) k/=10;

	return(((double)p)+k);
}
//----------------------------------------------------------------------//
double loga(double a,double y)
{
	return(lne(y)/lne(a));
}
//--------------------------------------------------------------------//

double cosin(double x,int k)
{
	double s=0,i;

	for(i=0.0;i<=TERM&&abso(power(x,2*i+k)/fact(2*i+k))>=ADIF;i++)
		s+=power(-1,i)*power(x,2*i+k)/fact(2*i+k);
	return(s);
}
//----------------------------------------------------------------------//
