/*---------Hellically traversing a matrix----------*/
#include<stdio.h>
void main()
{
int r,c,x[10][10],i,j,r0,c0,r1,c1;
clrscr();
printf("Enter no of rows & columns:\n");
scanf("%d%d",&r,&c);
printf("Enter elments:\n");
for(i=0;i<r;i++)
	for(j=0;j<c;j++) scanf("%d",&x[i][j]);

for(r1=r-1,c1=c-1,r0=c0=0;r0<=r1&&c0<=c1;r0++,c0++,r1--,c1--)
{
	printf("\n\n%dth shell is:\n",r0+1);
	for(j=c0;j<=c1;j++) 	printf("%d ",x[r0][j]);
	for(j=r0+1;j<=r1;j++) 	printf("%d ",x[j][c1]);
	for(j=c1-1;j>=c0;j--) 	printf("%d ",x[r1][j]);
	for(j=r1-1;j>=r0+1;j--) printf("%d ",x[j][c0]);

}
getch();
}