/*---------ACCESSING FUNCTION THROUGH POINTERS (*f)()---------*/
#include<stdio.h>
#include<math.h>
void main()
{
void extern table(double(*)(),double,double,double);
double extern y(double);
double a,b;
clrscr();
printf("Enter starting & ending points\n");
scanf("%lf%lf",&a,&b);
printf("\n-------------------------------");
printf("\n\nTable of y(x)=2*X*X-X+1");
table(y,a,b,.5);
printf("\n\nTable for cos(x):");
table(cos,a,b,.5);
getch();
}
void table(double (*f)(),double a,double b,double inc)
{
double val;
double l;
printf("\n\n\n");
for(l=a;l<=b;l+=inc)
{
val=(*f)(l);
printf("%lf\t%lf\n",l,val);
}
return;
}

double y(double l)
{
return(2*l*l-l+1);
}
