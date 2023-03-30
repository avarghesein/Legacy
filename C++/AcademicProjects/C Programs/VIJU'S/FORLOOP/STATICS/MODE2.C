#include<stdio.h>
#include<math.h>
void main()
{  int n,i,j;
   double y[25],z[25],f[25],mo;
   clrscr();
printf("Enter no of classes:\n");
scanf("%d",&n);
printf("Enter classes & freqencies:\n");
printf("Low,Upp,Fi's:\n\n");
for(i=1;i<=n;i++) scanf("%lf%lf%lf",&y[i],&z[i],&f[i]);
i=1;
while(i<=n)
{	for(j=1;j<=n;j++) if(f[i]<f[j]) break;
     if(j==n+1)
     { 	mo=y[i]+((z[i]-y[i])*(f[i]-f[i-1])/(2*f[i]-f[i+1]-f[i-1]));
          break;

     }
     else i++;
}
printf("\n\nMODE=%lf",mo);
getch();
}