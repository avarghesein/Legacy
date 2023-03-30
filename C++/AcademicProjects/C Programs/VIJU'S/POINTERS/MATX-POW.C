/*-----------FINDING THE POWER OF A MATRIX-----------*/

#include<stdio.h>
int y1[10][20];

void main()
{
int x[10][20],*q,*k,*mult(int),i,j,r1;
clrscr();
printf("Enter no of raws or columns of the square matrix:\n");
scanf("%d",&r1);

q=mult(r1);
k=q;
printf("\n\nThe %dth power of given matrix:\n\n",*(q+r1));
for(i=0;i<r1;i++,q=k+20*i)
{	for(j=0;j<r1;j++,q++)
		{ 	x[i][j]=*q;
          	printf("\t%d",x[i][j]);
     	}
	printf("\n\n");
}

getch();
}



int *mult(int r)
{
int x1[10][20],z1[10][20],i,j,p,l,k;

printf("Enter elements:\n");
for(i=0;i<r;i++)
	for(j=0;j<r;j++)
	   {		scanf("%d",&x1[i][j]);
			y1[i][j]=x1[i][j];
        }

printf("Enter the power:\n");
scanf("%d",&p);
for(l=1;l<p;l++)
   {	 for(i=0;i<r;i++)
      	for(j=0;j<r;j++)
      		for(z1[i][j]=0,k=0;k<r;k++)
         			z1[i][j]+=y1[i][k]*x1[k][j];

      for(i=0;i<r;i++)
      	for(j=0;j<r;j++)
			y1[i][j]=z1[i][j];
   }
y1[0][r]=p;

return(y1[0]);
}



