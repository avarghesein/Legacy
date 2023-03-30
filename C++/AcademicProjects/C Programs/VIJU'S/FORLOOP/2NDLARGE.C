#include<stdio.h>
void main()
{
int i,l,l1,s,s1,n,x[20];
clrscr();
printf("Enter number of numbers:");
scanf("%d",&n);
printf("\nEnter numbers\n");
for(i=0;i<n;i++) scanf("%d",&x[i]);
l1=s1=l=s=x[0];

for(i=1;i<n;i++)
{
	if(x[i]<s)
	{	s1=s;
		s=x[i];
	}
	else if(s1==s && x[i]>s1) s1=x[i];
	else if(x[i]<s1 && x[i]!=s) s1=x[i];

	if(x[i]>l)
	{	l1=l;
		l=x[i];
	}
	else if(l1==l && x[i]<l1) l1=x[i];
	else if(x[i]>l1 && x[i]!=l) l1=x[i];
}
printf("\nLargest=%d\t2nd largest=%d",l,l1);
printf("\n\nSmallest=%d\t2nd smallest=%d",s,s1);
getch();
}