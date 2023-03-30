#include<stdio.h>
void main()
{
int i,j,t,x[20],n;
clrscr();
printf("Enter no of nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);

for(i=1;i<=n-1;i++)
	for(j=0;j<n-i;j++)
		if(x[j]>x[j+1])
			{	t=x[j];
				x[j]=x[j+1];
				x[j+1]=t;
			}
printf("\nBubbled sorted array:\n");
for(i=0;i<n;i++) printf("%d\n",x[i]);
getch();
}
