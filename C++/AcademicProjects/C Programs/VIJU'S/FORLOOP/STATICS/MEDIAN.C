#include<stdio.h>
#include<math.h>
void main()
{  int n,i,j,q,m;
   double y[25],z[25],f[25],c[25],tf,s,mo,p,d,k;
   char w;
clrscr();
printf("Enter no of classes(inclusive or exclusive):\n");
scanf("%d",&n);
printf("Enter classes & freqencies:\n");
printf("Low,Upp,Fi's:\n\n");
for(i=1;i<=n;i++) scanf("%lf%lf%lf",&y[i],&z[i],&f[i]);
for(tf=s=c[0]=0,i=1;i<=n;i++)
  {
      k=(y[i+1]-z[i])/2;
     y[i]-=k;z[i]+=k;
	c[i]=c[i-1]+f[i];
     tf+=f[i];
     s+=f[i]*(y[i]+z[i])/2;
  }

 do
 {
 printf("\nEnter 4,10,100 for find Quartiles,Deciles,Percentiles:\n");
 printf("\nAlso enter 'i' for 'i'th Quariles or Deciles ....e.t.c:\n");
 scanf("%d%d",&q,&m);
 p=(m*tf)/q;
 switch(q)
   {    	 case   4:w='Q'; break;
      	 case  10:w='D'; break;
           case 100:w='P'; break;
           default:w='n';
   }
 for(i=1;i<=n;i++)
     if(c[i]>p)
   	  {   d=y[i]+((z[i]-y[i])*(p-c[i-1])/f[i]);
		 break;
	  }
 printf("\nMEAN=%lf\n",s/tf);
 printf("\n%c%d=%lf",w,m,d);
 printf("\nDo you want to continue to find QUARTILES...e.t.c (YES=1):\n");
 scanf("%d",&i);
 } while(i==1);


}
