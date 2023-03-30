#include<stdio.h>
void main()
{
long int s,n,i,p,k,h,m,o,j,l;
clrscr();
printf("enter the octal no");
scanf("%ld",&n);
printf("\nthe binary equvalent of the  octal number %ld is=",n);
s=n;p=1;
for(i=0;s>0;s/=10) i++;
for(k=1;k<i;k++) p*=10;
i=p; s=n;
for(;i>0;i/=10)
{	h=s/i;
	m=h;o=0;j=1;k=0;
	for(m=h;m>0;m/=2,j*=10)
	{ l=m%2;
	  o+=l*j;
	  k+=1;
	}
	for(;k<3;k++) printf("%d",0);
	if(o>0) printf("%d",o);
	if(i!=1) printf(",");
	s%=i;
}
getch();
}