#include<stdio.h>
void main()
{

int x[15][15],*xp=x,i,j,n;
clrscr();
printf("Enter n:\n");scanf("%d",&n);
printf("Enter elments:\n");
for(i=0;i<n;i++)
for(j=0;j<n;j++) scanf("%d",*(x+i)+j);
printf("\n\n\n");
for(i=0;i<n;i++)
{	for(j=0;j<n;j++)
		printf("%d   ",*(*(x+i)+j));
	printf("\n\n");
}
getch();
}

