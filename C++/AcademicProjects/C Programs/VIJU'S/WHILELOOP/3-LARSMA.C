/*---------FINDING 3RD-LARGEST & SMALLEST DIGITS IN A NO:---------*/
/*---------BY USING THE CONDITIONAL OPERATORS ? AND :-------------*/
#include<stdio.h>
void main()
{
int l,l1,l2,n,m,k,s,s1,s2;
clrscr();
s=s1=s2=9;
l=l1=l2=0;
printf("Enter the number:\n\n");
scanf("%d",&n);

k=n;
while(n)
{	m=n%10;
	n/=10;
     l=(l1=(l2=m>l||m>l1&&m!=l?l1:m>l2&&m!=l1&&m!=l?m:l2)==l1?m>l?l:m:l1)
     ==l?m:l;
	s=(s1=(s2=m<s||m<s1&&m!=s?s1:m<s2&&m!=s1&&m!=s?m:s2)==s1?m<s?s:m:s1)
     ==s?m:s;
    printf("\n %d  %d  %d",l,l1,l2);
    printf("\t %d  %d  %d",s,s1,s2);
}
if(k==0) l2=s2=0;
else if(l==s1||s==l1||k/10==0)
{	l2=l1=s;
	s2=s1=l;
}

printf("\n\nThe 3rd largest digit is %d\n\n",l2);
printf("The 3rd smallest digit is %d",s2);
getch();
}