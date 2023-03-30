#include<stdio.h>
int x[20][20],y[20][20],z[20][20],r,c,i,j;

void main()
{
void matsort(int[][20]),read(int[][20]);
void remain(int[][20],int,int);
int i1,i2,j1,j2;
clrscr();

printf("Enter no of rows & columns:\n");
scanf("%d%d",&r,&c);

printf("Enter elments of 1st matrix:\n");
read(x);
matsort(x);

printf("Enter elements of 2nd matrix:\n");
read(y);
matsort(y);

for(i=i1=i2=j=j1=j2=0;i1<r&&i2<r; )
{
	if(x[i1][j1]>=y[i2][j2])
	{	z[i][j]=y[i2][j2];
		if(j2==c-1)
		{	i2++;
			j2=0;
		}
		else j2++;
	}
	else
	{	z[i][j]=x[i1][j1];
		if(j1==c-1)
		{	i1++;
			j1=0;
		}
		else j1++;
	}
	if(j==c-1)
	{	i++;
		j=0;
	}
	else j++;
}
remain(x,i1,j1);
remain(y,i2,j2);

printf("\n\nSorted Merged matrix:\n\n");
for(i=0;i<2*r;i++)
{	for(j=0;j<c;j++) printf("%d   ",z[i][j]);
	printf("\n\n");
}

getch();
}

void read(int d[][20])
{	int i,j;
	for(i=0;i<r;i++)
		for(j=0;j<c;j++) scanf("%d",&d[i][j]);
}
void matsort(int d[][20])
{	int i,j,k,l,t;
	for(i=0;i<r;i++)
		for(j=0;j<c;j++)
			for(k=i;k<r;k++)
				for(l=(i==k)?j+1:0;l<c;l++)
					if(d[i][j]>=d[k][l])
					{	t=d[i][j];
						d[i][j]=d[k][l];
						d[k][l]=t;
					}
}
void remain(int d[][20],int i1,int j1)
{	int k,l;
	for(k=i1;k<r;k++)
		for(l=(k==i1)?j1:0;l<c;l++)
		{	z[i][j]=d[k][l];
			if(j==c-1)
			{	i++;
				j=0;
			}else j++;
		}
}


