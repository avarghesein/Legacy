/*-----HELLICALLY TRAVERSING OF A SQUARE MATRIX----------*/
#include<stdio.h>
void main()
{
int r,x[10][10],i,j;
clrscr();
printf("Enter no of rows of the square matrix:\n");
scanf("%d",&r);
printf("Enter elments:\n");
for(i=0;i<r;i++)
	for(j=0;j<r;j++) scanf("%d",&x[i][j]);
r-=1;
i=0;
while(i<=r)
{
	printf("\n\n%dth shell is:\n",i+1);
	for(j=i;j<=r;j++)   	printf("%d ",x[i][j]);
	for(j=i+1;j<=r;j++) 	printf("%d ",x[j][r]);
	for(j=r-1;j>=i;j--) 	printf("%d ",x[r][j]);
	for(j=r-1;j>=i+1;j--)   printf("%d ",x[j][i]);
	i++,r--;
}
getch();
}