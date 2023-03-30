
#include<iostream.h>
#include<conio.h>

class matx
{
 private:
 		 int rd,cd,**p;
 public:
 		matx(int=0,int=0);
        matx(matx&);
        void read(void);
        void print(void);
        matx &operator=(matx&);
        friend matx operator+(matx&,matx&);
        friend matx operator-(matx&);
        friend matx operator-(matx&,matx&);
        friend matx operator*(float,matx&);
        friend matx operator*(matx&,float);
        friend matx operator*(matx&,matx&);
		~matx();
};


matx::matx(int r,int c)
{
	rd=r,cd=c;
    p=new int*[rd];
    for(int i=0;i<rd;i++) p[i]=new int[cd];
}

matx::matx(matx &x)
{
   	rd=x.rd,cd=x.cd;
    p=new int*[rd];
    for(int i=0;i<rd;i++) p[i]=new int[cd];
    int j;
    for(i=0;i<rd;i++)
    	for(j=0;j<cd;j++) p[i][j]=x.p[i][j];
}


matx::~matx()
{
	for(int i=0;i<rd;i++) delete []p[i];
    delete []p;
}

matx &matx::operator=(matx &x)
{
	for(int i=0;i<rd;i++) delete []p[i];
    delete []p;

    rd=x.rd,cd=x.cd;
    p=new int*[rd];
    for(i=0;i<rd;i++) p[i]=new int[cd];

    int j;
    for(i=0;i<rd;i++)
    	for(j=0;j<cd;j++) p[i][j]=x.p[i][j];

    return x;
}

matx operator+(matx &x,matx &y)
{
	if(x.rd==0||x.cd==0||y.rd==0||y.cd==0||x.rd!=y.rd||x.cd!=y.cd)
    	return matx();

    int i,j;
    matx z=matx(x);
    for(i=0;i<z.rd;i++)
    	for(j=0;j<z.cd;j++) z.p[i][j]+=y.p[i][j];

    return z;
}

matx operator-(matx &x)
{
	matx y=x;
    int i,j;
    for(i=0;i<y.rd;i++)
    	for(j=0;j<y.cd;j++) y.p[i][j]*=-1;
    return y;
}


matx operator-(matx &x,matx &y)
{
	if(x.rd==0||x.cd==0||y.rd==0||y.cd==0||x.rd!=y.rd||x.cd!=y.cd)
    	return matx();

    int i,j;
    matx z=-y;
    return x+z;
}


matx operator*(matx &x,matx &y)
{
	if(x.rd==0||x.cd==0||y.rd==0||y.cd==0||x.cd!=y.rd) return matx();

    matx z(x.rd,y.cd);
    int i,j,k;
    for(i=0;i<z.rd;i++)
    	for(j=0;j<z.cd;j++)
        	for(z.p[i][j]=k=0;k<x.cd;k++) z.p[i][j]+=x.p[i][k]*y.p[k][j];

    return z;
}


matx operator*(matx &x,float num)
{
	if(x.rd==0||x.cd==0) return matx();

    matx z(x.rd,x.cd);
    int i,j;
    for(i=0;i<z.rd;i++)
    	for(j=0;j<z.cd;j++)
        	  z.p[i][j]=x.p[i][j]*num;

    return z;
}

matx operator*(float num,matx &x)
{
	return x*num;
}

void matx::read(void)
{
	cout<<"\nEnter "<<rd*cd<<" elements\n";
    int i,j;
    for(i=0;i<rd;i++)
    	for(j=0;j<cd;j++) cin>>p[i][j];
    return;
}



void matx::print(void)
{
    if(rd==0||cd==0)
    {	cout<<"\nError,Empty matrix\n";
    	return;
    }
	cout<<"\nMATRIX\n\n";
    int i,j;
    for(i=0;i<rd;i++)
    {
		for(j=0;j<cd;j++) cout<<p[i][j]<<"\t";
        cout<<"\n\n";
    }
    return;
}