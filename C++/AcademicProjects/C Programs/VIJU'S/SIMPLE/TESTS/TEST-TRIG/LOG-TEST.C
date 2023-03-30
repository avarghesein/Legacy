//----checking the effficiencies of lne from mat.c from sourse,and
//--loge from math.h,from tc lib-------//
#include<math.h>
#include"\tc\bin\viju's\sourse\mat.c"
#define T .0000001
void main()
{

static double k,i,a,b,c,s,mx,my,vx,vy,cx,cy,sx,sy,x[100],y[100];
int flag=0;

clrscr();
printf("Enter range & step:\n");
scanf("%lf%lf%lf",&a,&b,&s);

if(a>b) k=a,a=b,b=k,s*=-1,flag=1;

for(c=0,i=a;i<=b;c++,i+=s) x[c]=lne(i),y[c]=log(i);

for(sx=sy=i=0;i<c;i++) sx+=x[i],sy+=y[i];
mx=sx/c,my=sy/c;

for(sx=sy=i=0;i<c;i++) sx+=x[i]*x[i],sy+=y[i]*y[i];
vx=(sx/c)-(mx*mx),vy=(sy/c)-(my*my);

cx=(SQRT(vx)/mx)*100;
cy=(sqrt(vy)/my)*100;

printf("\n\nC.V(lne)=%lf\tC.V(loge)=%lf\n\n",cx,cy);
printf("\n\nRESULT\n********");
if(abso(cx-cy)<=T)
   printf("\nMAT.C & MATH.H SIMILAR");       else
if(cx<cy)
	printf("\nX is more efficient,ie MAT.C"); else
	printf("\nY is more efficient,ie MATH.H");

getch();

printf("\n\n\nNUMBER        X=lne(MAT.C)\tY=loge(MATH.H)\n");
if(flag)  for(k=b,i=c-1;i>=0;i--,k-=s) printf("\n%lf\t%lf\t%lf",k,x[i],y[i]);
else      for(k=a,i=0;i<c;i++,k+=s) printf("\n%lf\t%lf\t%lf",k,x[i],y[i]);

getch();
}