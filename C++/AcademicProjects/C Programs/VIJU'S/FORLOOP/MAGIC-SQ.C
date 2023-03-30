#include<stdio.h>
void main()
{
int x[15][15],s1,s2,s3,s4,i,j,k,l,s,flag=0,r;
clrscr();
printf("Enter no of rows of a square matrix:\n");
scanf("%d",&r);
printf("Enter elements:\n");
for(i=0;i<r;i++)
for(j=0;j<r;j++) scanf("%d",&x[i][j]);

for(s=j=0;j<r;j++) s+=x[0][j];

for(s3=s4=i=0;i<r;i++)
for(j=0;j<r;j++)
{	for(s2=k=0;k<r;k++)
	{	for(s1=l=0;l<r;l++)
		{	if(i!=k||j!=l)
				if(x[i][j]==x[k][l])  flag=1;
			s1+=x[i][l];
		}
		if(s1!=s) flag=1;
		s2+=x[k][j];
	}
   if(s2!=s) flag=1;
   if(i==j) s3+=x[i][j];
   if(i+j==r-1) s4+=x[i][j];
}
if(s3!=s||s4!=s) flag=1;

if(flag) printf("\n\nMatrix is not a Magic-Square:\n");
else printf("\n\nMatrix is a Magic-Square:\n");
getch();
}














