#include<stdio.h>
int x[20];

void main()
{
void qsort(int,int);
int i,n;
clrscr();
printf("Enter no of nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);
qsort(0,n-1);
printf("\n\nQuick-Sorted array:\n");
for(i=0;i<n;i++) printf("%d\n",x[i]);
getch();
}
void qsort(int l,int r)
{
int u=r,d=l,t;

if(r>l)
{	while(d<u)
	{	while(x[l]>=x[d]&&d<=r) d++;
		while(x[l]<=x[u]&&u>l)  u--;
		if(d<u)
		{	t=x[d];
			x[d]=x[u];
			x[u]=t;
		}
	}
	t=x[l];
	x[l]=x[u];
	x[u]=t;
	qsort(l,u-1);
	qsort(u+1,r);
}
return;
}

