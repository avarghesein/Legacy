
#include<math.h>
#include<iostream.h>
#include<conio.h>


template <class T>
class matx
{
 private:
 		 int rd,cd;
		 T **p;
 public:
 		       matx(int=0,int=0);
               matx(matx&);
        friend istream &operator>>(istream&,matx&);
        friend ostream &operator<<(ostream&,matx&);
               matx &operator=(matx&);
        friend matx operator+(matx&,matx&);
        friend matx operator-(matx&);
        friend matx operator-(matx&,matx&);
        friend matx operator*(T,matx&);
        friend matx operator*(matx&,T);
        friend matx operator*(matx&,matx&);
        friend matx minor(matx&,int,int);
        friend matx semiminor(matx&,int,int);
        friend int  rankof(matx&);
        friend int  rowcanonicalof(matx&,matx&);
        friend int  interchangerows(matx&,int,int);
        friend int  interchangecols(matx&,int,int);
        friend    T det(matx&);
        friend matx adj(matx&);
        friend matx inv(matx&);
		       ~matx();
};

template<class T>
matx<class T>::matx(int r,int c)
{
	rd=r,cd=c;
    p=new T*[rd];
    for(int i=0;i<rd;i++) p[i]=new T[cd];
}

template<class T>
matx<class T>::matx(matx<class T> &x)
{
   	rd=x.rd,cd=x.cd;
    p=new T*[rd];
    for(int i=0;i<rd;i++) p[i]=new T[cd];
    int j;
    for(i=0;i<rd;i++)
    	for(j=0;j<cd;j++) p[i][j]=x.p[i][j];
}


template<class T>
matx<class T>::~matx()
{
    if(p!=0)
    {
		for(int i=0;i<rd;i++) delete []p[i];
    	delete []p;
    }
}


template<class T>
matx<class T> &matx<class T>::operator=(matx<class T> &x)
{
    int i;

    if(p!=0)
    {
		for(i=0;i<rd;i++) delete []p[i];
    	delete []p;
    }

    rd=x.rd,cd=x.cd;
    p=new T*[rd];
    for(i=0;i<rd;i++) p[i]=new T[cd];

    int j;
    for(i=0;i<rd;i++)
    	for(j=0;j<cd;j++) p[i][j]=x.p[i][j];

    return x;
}

template<class T>
matx<class T> operator+(matx<class T> &x,matx<class T> &y)
{
	if(x.rd==0||x.cd==0||y.rd==0||y.cd==0||x.rd!=y.rd||x.cd!=y.cd)
    	return matx<T>();

    int i,j;
    matx<T> z=matx<T>(x);
    for(i=0;i<z.rd;i++)
    	for(j=0;j<z.cd;j++) z.p[i][j]+=y.p[i][j];

    return z;
}

template<class T>
matx<class T> operator-(matx<class T> &x)
{
	matx<T> y=x;
    int i,j;
    for(i=0;i<y.rd;i++)
    	for(j=0;j<y.cd;j++) y.p[i][j]*=-1;
    return y;
}

template<class T>
matx<class T> operator-(matx<class T> &x,matx<class T> &y)
{
	if(x.rd==0||x.cd==0||y.rd==0||y.cd==0||x.rd!=y.rd||x.cd!=y.cd)
    	return matx<T>();

    int i,j;
    matx<T> z=-y;
    return x+z;
}


template<class T>
matx<class T> operator*(matx<class T> &x,matx<class T> &y)
{
	if(x.rd==0||x.cd==0||y.rd==0||y.cd==0||x.cd!=y.rd) return matx<T>();

    matx<T> z(x.rd,y.cd);
    int i,j,k;
    for(i=0;i<z.rd;i++)
    	for(j=0;j<z.cd;j++)
        	for(z.p[i][j]=k=0;k<x.cd;k++) z.p[i][j]+=x.p[i][k]*y.p[k][j];

    return z;
}

template<class T>
matx<class T> operator*(matx<class T> &x,T num)
{
	if(x.rd==0||x.cd==0) return matx<T>();

    matx <T> z(x.rd,x.cd);
    int i,j;
    for(i=0;i<z.rd;i++)
    	for(j=0;j<z.cd;j++)
        	  z.p[i][j]=x.p[i][j]*num;

    return z;
}

template<class T>
matx<class T> operator*(T num,matx<class T> &x)
{
	return x*num;
}


template<class T>
istream &operator>>(istream &in,matx<class T> &x)
{
	cout<<"\nEnter "<<x.rd*x.cd<<" elements\n";
    int i,j;
    for(i=0;i<x.rd;i++)
    	for(j=0;j<x.cd;j++) in>>x.p[i][j];
    return in;
}


template<class T>
ostream &operator<<(ostream &out,matx<class T> &x)
{
    if(x.rd==0||x.cd==0)
    {	out<<"\nError,NULL matrix\n";
    	return out;
    }
	out<<"\nMATRIX\n\n";
    int i,j;
    for(i=0;i<x.rd;i++)
    {
		for(j=0;j<x.cd;j++) out<<x.p[i][j]<<"\t";
        out<<"\n\n";
    }
    return out;
}


