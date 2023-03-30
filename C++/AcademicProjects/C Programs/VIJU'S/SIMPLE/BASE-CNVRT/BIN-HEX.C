#include<stdio.h>
void main()
{  long int n,s,i,j,p,h,k,d,m;
clrscr();
printf("Enter the binary no:");
scanf("%ld",&n);
printf("The hexa-decimal of binary %ld is =",n);
for(s=n,i=0;s>0;s/=10) i++;
j=i/4;
for(p=1,i=0;i<j;i++) p*=10000;
h=p;
for(s=n;p>0;p/=10000)
{ for(i=1,d=0,k=s/p;k>0;k/=10,i*=2)
  { m=k%10;
    d+=(m*i);
  }
  if(p==h && d==0)printf(""); else
  if(d==10)printf("A"); else
  if(d==11)printf("B"); else
  if(d==12)printf("C"); else
  if(d==13)printf("D"); else
  if(d==14)printf("E"); else
  if(d==15)printf("F"); else
  printf("%ld",d);
  s%=p;
  }
  getch();
  }