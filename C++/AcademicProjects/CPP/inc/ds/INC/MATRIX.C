
#include<stdio.h>
#include"\tc\bin\viju's\sourse\mat.c"
#define SIZE 50

int  minorof(a,i,j,rows,cols,min,rn,coln)
float a[][SIZE],min[][SIZE];
int i,j,rows,cols,*rn,*coln;
{
int l=0,m=0,p,q;

	if(rows<=0||cols<=0||i<0||j<0||i>=rows||j>=cols) return(0);

	for(p=0;p<rows;p++)
		for(q=0;q<cols;q++)
			if(p!=i&&q!=j)
			{
				min[l][m]=a[p][q];
				if(m==cols-2) m=0,++l; else ++m;
			}
	*rn=rows-1,*coln=cols-1;

return(1);
}



float determinantof(float a[][SIZE],int rows,int cols)
{
float x[SIZE][SIZE],det=0;
int rn,cn,j;

	if(rows<=1&&cols<=1) return(a[0][0]);

	for(j=0;j<cols;j++)
		minorof(a,0,j,rows,cols,x,&rn,&cn),
		det+=power(-1,0+j)*a[0][j]*determinantof(x,rn,cn);

return(det);
}




int adjointof(float a[][SIZE],int rows,int cols,float adj[][SIZE],int *r,int *c)
{
float coff[SIZE][SIZE],min[SIZE][SIZE];
int i,j,rn,cn;

	if(rows<=0||cols<=0) return(0);

	for(i=0;i<rows;i++)
		for(j=0;j<cols;j++)
			minorof(a,i,j,rows,cols,min,&rn,&cn),
			coff[i][j]=power(-1,i+j)*determinantof(min,rn,cn),
			adj[j][i]=coff[i][j];

	*r=cols,*c=rows;
return(1);
}



int inverseof(float a[][SIZE],int rows,int cols,float inv[][SIZE],int *r,int *c)
{
int i,j;
float m=determinantof(a,rows,cols),adj[SIZE][SIZE];

	if(m==0) return(0);

	for(adjointof(a,rows,cols,adj,r,c),i=0;i<*r;i++)
		for(j=0;j<*c;j++)
			inv[i][j]=adj[i][j]/m;

return(1);
}



int multiply(m1,m,n,m2,o,p,m3,q,r)
float m1[][SIZE],m2[][SIZE],m3[][SIZE];
int   m,n,o,p,*q,*r;
{
int i,j,k;

  if(!(n==o)) return(0);

  for(i=0;i<m;i++)
	for(j=0;j<p;j++)
		for(m3[i][j]=0,k=0;k<n;k++)
			m3[i][j]+=m1[i][k]*m2[k][j];

  *q=m,*r=p;

return(1);
}