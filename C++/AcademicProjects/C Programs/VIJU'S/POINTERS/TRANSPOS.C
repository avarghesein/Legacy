/*-----------READING 2-DIMM ARRAY PASSING TO FUNCTION & TRANSPOSING IT  &..
...RETURNIG TO MAIN BY POINTER :....ONLY CONSIDER THE NO OF LOCATIONS OF
..COLUMNS OF ARRAY DECLARATION HERE 15 NOT 20--------------*/


#include<stdio.h>
void main()
{  int i,j,n,m,x[20][15],y[20][15],*k,*l,*transpose(int *,int,int);
   clrscr();

printf("Enter no of raws & columns for the matrix:\n");
scanf("%d%d",&n,&m);

printf("Enter elements:\n");
for(i=0;i<n;i++)
	for(j=0;j<m;j++)scanf("%d",&x[i][j]);

l=transpose(x[0],n,m);
k=l;
for(i=0;i<m;i++,l=k+15*i)
	for(j=0;j<n;j++,l++)y[i][j]=*l;

printf("\n\n");
printf("\n*****TRANSPOSED MATRIX*****\n");
for(i=0;i<m;i++)
    {	for(j=0;j<n;j++)printf("%d  ",y[i][j]);
    	     printf("\n\n");
    }

getch();

}

int x2[20][15];

int *transpose(int *p,int n1,int m1)
{
int i,j,x1[20][15],*k;

k=p;
for(i=0;i<n1;i++,p=k+15*i)
	for(j=0;j<m1;j++,p++)x1[i][j]=*p;

for(i=0;i<n1;i++)
	for(j=0;j<m1;j++)x2[j][i]=x1[i][j];

return(x2[0]);

}