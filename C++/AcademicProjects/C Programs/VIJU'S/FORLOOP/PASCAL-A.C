#include<stdio.h>


void main()
{
FILE *o;

int i,j,n,p[15][15];
clrscr();
o=fopen("pas.txt","w");
printf("Enter no of rows:\n");
scanf("%d",&n);
for(i=1;i<=n;i++)
{   for(j=1;j<=n-i;j++) fprintf(o," ");
	for(j=1;j<=i;j++)
		if(j==1||i==j) fprintf(o,"%d ",p[i][j]=1);
		else fprintf(o,"%d ",p[i][j]=p[i-1][j-1]+p[i-1][j]);
	fprintf(o,"\n");
}
printf("\n\n\tProcedure ended"),getch();
}