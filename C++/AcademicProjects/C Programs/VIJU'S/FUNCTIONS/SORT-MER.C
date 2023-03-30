#include<stdio.h>
void main()
{
void sorts(int[],int);
int x[15],y[15],z[15],i,j,k,p,n1,n2;
clrscr();
printf("Enter number of nos in the 1st array & 2nd array:\n");
scanf("%d%d",&n1,&n2);
printf("Enter nos for 1st array:\n");
for(i=0;i<n1;i++) scanf("%d",&x[i]);
sorts(x,n1);
printf("Enter nos for 2nd array:\n");
for(i=0;i<n2;i++) scanf("%d",&y[i]);
sorts(y,n2);

for(i=j=k=0;i<n1&&j<n2;k++)
	if(x[i]>=y[j])
	{	z[k]=y[j];
		j++;
	}
	else
	{	z[k]=x[i];
		i++;
	}
for(p=i;p<n1;p++,k++) z[k]=x[p];
for(p=j;p<n2;p++,k++) z[k]=y[p];

printf("\nThe MERGED sorted array is:\n");
for(i=0;i<n1+n2;i++) printf("%d\n",z[i]);
getch();
}

void sorts(int a[15],int d)
{	int i,j,t;
for(i=0;i<d-1;i++)
for(j=i+1;j<d;j++)
	if(a[i]>a[j])
     {	t=a[i];
     	a[i]=a[j];
          a[j]=t;
     }
return;
}