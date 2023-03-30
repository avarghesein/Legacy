#include<stdio.h>
void main()
{
int x[15][15],i,j,k,l,t,r,c;
clrscr();
printf("Enter no of rows & columns:\n");
scanf("%d%d",&r,&c);
printf("Enter elements:\n");
for(i=0;i<r;i++)
for(j=0;j<c;j++) scanf("%d",&x[i][j]);

for(i=0;i<r;i++)
	for(j=0;j<c;j++)
		for(k=i;k<r;k++)
			for(l=(i==k)?j+1:0;l<c;l++)
				if(x[i][j]>x[k][l])
				{	t=x[i][j];
					x[i][j]=x[k][l];
					x[k][l]=t;
				}

printf("\n\nCompleteley Sorted Matrix:\n");
for(i=0;i<r;i++)
{	for(j=0;j<c;j++)
		printf("%d ",x[i][j]);
	printf("\n");
}
getch();
}