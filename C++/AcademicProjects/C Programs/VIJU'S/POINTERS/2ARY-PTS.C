#include<stdio.h>
void main()
{  int x[20][20],i,n,j;
   clrscr();

printf("Enter no of nos:\n");
scanf("%d",&n);

printf("\nENTER NOS:\n");
for(i=0;i<n;i++)
for(j=0;j<n;j++)
scanf("%d",&x[i][j]);

printf("\nADDRESS BY DIFFERENT METHODS:\n");

printf("\n\nBY METHOD 1\n");
for(i=0;i<n;i++)
for(j=0;j<n;j++)
printf("\n%u is the address of %d",x[i]+j,*(x[i]+j));

printf("\n\nBY METHOD 2\n");
for(i=0;i<n;i++)
for(j=0;j<n;j++)
printf("\n%u is the address of %d",*(x+i)+j,*(*(x+i)+j));

printf("\n\nBY METHOD 3\n");
for(i=0;i<n;i++)
for(j=0;j<n;j++)
printf("\n%u is the address of %d",&x[i][j],*&x[i][j]);

getch();
}