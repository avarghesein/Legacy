

#include<stdio.h>
#include<conio.h>



void main()
{
char *x[]={"i am abraham","u r fool","key my","dont try"};
char **p;
p=x;
clrscr();
printf("%d %d %d %d %d %d\n\n\n",sizeof(x),sizeof(*x),sizeof(**x),sizeof(p),sizeof(*p),sizeof(**p));
printf("\n%s",++*p),printf("\n%s",*p++),printf("\n%s",++*p),getch();
}