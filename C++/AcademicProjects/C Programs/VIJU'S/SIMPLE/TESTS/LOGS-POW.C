#define X 888.00007755644588866
#define Y 0.0449793321445566778

#include<math.h>
#include"\tc\bin\viju's\sourse\mat.c"


void main()
{
clrscr();

printf("\n\n%lf^%lf=%lf , %lf , %lf",X,Y,power(X,Y),pow(X,Y),power(10,Y*loga(10,X)));
printf("\n\nLN(%lf)=%lf , %lf",X,lne(X),log(X));
printf("\n\nexp(%lf)=%lf , %lf",Y,e(Y),exp(Y));
printf("\n\nexp(ln %lf)=%lf , %lf",X,e(lne(X)),exp(log(X)));
printf("\n\nRounding %.10lf & %.10lf\n   <===> %lf & %lf"
,X,Y,fround(X,7),fround(Y,7));
printf("\n\nLog10(%lf)=%lf , %lf",5*X*Y,loga(10,5*X*Y),log10(5*X*Y));
printf("\n\n%lf^%lf=%lf , %lf",X,Y,e(Y*lne(X)),pow(X,Y));
getch();
}



