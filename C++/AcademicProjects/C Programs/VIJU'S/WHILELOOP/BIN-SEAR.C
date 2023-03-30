#include<stdio.h>
void main()
{
int i,j,n,x[20],p,l,u,f=0,m;
clrscr();
printf("Enter the no of nos:\n");
scanf("%d",&n);
printf("Enter elements:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);

for(i=0;i<n-1;i++)
for(j=i+1;j<n;j++)
	if(x[i]>x[j])
		{	m=x[i];
			x[i]=x[j];
			x[j]=m;
		}
printf("Enter the no to be searched:\n");
scanf("%d",&p);

l=0;u=n-1;
while(l<=u)
{	m=(l+u)/2;
	if(x[m]>p) u=m-1; else
	if(x[m]<p) l=m+1; else
	if(x[m]==p)
	{	f=1;
		break;
	}
}
if(f) printf("Number is in the array:\n");
else printf("Number is not in the array:");
getch();
}
