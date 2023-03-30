#define X -PI/2.5
#define Y .5555
#include<math.h>
#include "\tc\bin\viju's\sourse\mat.c"

#define V1 -2.00000001
#define V2 2.00000001

void main()
{
double x=V1,y=V2,r=V1,t=V2;
double x1=V1,y1=V2,r1=V1,t1=V2;

clrscr();

printf("\n\nsin(%lf deg)  %lf,  %lf",X*180/PI,SIN(X),sin(X));
printf("\n\ncos(%lf deg)  %lf,  %lf",X*180/PI,COS(X),cos(X));
printf("\n\ntan(%lf deg)  %lf,  %lf",X*180/PI,TAN(X),tan(X));
/*printf("\n\nsinhi(%lf)=%lf",X,SINHI(X));
printf("\n\ncoshi(%lf)=%lf",5.0,COSHI(5));
printf("\n\ntanhi(%lf)=%lf",X,TANHI(X));
printf("\n\nsinh(%lf)=%lf,%lf",X,SINH(X),sinh(X));
printf("\n\ncosh(%lf)=%lf,%lf",X,COSH(X),cosh(X));
printf("\n\ntanh(%lf)=%lf,%lf",X,TANH(X),tanh(X));

getch();clrscr();

printf("\n\nsini(%lf)=%lf",X,SINI(X));
printf("\n\ncosi(%lf)=%lf",X,COSI(X));
printf("\n\ntani(%lf)=%lf",X,TANI(X));
printf("\n\ncoti(%lf)=%lf",X,COTI(X));

*/
topolar(&x,&y);
toxy(&r,&t);
printf("\n\nxy(%lf,%lf)=polar(%lf,%lf)",x1,y1,x,y*180/PI);
printf("\n\npolar(%lf,%lf)=xy(%lf,%lf)",r1,t1,r,t);
getch();

}