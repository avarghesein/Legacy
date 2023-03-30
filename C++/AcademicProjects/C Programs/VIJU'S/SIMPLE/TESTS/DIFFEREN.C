
#define F(x,y) lne(((y))+(x))
#include "\tc\bin\viju's\sourse\calculas.c"




void main()
{
double x0,y0,x,h;
clrscr();
printf("Enter x0,y0,x,h:\n");
scanf("%lf%lf%lf%lf",&x0,&y0,&x,&h);
printf("\n\ny=%lf at x=%lf",eulerm(x0,y0,x,h),x);
printf("\n\ny=%lf at x=%lf",rkmethod(x0,y0,x,h),x);
printf("\n\ny=%lf at x=%lf",adems(x0,y0,x,h),x);
getch();
}


