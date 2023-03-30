#include<stdio.h>
void main()
{  int i,j,n;
   float x[20],s,me,med,t;
   clrscr();
printf("Enter no of nos:\n");
scanf("%d",&n);
printf("Enter nos:\n");
for(i=0;i<n;i++)
{  scanf("%f",&x[i]);
   s+=x[i];
}
for(i=0;i<n-1;i++)
for(j=i+1;j<n;j++)
if(x[i]>x[j])
	{
       t=x[i];
       x[i]=x[j];
       x[j]=t;
      }
if(n%2!=0) med=x[((n+1)/2)-1]; else med=(x[(n/2)-1]+x[n/2])/2;
me=s/n;
printf("\nThe mean=%f\nThe median=%f",me,med);
getch();
}