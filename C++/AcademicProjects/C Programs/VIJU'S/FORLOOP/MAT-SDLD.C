#include<stdio.h>
#include<stdlib.h>
void main()
{
int x[15][15],r,c,i,j,k,l,sd,ld;
clrscr();
printf("Enter no of rows & columns:\n");
scanf("%d%d",&r,&c);
printf("Enter elments:\n");
for(i=0;i<r;i++)
for(j=0;j<c;j++) scanf("%d",&x[i][j]);

ld=sd=abs(x[0][1]-x[0][0]);
for(i=0;i<r;i++)
	for(j=0;j<c;j++)
		for(k=0;k<r;k++)
			for(l=0;l<c;l++)
				if(i!=k&&j!=l)
				{	ld=(abs(x[i][j]-x[k][l])>ld)?abs(x[i][j]-x[k][l]):ld;
					sd=(abs(x[i][j]-x[k][l])<sd)?abs(x[i][j]-x[k][l]):sd;
				}
printf("\nLargest difference is %d\n\nSmallest differance is %d",ld,sd);
getch();
}