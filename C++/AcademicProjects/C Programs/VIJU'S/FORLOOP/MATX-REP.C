#include<stdio.h>
void main()
{
extern int test(int,int[],int);
int r,c,x[15][15],na[15],nc[15],i,j,k,l,flag=0,count,m=-1;
clrscr();
printf("Enter no of rows & columns:\n");
scanf("%d%d",&r,&c);
printf("Enter elments:\n");
for(i=0;i<r;i++)
	for(j=0;j<c;j++) scanf("%d",&x[i][j]);

for(i=0;i<r;i++)
	for(j=0;j<c;j++)
	{	for(count=1,k=i;k<r;k++)
			for(l=(k==i)?j+1:0;l<c;l++)
				if(x[i][j]==x[k][l]) count++;

		if(count>1)
			if(test(x[i][j],na,m)==1||m<0)
			{	na[++m]=x[i][j];
				nc[m]=count;
				flag=1;
			}
	}
if(!flag) printf("\n\nNo elment is repeated:\n");
else  for(i=0;i<=m;i++)
	  printf("\n%d is repeated %d times:",na[i],nc[i]);
getch();
}


int test(int num,int d[],int m)
{
int i,flag=1;
for(i=0;i<=m;i++)
	if(num==d[i])
	{	flag=0;
		break;
	}
return(flag);
}