/*-------------MERGE SORTING OF 2 ARRAYS---------------*/

#include<stdio.h>
void main()
{
int n1,n2,i,j,t,p,k,x[20],y[20];
clrscr();
printf("Enter no of numbers for the 2 arrays:\n");
scanf("%d%d",&n1,&n2);
printf("Enter numbers for 1st array:\n");
for(i=0;i<n1;i++)scanf("%d",&x[i]);
printf("Enter numbers for 2nd array:\n");
for(i=0;i<n2;i++)scanf("%d",&y[i]);

/*----------------SORING INDIVIDUAL ARRAYS-------------*/

for(i=0;i<n1;i++)
	for(j=i+1;j<n1;j++)
     	if(x[i]>x[j])
          	{  	t=x[i];
               	x[i]=x[j];
                    x[j]=t;
               }

for(i=0;i<n2;i++)
	for(j=i+1;j<n2;j++)
     	if(y[i]>y[j])
          	{	t=y[i];
               	y[i]=y[j];
                    y[j]=t;
               }


/*---------MERGING OF FIRST SORTED ARRAY INTO THE 2ND SORTED ARRAY--------*/

p=0;
for(i=0;i<n1;i++)
{	for(j=p;j<n2;j++)
		if(x[i]<y[j]) break;

	p=j+1;
	for(k=n2-1;k>=j;k--)y[k+1]=y[k];
     y[j]=x[i];
     n2++;
}

printf("\n\nThe sorted merged arrary:\n");
for(i=0;i<n2;i++)printf("\n%d",y[i]);
getch();
}

