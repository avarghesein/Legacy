#include<stdio.h>
void main()
{
int i,j,r,c,x[10][10],l,m;
clrscr();
printf("Enter raws columns & elements:\n");
scanf("%d%d",&r,&c);
for(i=0;i<r;i++)
for(j=0;j<c;j++)scanf("%d",&x[i][j]);
l=r,m=c;
mul(x[0],l,m,r,c);
mul1(x[0]);
getch();
}
mul(int x1[10][10],int p,int q,int r1,int c1)
{
int i,j;
printf("\n\nI AM IN FUN1:\n\n");
for(i=0;i<r1;i++)
{	for(j=0;j<c1;j++)printf("%d\t",x1[i][j]*p*q);
     printf("\n\n");
}
return;
}

mul1(int y1[10][10])
{
int i,j,r1=4,c1=4;
printf("\n\nI AM IN FUN2 ,I AM INSUFFICIENT :\n\n");
for(i=0;i<r1;i++)
{	for(j=0;j<c1;j++)printf("%d\t",y1[i][j]);
	printf("\n\n");
}
return;
}