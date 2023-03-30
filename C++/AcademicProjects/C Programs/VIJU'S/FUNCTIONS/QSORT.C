/*-----------------QUICK SORTING OF AN ARRAY------------------*/
#include<stdio.h>
void main()
{
void qsort(int[],int,int,int);
int n,i,x[15];
clrscr();

printf("Enter no of nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);
qsort(x,0,1,n-1);
printf("\n\nQuick-sorted array:\n");
for(i=0;i<n;i++) printf("%d\n",x[i]);
getch();
}
/*--------------------QUICK SORT FUNCTION-----------------------*/
void qsort(int x1[],int p,int l,int r)
{
int t,c1=0,c2=0;

if(r>p)
	{     qsort(x1,p,p+1,r-1);
       	 qsort(x1,l,l+1,r);
	 	 while(l<=r)
		{
          	while((c1==0||c2==0)&&l<=r)
			{	if(c1==0)if(x1[p]>=x1[l])l++; else c1++;
				if(c2==0)if(x1[p]<=x1[r])r--; else c2++;
			}
     		if(l>r) break;
     		t=x1[l];
			x1[l]=x1[r];
     		x1[r]=t;
     		l++;r--;
     	}
   		t=x1[p];
   		x1[p]=x1[r];
   		x1[r]=t;
	}

}
