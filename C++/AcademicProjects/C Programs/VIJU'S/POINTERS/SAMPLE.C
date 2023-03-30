/*----------The problem is self explanatory, if the first variable
in a assignement is a pointer type compiler automatically
considering the address not the value at that address & if second one is
pointer type it consider the value at that address
ex:*a=*b,it causes to pass the value at address b to the address a:-------*/

#include<stdio.h>
void main()
{
void ex(int *,int *);
int x=100,y=200;
clrscr();
printf("Before:x=%d  y=%d\n\n",x,y);
printf("\naddress:x=%d  y=%d",&x,&y);
ex(&x,&y);
printf("\nAfter:x=%d  y=%d\n\n",x,y);
printf("\nAddress:x=%d  y=%d",&x,&y);
getch();
}
void ex(int *a,int *b)
{	int t;
     /*---passess content of a to t----------*/
     t=*a;
     /*----passess value of b to address a---*/
	*a=*b;
     /*----passess t to the address b--------*/
     *b=t;


}