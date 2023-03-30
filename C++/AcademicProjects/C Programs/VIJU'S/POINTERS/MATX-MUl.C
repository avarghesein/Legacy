/*-------------MULTIPLICATION OF A NUMBER OF MATRICES---------*/

#include<stdio.h>
void main()
{
extern int *mult();
int i,j,*p,*h,y[10][10];
clrscr();
p=mult();
h=p;
clrscr();
printf("The resultant matrix is:\n\n");
for(i=0;i<*(h+18);i++,p=h+i*20)
{
	for(j=0;j<*(h+19);j++,p++)
	{	y[i][j]=*p;
		printf("\t%d",y[i][j]);
	}
	printf("\n\n");
}
printf("\n\nNo of matrices eliminated due to error is %d",*(h+17));

getch();
}

int x[10][15][20];
*mult()
{
int i,j,k,l,n,r,c,e;
printf("Enter no of matrices:\n");
scanf("%d",&n);
printf("\nEnter matrices in order:\n\n");
for(i=0;i<n;i++)
{	printf("Enter the no of %dth matrix's raws & columns:\n",i+1);
	scanf("%d%d",&r,&c);
     x[i][0][18]=r;
     x[i][0][19]=c;
     printf("Enter elements:\n");
     for(j=0;j<r;j++)
     	for(k=0;k<c;k++)scanf("%d",&x[i][j][k]);
}
for(e=0,i=1;i<n;i++)
{	for(j=0;j<x[0][0][18];j++)
		for(k=0;k<x[0][0][19];k++)
			x[n][j][k]=x[0][j][k];
	x[n][0][18]=x[0][0][18];
     x[n][0][19]=x[0][0][19];
     if(x[n][0][19]!=x[i][0][18])
     {	e++;
     	continue;
     }
     for(j=0;j<x[n][0][18];j++)
     	for(k=0;k<x[i][0][19];k++)
          	for(x[0][j][k]=l=0;l<x[n][0][19];l++)
               	x[0][j][k]+=x[n][j][l]*x[i][l][k];
     x[0][0][18]=x[n][0][18];
     x[0][0][19]=x[i][0][19];
}
x[0][0][17]=e;
return(x[0][0]);
}