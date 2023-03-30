#include<stdio.h>
void main()
{
int x[15][15],i,j,k,r,c,t;
clrscr();
printf("Enter no of rows & columns:\n");
scanf("%d%d",&r,&c);
printf("Enter elements:\n");
for(i=0;i<r;i++)
for(j=0;j<c;j++) scanf("%d",&x[i][j]);

for(i=0;i<r;i++)
	for(j=0;j<c;j++)
		for(k=j+1;k<c;k++)
			if(x[i][j]>x[i][k])
			{	t=x[i][j];
				x[i][j]=x[i][k];
				x[i][k]=t;
			}

for(j=0;j<c;j++)
	for(i=0;i<r;i++)
		for(k=i+1;k<r;k++)
			if(x[i][j]>x[k][j])
			{	t=x[i][j];
				x[i][j]=x[k][j];
				x[k][j]=t;
			}

printf("\n\nRow & column sorted Matrix:\n");
for(i=0;i<r;i++)
{	for(j=0;j<c;j++)  printf("%d ",x[i][j]);
	printf("\n");
}
getch();
}
