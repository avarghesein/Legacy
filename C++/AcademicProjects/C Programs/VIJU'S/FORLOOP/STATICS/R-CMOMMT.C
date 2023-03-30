#include<stdio.h>
#include<math.h>
void main()
{
 double x[25],y[25],z[25],f[25],u[25];
 double v,s,tf,me,sd,cv,p,k,ur,h,si;
 int n,i,y1,l,j,r,o,a,m;
 clrscr();
 printf("Enter no of classes(Exclusive):");
 scanf("%d",&n);
 printf("\n\nEnter classes & freqencies:");
 printf("\n\nLow,Upp,Fi's:\n\n");
 for(i=0;i<n;i++) scanf("%lf%lf%lf",&y[i],&z[i],&f[i]);
 for(v=s=tf=i=0;i<n;i++)
 {    k=(y[i+1]-z[i])/2;
      y[i]-=k;z[i]+=k;
      x[i]=(y[i]+z[i])/2;
	 s+=x[i]*f[i];
	 tf+=f[i];
      v+=f[i]*x[i]*x[i];
 }
 me=(s/tf);sd=sqrt((v/tf)-(me*me));cv=(sd/me)*100;
 printf("The Mean=%lf\nstandard-deviation=%lf\nc.v=%lf\nVarience=%lf",me,sd,cv,sd*sd);
 printf("\n\nDO you like to find CENTRAL-momments by ROW-momments(1=yes/0=no):\n");
 scanf("%d",&y1);
 if(y1==1)
     { b:
       printf("Enter the ARBITARARY value 'a'& 'r' for the 'r'th RAW-momments:\n");
       scanf("%lf%d",&a,&r);
       for(j=0;j<=r;j++)
             for(u[j]=i=0;i<n;i++)
                 { for(p=1,k=0;k<j;k++) p*=(x[i]-a);
                   u[j]+=p*f[i];
                 }
       for(j=0;j<=r;j++) u[j]/=tf;
       for(j=0;j<=r;j++)
          { printf("Row Momment U%d'=%lf",j,u[j]);
            printf("\n\nDo you want to see next raw momment(1=YES)");
            scanf("%d",&y1);
            if(y1==0) break;
          }
       for(r=r;r>=0;r--)
          {
              for(ur=j=0,si=1;j<=r;j++)
                 { for(p=1,k=r,m=0;m<j;k--,m++) p*=k;
                   if(j==0) l=p;
                   else for(l=k=1;k<=j;k++) l*=k;
                   h=p/l;
                   for(s=1,k=0;k<j;k++) s*=u[1];
                   ur+=(h*s*si*u[r-j]);si*=(-1);
                 }
              printf("\n\nThe '%d'th  CENTRAL-momment , ie u%d= %lf",r,r,ur);
              printf("\nDo you want to see NEXT-CENTRAL-MOMMENT:(1=YES)\n");
              scanf("%d",&y1);
              if(y1==0) break;
          }
       printf("\n\nDo you want to continue to compute MOMMENTS?(1=yes/0=no)\n");
       scanf("%d",&j);
       if(j==1) goto b;
     }

}