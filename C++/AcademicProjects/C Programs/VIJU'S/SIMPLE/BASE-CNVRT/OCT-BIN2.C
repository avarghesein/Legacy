#include<stdio.h>
void main()
{ long int n,s,i,eo,j,m,k,o;
clrscr();
printf("enter the octal no: ");
scanf("%ld",&n);
for(s=n,i=1,eo=0;s>0;s/=10,i*=1000)
{
	for(j=1,o=0,k=s%10;k>0;k/=2,j*=10)
	{	m=k%2;
		o+=(m*j);
	}
	eo+=(o*i);
}
printf("The binary of the octal no %ld is %ld",n,eo);
getch();
}
