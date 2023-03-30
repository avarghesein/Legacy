#include"\tc\bin\viju's\sourse\statfuns.c"

void main()
{  int i,j,m,n;
   double x1[25],x2[25],x[25],y1[25],y2[25],y[25],f[25][25];
   double f1,f2,fx,fy,fx2,fy2,fxy1,fxy2,p1,p2,p3,p4;

clrscr();
printf("Enter no of classes of 'X' & 'Y' resp :\n");
scanf("%d%d",&n,&m);

printf("\nEnter classes for 'X':\n");
readclass1(n,x1,x2);
printf("\nEnter classes for 'Y':\n");
readclass1(m,y1,y2);

printf("\nFrequencies:\n");
for(j=1;j<=m;j++)
for(i=1;i<=n;i++)
	scanf("%lf",&f[j][i]);

exclusive(n,x1,x2,x);
exclusive(m,y1,y2,y);

f1=fy=fy2=fxy1=fxy2=f2=fx=fx2=0;
for(j=1;j<=m;j++)
for(i=1;i<=n;i++)
{    f1+=f[j][i];
	 fy+=y[j]*f[j][i];
	 fy2+=y[j]*y[j]*f[j][i];
	 fxy1+=y[j]*x[i]*f[j][i];
}
for(i=1;i<=n;i++)
for(j=1;j<=m;j++)
{	 f2+=f[j][i];
	 fx+=x[i]*f[j][i];
	 fx2+=x[i]*x[i]*f[j][i];
	 fxy2+=x[i]*y[j]*f[j][i];
}
if(f1==f2 && fxy1==fxy2)
{
p1=(fxy1/f1)-((fx*fy)/(f1*f2));
p2=(fx2/f1)-((fx*fx)/(f1*f1));
p3=(fy2/f2)-((fy*fy)/(f2*f2));
p4=p1/(sqrt(p2*p3));
printf("\nThe CORRELATION-COEFFICIENT is,i.e 'r'=%lf",p4);
} else printf("The data that you entered is INCORRECT:\n");
getch();
}

