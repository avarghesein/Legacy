

#include "\tc\bin\viju's\sourse\mat.c"




void arraymul(double x[],double y[],double z[],int n)
{
int i;
for(i=0;i<n;i++) z[i]=x[i]*y[i];
return;
}

double expec(double x[],int f[],int n)
{
double s=0;
int tf=0,i;
for(i=0;i<n;i++) s+=x[i]*f[i],tf+=f[i];
s/=tf;
return(s);
}

double cov(double x[],double y[],int f[],int n)
{
double z[100];

arraymul(x,y,z,n);
return(expec(z,f,n)-(expec(x,f,n)*expec(y,f,n)));
}

void readclass(double x[],int n)
{
int i;
for(i=0;i<n;i++) scanf("%lf",&x[i]);
return;
}


int absolute(int no)
{
if(no>=0) return(no);
else return(-no);
}


double rankcorrelation(double x[],double y[],int n)
{
#define CORRECT(m) for(r[m]=0,k=1;k<=s[m];r[m]+=(double)(c[m]--)/s[m],k++)
#define COUNT(m,d) (c[m]=(d[i]>d[j])?c[m]+1:c[m])
#define SOUNT(m,d) (s[m]=(d[i]==d[j])?s[m]+1:s[m])

int i,j,k,c[2],s[2];
double r[2],sum;

for(sum=i=0;i<n;i++)
{	for(c[0]=c[1]=s[0]=s[1]=j=0;j<n;j++)
	{	COUNT(0,x);COUNT(1,y);
		SOUNT(0,x);SOUNT(1,y);
	}
	c[0]=n-c[0],c[1]=n-c[1];
	CORRECT(0);CORRECT(1);
	sum+=(r[0]-r[1])*(r[0]-r[1])+(double)(s[0]*s[0]+s[1]*s[1]-2)/12;
}
sum*=6.0/(double)(n*(n*n-1)),sum*=-1,sum+=1;

#undef CORRECT
#undef COUNT
#undef SOUNT

return(sum);
}


double karlcorrelation(double x[],double y[],int f[],int n)
{
	return(cov(x,y,f,n)/SQRT(cov(x,x,f,n)*cov(y,y,f,n)));
}



/*-----------STATISTICAL FUNCTIONS--------*/




/*----------A.M OF 'n' VALUES Xi'S WITH FREQENCIES Fi'S---------*/
float mean(float x[],int f[],int n)
{
int i,tf;
float s;
for(s=tf=i=0;i<n;i++)
	s+=x[i]*f[i],tf+=f[i];
return(s/tf);
}

/*-----STANDARD DEVIATION OF 'n' VALUES Xi'S WITH FREQENCIES Fi'S--*/
float stddev(float x[],int f[],int n)
{
int i,tf;
float s,am;
for(s=tf=i=0;i<n;i++)
	s+=x[i]*x[i]*f[i],tf+=f[i];
am=mean(x,f,n);
return(sqrt((s/tf)-(am*am)));
}

/*-----MEAN DEVIATION OF 'n' VALUES Xi'S WITH FREQENCIES Fi'S--*/
float meandev(float x[],int f[],int n)
{
int i,tf;
float am,s;
am=mean(x,f,n);
for(s=tf=i=0;i<n;i++)
	s+=f[i]*absolute(x[i]-am),tf+=f[i];
return(s/tf);
}

/*---CO-VARIENCE B/W 2 VARIABLES X & Y WITH FREQ'S AND 'n' OBSERVATIONS---*/
float covarience(float x[],float y[],int f[],int n)
{
int i,tf;
float co;
for(i=tf=0;i<n;i++)
	co+=f[i]*x[i]*y[i],tf+=f[i];
co/=tf;
co-=mean(x,f,n)*mean(y,f,n);
return(co);
}

//---------Reading 'n' classes of type "lowerbound-upperbound"-----//
//---------lower=d1 & upper=d2---------------------------//
void readclass1(int n,double d1[],double d2[])
{
int i;
printf("\nEnter lower-bounds:\n");
for(d1[0]=0,i=1;i<=n;i++) scanf("%lf",d1+i);
printf("\nEnter upper-bounds:\n");
for(d2[0]=0,i=1;i<=n;i++) scanf("%lf",d2+i);
return;
}

//--Making inclusive class to exclusive of type "lower(d1)-upper(d2)"---//
//-----'n' observations ,"[d1]_[d2]-->[d]"---------------//
void exclusive(int n,double d1[],double d2[],double d[])
{
int i;
double m1;
for(d[0]=d1[0]=d2[0]=0,i=1;i<=n;i++)
	m1=(d1[i]-d2[i-1])/2,d1[i]-=m1,d2[i]+=m1,d[i]=(d1[i]+d2[i])/2;
return;
}
