#include<stdio.h>
void main()
{
long int n,s,i,d,b,m;
clrscr();
printf("Enter the octal no");
scanf("%ld",&n);
for(s=n,i=1,d=0;s>0;s/=10,i*=8)
	{m=s%10;
	d+=m*i;
	}
for(s=d,i=1,b=0;s>0;s/=2,i*=10)
	{m=s%2;
	b+=m*i;
	}
printf("The binary eqvalent of the octal %ld is  %ld",n,b);
getch();
}