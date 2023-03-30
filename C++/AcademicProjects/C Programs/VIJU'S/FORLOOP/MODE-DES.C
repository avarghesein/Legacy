#include<stdio.h>
void main()
{
int i,j,n,p,k,c;
float x[20];
clrscr();
printf("Enter number of numbers:\n");
scanf("%d",&n);
printf("Enter the observations:\n");
for(i=0;i<n;i++) scanf("%f",&x[i]);

for(k=i=0;i<n;i++)
{	for(c=j=0;j<n;j++)
		if(x[i]==x[j])
          	c++;

	if(c>k)
     {	p=i;
     	k=c;
     }
}
if(n!=1&&k==1)printf("\n\nThere is no MODE:");
else printf("\n\nThe MODE of the observations is %f",x[p]);
getch();
}