/*-----------FINDING 2ND SMALLEST & 2ND LARGEST DIGITS----------*/

#include<stdio.h>
void main()
{
int n,m,k,l1=0,l=0,s=9,s1=9;
clrscr();
printf("Enter number:\n");
scanf("%d",&n);
k=n;

while(n)
{	m=n%10;
	n/=10;
     l=(l1=m>l?l : m>l1&&m!=l?m:l1)==l?m:l;
     s=(s1=m<s?s : m<s1&&m!=s?m:s1)==s?m:s;
}

if(k==0)
{	printf("\nThe smallest & largest digit is 0\n");
	printf("\nNo 2nd largest & 2nd smallest digits:\n");
}
else
{    printf("\nSmallest digit=%d\n",s);
	printf("\nLargest digit=%d\n",l);
     if(l==s)printf("\nNO 2ND LARGEST & 2ND SMALLEST DIGITS:\n");else
	{ printf("\nThe 2nd smallest digit=%d\n",s1);
	  printf("\nThe 2nd largest digit=%d\n",l1);
     }
}

getch();
}