#include<stdio.h>
void main()
{
void extern change(int*,int*);
int x,y;
clrscr();
printf("Enter x & y:\n");
scanf("%d%d",&x,&y);
printf("\n\n(old) x=%d & y=%d",x,y);
change(&x,&y);
printf("\n\n(new) x=%d & y=%d",x,y);
getch();
}
void change(int *x,int *y)
{
int t;
t=*x;
*x=*y;
*y=t;
return;
}
