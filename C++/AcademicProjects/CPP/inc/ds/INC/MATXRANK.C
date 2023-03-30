
#include"\tc\bin\ds\inc\matrix.c"


int interchangerows(float x[][SIZE],int r1,int r2,int rows,int cols)
{
int j;
float t;
	if(rows<=0||cols<=0||r1<0||r2<0||r1>=rows||r2>=rows) return(0);

	for(j=0;j<cols;j++) t=x[r1][j],x[r1][j]=x[r2][j],x[r2][j]=t;

return(1);
}



int interchangecols(float x[][SIZE],int c1,int c2,int rows,int cols)
{
int i;
float t;
	if(rows<=0||cols<=0||c1<0||c2<0||c1>=cols||c2>=cols) return(0);

	for(i=0;i<rows;i++) t=x[i][c1],x[i][c1]=x[i][c2],x[i][c2]=t;

return(1);
}



int copymatrix(float x[][SIZE],int r,int c,float y[][SIZE])
{
int i,j;

	if(r<=0||c<=0) return(0);

	for(i=0;i<r;i++)
		for(j=0;j<c;j++) y[i][j]=x[i][j];

return(1);
}



int rankof(float x[][SIZE],int rows,int cols)
{
float min[SIZE][SIZE],a[SIZE][SIZE],k;
int i,j,rn,cn,flag;

	if(rows<=0||cols<=0) return(0);

	copymatrix(x,rows,cols,a);

	for(flag=i=0;i<rows;i++)
	{
		if(flag==1) break;

		for(j=0;j<cols;j++)
			if(abso(fround(a[i][j],5))>=0.00001)
			{
				rn=i,cn=j,flag=1;
				break;
			}
	}

	if(flag==0) return(0);

	interchangerows(a,0,rn,rows,cols);
	interchangecols(a,0,cn,rows,cols);

	for(k=a[0][0],j=0;j<cols;j++) a[0][j]/=k;

	for(j=1;j<cols;j++)
		for(k=a[0][j],i=0;i<rows;i++) a[i][j]-=k*a[i][0];

	for(i=1;i<rows;i++)
		for(k=a[i][0],j=0;j<cols;j++) a[i][j]-=k*a[0][j];

	minorof(a,0,0,rows,cols,min,&rn,&cn);

	return(1+rankof(min,rn,cn));
}





int rowcanonicalmatxof(y,rows,cols,x,rowc,colc)
float x[][SIZE],y[][SIZE];
int rows,cols,*rowc,*colc;
{
int i,j,k,flag,l,r1,c1;
float m;

	copymatrix(y,rows,cols,x);

	for(l=i=0;i<rows;i++)
	{
		for(flag=0,k=i;k<rows;k++)
		{
			if(flag==1) break;
			for(flag=j=0;j<cols;j++)
				if(abso(fround(x[k][j],5))>=0.00001)
				{	flag=1,r1=k,c1=j;
					break;
				}
		}
		if(flag==0) break; else ++l;

		interchangerows(x,i,r1,rows,cols);

		for(m=x[i][c1],j=0;j<cols;j++) x[i][j]/=m;

		for(k=0;k<rows;k++)
			for(m=x[k][c1],j=0;j<cols;j++)
				if(k==i) break; else x[k][j]-=m*x[i][j];
	}

	*rowc=l,*colc=cols;

	for(i=0;i<*rowc;i++)
	{	if(x[i][i]!=0) continue;
		for(k=i+1;k<*rowc;k++)
			if(x[k][i]!=0)
			{	interchangerows(x,i,k,*rowc,*colc);
				break;
			}
			else continue;
	}

return(l);
}