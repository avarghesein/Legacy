/*--THIS FILE INCLUDES FUNCTIONS FOR "power(x^y),LNe(X),e(X),X!,|x|,---//
----roundf(X,to total decimal spaces) & LOG(BASE,VALUE) ie LOGn(X)"----//
sinh(x),cosh(x),tanh(x),sinh~1(x).......... --------------------------*/
//----Functions are [power,lne,e]------------------------------------//
//----------------------------------------------------------------------//

#define TERM      (1E6)
#define DELTA     (1E-25)
#define PI        (3.14159265358979323846)
#define LN10      (2.30258509299404568402)
//----------------------------------------------------------------------//
#define  SQRT(x)   (power((x),.5))
#define  SQRE(x)   ((x)*(x))
#define  RAD(x)    ((x)*PI/180)
#define  DEG(x)    ((x)*180/PI)
//-----------------------------------------------------------------------//
#define SIN(x)    (cosin((x),1))
#define COS(x)    (cosin((x),0))
#define TAN(x)    (SIN(x)/COS(x))
#define COT(x)    (1.0/TAN(x))
#define SEC(x)    (1.0/COS(x))
#define CSC(x)    (1.0/SIN(x))
//---------------------------------------------------------------------//
#define SINI(x)    (sini(x))
#define COSI(x)    ((PI/2.0)-SINI(x))
#define TANI(x)    (SINI((x)/SQRT(1+SQRE(x))))
#define COTI(x)    (TANI(1/(x)))
#define SECI(x)    (cscseci(x,0))
#define CSCI(x)    (cscseci(x,1))
//-----------------------------------------------------------------------//
#define SINH(x)    ((e(x)-e(-x))/2.0)
#define COSH(x)    ((e(x)+e(-x))/2.0)
#define TANH(x)    (SINH(x)/COSH(x))
#define COTH(x)    (1.0/TANH(x))
#define SECH(x)    (1.0/COSH(x))
#define CSCH(x)    (1.0/SINH(x))
//-----------------------------------------------------------------------//
#define SINHI(x)   (lne((x)+SQRT((x)*(x)+1)))
#define COSHI(x)   (lne((x)+SQRT((x)*(x)-1)))
#define TANHI(x)   (lne((1+(x))/(1-(x)))*.5)
#define COTHI(x)   (TANHI((1/(x))))
#define SECHI(x)   (COSHI((1/(x))))
#define CSCHI(x)   (SINHI((1/(x))))
//-----------------------------------------------------------------------//
  void   toxy(double*,double*);
  void   topolar(double*,double*);
double   abso(double);
double   e(double);
double   fact(double);
double   lne(double);
double   roundf(double,int);
double   round(double);
double   loga(double,double);
double   cosin(double,int);
double   cscseci(double,int);

//----------------POWER FUNCTION--------------------------------------------//
static double powers(double x,double n)
{
double p,i;
	if(n>=0)
	{  	for(p=1,i=n;i>=1;i--,p*=x);
		return(p);
	}
	else
	{	n=-n;
		for(p=1,i=n;i>=1;i--,p*=x);
		return((double)1/p);
	}

}
		  ///*************************************************///

double power(double x,double y)
{
 long int k=y;

 if(x==0)   return(0.0);         else
 if(y-k==0) return(powers(x,y));  else
 if(x>0)    return(e(y*lne(x)));
 else printf("\n\nDOMAIN ERROR,returning NULL,press any key!!!\n"),
	  getch();

 return(0);
}
//-----------------NATURAL LOG LNe(X)----------------------------------------//
static double ln(double x)
{
	double s=0,term=(x-1),i;

	for(i=1;i<=TERM&&abso(term/i)>=DELTA;i++)
	   s+=(term/i),term*=(1-x);
	return(s);

}
	  ///***************************************************///
double lne(double x)
{
	if(x>0)
	{   long int c;
		if(x>=1.0)
		{   for(c=0;x>1.0;x/=10.0,c++);
			return(ln(x)+((double)c*LN10));
		}
		else
		{   for(c=0;x<0.1;x*=10.0,c++);
			return(ln(x)-((double)c*LN10));
		}

	}
	else printf("\n\nDOMAIN ERROR,returning NULL,press any key!!!\n"),
	getch(),exit(1);
	return(0);
}
//-------------------EXPONENT e(X)-----------------------------------------//
static double ex(double x)
{
	double s=1.0,term=1.0;
	double n;

	for(n=1;(n<=TERM)&&(abso(term)>=DELTA);n++)
		term*=(x/n),s+=term;

	return(s);
}

			   ///*****************************************///

