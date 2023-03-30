/*----------NEWTON INTERPOLATION FORMULA BACKWARD & FORWARD-----*/
#include "\tc\bin\viju's\sourse\calculas.c"

void main()
{

int i,j,k,flag,n,fix;
static float x[50],f[50][50],s,term,h,x0,y[50];

clrscr();

printf("\nEnter 1:FORWARD -1:BACKWARD interpolation:\n");
scanf("%d",&flag);
printf("\nEnter no of obs:\n");
scanf("%d",&n);
printf("\nXi's & then Fi's:\n");

if(flag==1)
{	for(i=0;i<n;i++) scanf("%f",&x[i]);
	for(i=0;i<n;i++) scanf("%f",&f[0][i]),y[i]=f[0][i];
}
else
{   for(i=n-1;i>=0;i--) scanf("%f",&x[i]);
	for(i=n-1;i>=0;i--) scanf("%f",&f[0][i]);
}

printf("Enter x:");
scanf("%f",&x0);

for(i=0;i<n;i++)
{	if(flag==1) if(x0<x[i]) break;
	if(flag==-1) if(x0>x[i]) break;
}

fix=(i==0?0:i-1);
h=(x0-x[fix])/(x[1]-x[0])*flag;
k=n-1;

for(i=1;i<n;i++,k--)
	for(j=0;j<k;j++) f[i][j]=(f[i-1][j+1]-f[i-1][j])*flag;

term=1;
for(i=0;i<n;i++)
s+=f[i][fix]*term,term*=(h-(i*flag))/(i+1);

printf("\n\n\n%f",s);
printf("\n\nFrom included function:%f",interpolation(x,y,n,x0));
getch();
}