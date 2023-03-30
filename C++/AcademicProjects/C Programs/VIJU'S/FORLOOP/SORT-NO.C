/*-----------NORMAL SORTING----*/

#include<stdio.h>
void main()
{ int n,i,j;
  float x[15],t;
  clrscr();
printf("Enter no of nos to SORTED:\n");
scanf("%d",&n);
printf("Enter the nos:\n");
for(i=0;i<n;i++) scanf("%f",&x[i]);

for(i=0;i<n;i++)
for(j=i+1;j<n;j++)
	if(x[i]>x[j])
        {   t=x[i];
        	  x[i]=x[j];
		  x[j]=t;
	   }
printf("\nNOS IN ASCENDING ORDER IS:\n\n");
for(i=0;i<n;i++) printf("%5.0f\n",x[i]);
printf("\nNOS IN DECSCENDING ORDER IS:\n\n");
for(i=n-1;i>=0;i--) printf("%5.0f\n",x[i]);
getch();
}

