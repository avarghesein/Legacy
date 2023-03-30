#include<stdio.h>
#include<math.h>
void main()
{ double n,i,h,m,s,o,fi,xi,zi,yi,a,u1,u2,u3,u4,k1,k2,k3,k4,c,y,p1,p2;
  clrscr();
  printf("Enter no of classes:& Arbitarary point: \n\n");
  scanf("%lf%lf",&n,&a);
  printf("Enter Class's(EXCLUSIVE) &  Freqencies\n\n");
  printf("LOW,UPP,Fi's\n\n");
  i=1;k1=k2=k3=k4=h=m=s=0;
  do
  { scanf("%lf%lf",&yi,&zi);
    c=zi-yi;
    scanf("%lf",&fi);
     xi=(yi+zi)/2;
  	o=xi*fi;h+=fi;m+=o*xi;
     s+=o;i++;
     p1=fi*(xi-a);
     p2=xi-a;
     k1+=p1;k2+=p1*p2;k3+=p1*p2*p2;k4+=p1*p2*p2*p2;
     } while(i<=n);
  xi=s/h;
  yi=sqrt((m/h)-(xi*xi));
  zi=(yi/xi)*100;
  k1=k1/h;k2=k2/h;k3=k3/h;k4=k4/h;
  u1=k1-k1;u2=k2-(k1*k1);u3=k3-(3*k2*k1)+(2*(k1*k1*k1));
  u4=k4-(4*(k3*k1))+(6*(k2*k1*k1))-(3*(k1*k1*k1*k1));
  printf("Are you want to apply correction factor(1 for yes)");
  scanf("%d",&y);
  if(y==1)
  {u4=u4-((c*c/2)*u2)+(7*(c*c*c*c)/240);u2=u2-((c*c)/12);}
  printf("\n\nRow Momments are:\n\nU1'=%lf,U2'=%lf,u3'=%lf,U4'=%lf",k1,k2,k3,k4);
  printf("\n\nCentral momments are:\n\nU1=%lf,U2=%lf,u3=%lf,U4=%lf",u1,u2,u3,u4);
  printf("\n\nThe mean is %lf \n\nThe std-deviation is %lf",xi,yi);
  printf("\n\nStandard-deviation from u2=%lf",sqrt(u2));
  printf("\n\nThe coefficient of varience(c.v) is %lf",zi);
  getch();
  }