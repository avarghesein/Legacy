#include<stdio.h>
void main()
{
int a,b;
extern int gcd(int,int);
clrscr();

printf("Enter the 2 nos:\n");
scanf("%d%d",&a,&b);
if(a>b) printf("\nG.C.D=%d",gcd(a,b));
else printf("\nG.C.D=%d",gcd(b,a));
getch();
}

int gcd(int a1,int b1)
{
if(b1==0) return(a1);
else return(gcd(b1,a1%b1));
}








