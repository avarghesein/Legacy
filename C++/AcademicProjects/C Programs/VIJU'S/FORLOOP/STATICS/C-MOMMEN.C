#include<stdio.h>
#include<math.h>
void main()
{
  double x[25],y[25],z[25],f[25];
  double v,s,tf,me,sd,cv,p,k;
  int n,i,y1,l,j,r,o;
  clrscr();
  printf("Enter no of classes(Exclusive or Inclusive):");
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
  printf("The Mean=%lf\nstandard-deviation=%lf\nc.v=%lf",me,sd,cv);
  printf("\n\nDo you want to calculate CENTRAL-momments\nType 1 for YES/ 0 for NO:\n");
  scanf("%d",&y1);
  if(y1==1)
    {
        l:
        printf("\nEnter 'r' for the 'r'th CENTRAL momment:\n");
        scanf("%d",&r);
        for(s=i=0;i<n;i++)
           {
		    for(p=1,j=1;j<=r;j++) p*=(x[i]-me);
              s+=f[i]*p;
            }
        printf("\n\nThe %dth CENTRAL MOMMENT is %lf",r,s/tf);
        printf("\nDo you want to find momments again(1 for YES/ 0 for NO):\n");
        scanf("%d",&o);
        if(o==1) goto l;
      }

}