double e(double x)
{
	if(abso(x)>=.00001)
	{   double i;
		for(i=1;abso(x)>=.00001;x/=10,i*=10);
		return(powers(ex(x),i));
	}
	else return(ex(x));
}

//--------------------FACTORIAL X!--------------------------------------------------//

double fact(double n)
{
	if(n==0) return(1);
	else return(n*fact(n-1));
}
//----------------ROUNDING NUMBERS-----------------------------------------//

double round(double x)
{	double k=.5;

	if(x<0.0) k=-k;
	return((double)((long int)(x+k)));
}
			//***************************************//

double fround(double x,int n)
{
	long int y,z,i;

	for(x-=(y=x),i=1;i<=n;x*=10,i++);
	for(x=round(x-(z=x))+z,i=1;i<=n;x/=10,i++);
	return(x+(double)y);

}
//--------------------------LOGa(X)-------------------------------------//
double loga(double a,double y)
{
	return((lne(y)/lne(a)));
}
//--------------------------------|X|---------------------------------------//
double abso(double x)
{
	if(x<=0.0) return(-x);
	else return(x);
}

//--------------------------SERIESES----------------------------------------//
static int chkangle(double *x,int *k,int *ad)
{
	int flag=0;

	*ad=1;

	if(abso(*x)>=2*PI)
	{	   float i;

		   for(i=1;(i+1)*2*PI<abso(*x);i++);
		   *x=(*x>=0?(abso(*x)-2*PI*i):-(abso(*x)-2*PI*i));
	} else *x=*x;


	if(abso(*x)>=PI)
	{	   if(*k==1) flag=1;
		   *x=(*x>=0?(2*PI-abso(*x)):-(2*PI-abso(*x)));
	} else *x=*x;


	if(abso(*x)>=PI/2.0)
	{	   if(*k==0) flag=1;
		   *x=(*x>=0?(PI-abso(*x)):-(PI-abso(*x)));
	} else *x=*x;


	if(abso(*x)>=PI/4.0)
	{       if(*x<0) *ad*=-1;
			*k=(*k==1?0:1);
			*x=(*x>=0?(PI/2-abso(*x)):-(PI/2-abso(*x)));
	}else   *x=*x,*k=*k;


	return(flag);
}


			///******************************************///

double cosin(double x,int k)
{
	int ad;
	double s,n,term,flag=chkangle(&x,&k,&ad);


	s=term=(k==0?1.0:x);
	for(n=1;n<=TERM&&abso(term)>=DELTA;n++)
		term*=(x*x*-1)/((2*n+k-1)*(2*n+k)),s+=term;

	if(flag)  return(-s*ad); else  return(s*ad);
}
//----------------------------------------------------------------------//
double sini(double x)
{   double sum,flag,term,n;

	if(abso(x)<=1)
	{
		sum=flag=x,term=1,n=0;
		do
		{	n++;
			term*=(2*n-1)/(2*n),flag*=x*x;
			sum+=(term*flag)/(2*n+1);
		}while(n<=TERM&&(abso((term*flag)/(2*n+1))>=DELTA));
		return(sum);
	}
	else printf("RANGE ERROR,returning NULL"),getch();
	return(0);
}
//------------------------------------------------------------------------//
double cscseci(double x,int k)
{
	if(abso(x)<1)
	{	printf("RANGE ERROR,returning NULL"),getch();
		return(0);
	}
	else if(k==1) return(SINI(1/(x)));
	else return(COSI(1/(x)));
}
//------------------------------------------------------------------------//
void topolar(double *x,double *y)
{
	double t,v2=*y;
	if(*x==0&&*y==0)
	{	printf("\n\nMATH ERROR!"),getch();
		return;
	}
	else
	{
		if(*x!=0)
		{	t=(TANI((abso(*y)/abso(*x))));
			*y=(*x>0?(*y>0?t:2*PI-t):(*y>0?PI-t:PI+t));
		}
		else *y=(*y>0?PI/2.0:3*PI/2.0);

		*x=abso(v2/(SIN(*y)));
		return;
	}

}
//-------------------------------------------------------------------------//
void toxy(double *r,double *t)
{
	double temp=*r;
	*r=temp*COS(*t);
	*t=temp*SIN(*t);
	return;
}
//------------------------------------------------------------------------//
