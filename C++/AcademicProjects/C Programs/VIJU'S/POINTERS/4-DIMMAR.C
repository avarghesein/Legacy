#include<stdio.h>
void main()
{
extern  int convert();
extern int  y[10][10][10][10];
int i,j,k,l,m,n,o,p,*r,x[10][10][10][10];
clrscr();
printf("Enter m,n,o,p for 4-dimm array:\n");
scanf("%d%d%d%d",&m,&n,&o,&p);
printf("Enter the elements:\n");
for(i=0;i<m;i++)
for(j=0;j<n;j++)
for(k=0;k<o;k++)
for(l=0;l<p;l++)scanf("%d",&x[i][j][k][l]);
convert(x[0][0][0],m,n,o,p);
for(i=0;i<p;i++)
for(j=0;j<o;j++)
for(k=0;k<n;k++)
for(r=*(*(*(y+i)+j)+k),l=0;l<m;l++,r++)
 x[i][j][k][l]=*r;
printf("\n\nresultant\n\n");
for(i=0;i<p;i++)
{
  for(k=0;k<n;k++)
  {  for(j=0;j<o;j++)
  		for(l=0;l<m;l++)
  			{    if(l==0)printf("|");
				printf("%d ",x[i][j][k][l]);


     		}
      	printf("\n");
   }
printf("\n\n\n");
}
getch();


}

int y[10][10][10][10];

convert(int x1[10][10][10][10],int m1,int n1,int o1,int p1)
{ int i,j,k,l;
for(i=0;i<m1;i++)
for(j=0;j<n1;j++)
for(k=0;k<o1;k++)
for(l=0;l<p1;l++)y[l][k][j][i]=x1[i][j][k][l];
return;
}
