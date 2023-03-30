
#include<stdio.h>
#include<conio.h>
#include<string.h>
#include<stdlib.h>

//--PTR is function pointer, and can hold the address
//--of a function  that returns a char pointer and
//--takes two int arguments--//

typedef char* (*PTR) (int,int);

//------------------------------------------//

char *Fun(int a,int b)
{
  int c,i,k;
  char tmp[100],*p;
  for(c=a+b,i=-1;c>0;k=c%10,c/=10,tmp[++i]=(char)(48+k));
  for(p=(char*)malloc(i+1),k=-1;i>=0;p[++k]=tmp[i],i--);
  p[++k]='\0';return p;
}

void main()
{
 PTR x,y;
 clrscr();
 x=(PTR) &Fun;
 y=(PTR)  Fun;
 printf("\n\n\n%s\n\n%s\n\n%s",x(3,3),(*x)(100,100),x(3,4));
 getch();
 printf("\n\n\n%s\n\n%s\n\n%s",y(3,3),(*y)(50,14),y(3,4));
 getch();
}


