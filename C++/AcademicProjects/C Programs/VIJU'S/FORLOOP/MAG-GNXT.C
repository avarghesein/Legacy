//---program to print magic squares of size 3x3:(0..10->16 m.sq's)--//
//--better to enter range of length 10-------//


#include<stdio.h>
#define ft(t) for(t=r1;t<=r2;t++)

void main()
{
FILE *fle=fopen("magic.txt","w");
int magic(int[][15],int);
int i,j,k,l,m,n,o,p,q,r,s,r1,r2,flag,f=0;
int h[15][15];
clrscr();

printf("PROGRAM TO FIND MAGIC SQUARES IN A RANGE\n\n");
printf("Enter range to cheked:"),scanf("%d%d",&r1,&r2);

ft(i)
ft(j)
{
if(j==i) continue;
ft(k)
{
if(k==j||k==i) continue;
ft(l)
{
if(l==k||l==j||l==i) continue;
ft(m)
{
if(m==l||m==k||m==j||m==i) continue;
ft(n)
{
if(n==m||n==l||n==k||n==j||n==i) continue;
ft(o)
{
if(o==n||o==m||o==l||o==k||o==j||o==i) continue;
ft(p)
{
if(p==o||p==n||p==m||p==l||p==k||p==j||p==i) continue;
ft(q)
{
if(q==p||q==o||q==n||q==m||q==l||q==k||q==j||q==i) continue;

h[0][0]=i,h[0][1]=j,h[0][2]=k,h[1][0]=l,h[1][1]=m,
h[1][2]=n,h[2][0]=o,h[2][1]=p,h[2][2]=q,flag=magic(h,3);
if(flag)
{	++f,fprintf(fle,"\n\n\n\t----MAGIC-SQUARE(%d)-----\n\n\n",f);
	for(r=0;r<3;r++)
	{	for(s=0;s<3;s++)  fprintf(fle,"\t%d",h[r][s]);
		fprintf(fle,"\n\n");
	}
	//printf("\n\n\nPress any key!!!"),getch();
}
}

}
}
}
}
}
}
}
fprintf(fle,"\n\n\n\n\tENDED"),
printf("\n\n\n\n\tPROGRAM-ENDED"),printf("\n\n\n\n\tPress any key!!!"),getch();
}



//-----------magic sqare checking----------------//
int magic(int d[][15],int r)
{
int s,s1,s2,s3,s4,i,j,k,l;

for(s=j=0;j<r;j++) s+=d[0][j];

for(s3=s4=i=0;i<r;i++)
for(j=0;j<r;j++)
{	for(s2=k=0;k<r;k++)
	{	for(s1=l=0;l<r;l++)
		{	if(i!=k||j!=l)
				if(d[i][j]==d[k][l])  return(0);
			s1+=d[i][l];
		}
		if(s1!=s) return(0);
		s2+=d[k][j];
	}
   if(s2!=s) return(0);
   if(i==j) s3+=d[i][j];
   if(i+j==r-1) s4+=d[i][j];
}
if(s3!=s||s4!=s) return(0);
else return(1);
}