template<class T>
matx<class T> minor(matx<class T> &x,int i,int j)
{
	if(x.rd<=0||x.cd<=0||i<0||j<0||i>=x.rd||j>=x.cd||x.rd!=x.cd) return matx<T>(0,0);
    matx<T> min(x.rd-1,x.cd-1);
    int l=0,m=0,u,v;
    for(u=0;u<x.rd;u++)
    	for(v=0;v<x.cd;v++)
        	if(u!=i&&v!=j)
               	if(min.p[l][m]=x.p[u][v],m==x.cd-2) m=0,++l;else ++m;

    return min;
}

template<class T>
matx<class T> semiminor(matx<class T> &x,int i,int j)
{
	if(x.rd<=0||x.cd<=0||i<0||j<0||i>=x.rd||j>=x.cd) return matx<T>(0,0);
    matx<T> min(x.rd-1,x.cd-1);
    int l=0,m=0,u,v;
    for(u=0;u<x.rd;u++)
    	for(v=0;v<x.cd;v++)
        	if(u!=i&&v!=j)
               	if(min.p[l][m]=x.p[u][v],m==x.cd-2) m=0,++l;else ++m;

    return min;
}

template<class T>
T det(matx<class T> &x)
{
T dt=0;
matx<T> min;
int rn,cn,j;

	if(x.rd!=x.cd||x.rd<=0||x.cd<=0)
	{  	cout<<"\nError cannot find determinant,returning NULL",
		getch();
		return T(0);
    }
    if(x.rd==1&&x.cd==1) return x.p[0][0];
    for(j=0;j<x.cd;j++)
    	min=minor(x,0,j),dt+=pow(-1,0+j)*x.p[0][j]*det(min);

    return dt;
}

template<class T>
matx<class T> adj(matx<class T> &x)
{
	if(x.rd<=0||x.cd<=0||x.rd!=x.cd) return matx<T>(0,0);
    matx<T> ad(x.rd,x.cd),coff(x.rd,x.cd),min;
    int i,j;
    for(i=0;i<x.rd;i++)
    	for(j=0;j<x.cd;j++)
           min=minor(x,i,j),ad.p[j][i]=coff.p[i][j]=pow(-1,i+j)*det(min);

	return ad;
}

template<class T>
matx<class T> inv(matx<class T> &x)
{
T dt=det(x);

	if(dt==0) return matx<T>(0,0);
    matx<T> in(T(T(1)/dt)*adj(x));
    return in;
}

template<class T>
int rankof(matx<class T> &x)
{
	if(x.rd<=0||x.cd<=0) return 0;

    matx<class T> a(x);
    int flg,i,j,rn,cn;
    T k;

    for(flg=i=0;i<x.rd;i++)
    {
     	if(flg==1) break;
        for(j=0;j<x.cd;j++)
        	if(fabs(a.p[i][j])>=0.00001)
            {
            	rn=i,cn=j,flg=1;
                break;
            }
    }

    if(flg==0) return 0;

    interchangerows(a,0,rn),interchangecols(a,0,cn);

    for(k=a.p[0][0],j=0;j<x.cd;j++) a.p[0][j]/=k;

    for(j=1;j<x.cd;j++)
    	for(k=a.p[0][j],i=0;i<x.rd;i++) a.p[i][j]-=k*a.p[i][0];

    for(i=1;i<x.rd;i++)
    	for(k=a.p[i][0],j=0;j<x.cd;j++) a.p[i][j]-=k*a.p[0][j];

    a=semiminor(a,0,0);

    return 1+rankof(a);
}

template<class T>
int interchangerows(matx<class T> &x,int r1,int r2)
{
	if(x.rd<=0||x.cd<=0||r1>x.rd||r2>x.rd||r1<0||r2<0) return 0;
    T t;
    for(int j=0;j<x.cd;j++) t=x.p[r1][j],x.p[r1][j]=x.p[r2][j],x.p[r2][j]=t;
    return 1;
}

template<class T>
int interchangecols(matx<class T> &x,int c1,int c2)
{
	if(x.rd<=0||x.cd<=0||c1>x.cd||c2>x.cd||c1<0||c2<0) return 0;
    T t;
    for(int i=0;i<x.rd;i++) t=x.p[i][c1],x.p[i][c1]=x.p[i][c2],x.p[i][c2]=t;
    return 1;
}



template<class T>
int rowcanonicalof(matx<class T> &y,matx<class T> &canon)
{
matx<T> x;
int i,j,k,flag,l,r1,c1;
T m;

	x=y;
    for(l=i=0;i<x.rd;i++)
	{
		for(flag=0,k=i;k<x.rd;k++)
		{
			if(flag==1) break;
			for(flag=j=0;j<x.cd;j++)
				if(fabs(x.p[k][j])>=0.00001)
				{	flag=1,r1=k,c1=j;
					break;
				}
		}
		if(flag==0) break; else ++l;

		interchangerows(x,i,r1);

		for(m=x.p[i][c1],j=0;j<x.cd;j++) x.p[i][j]/=m;

		for(k=0;k<x.rd;k++)
			for(m=x.p[k][c1],j=0;j<x.cd;j++)
				if(k==i) break; else x.p[k][j]-=m*x.p[i][j];
	}

	x.rd=l;

	for(i=0;i<x.rd;i++)
	{	if(x.p[i][i]!=0) continue;
		for(k=i+1;i<x.rd;k++)
			if(x.p[k][i]!=0)
			{	interchangerows(x,i,k);
				break;
			}
			else continue;
	}

	canon=x;

return(l);
}

