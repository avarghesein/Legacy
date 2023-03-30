#include<stdio.h>
#include<math.h>
void main()
{
int i,n,c,s;
float x2,y2,xy,mx,my,x[20],y[20],cov,vx,vy,a1,a2,b1,b2,v,r;
clrscr();

printf("Enter no of observations:\n");
scanf("%d",&n);
printf("Enter Xi':s,Yi:'s one by one:\n");
for(x2=y2=xy=mx=my=i=0;i<n;i++)
 {	scanf("%f%f",&x[i],&y[i]);
	x2+=x[i]*x[i];
     y2+=y[i]*y[i];
     xy+=x[i]*y[i];
     mx+=x[i];my+=y[i];
 }
mx/=n;my/=n;
cov=(xy/n)-(mx*my);
vx=(x2/n)-(mx*mx);
vy=(y2/n)-(my*my);
if(vx==0||vy==0)
	{	printf("\nDATA IS INCORRECT:\nVARIENCE OF X OR Y=0:\nDIVISION BY ZERO:\n");
    		getch();
		exit();
	}
a1=cov/vx;b1=my-(cov*mx/vx);
a2=cov/vy;b2=mx-(cov*my/vy);
r=cov/(sqrt(vx)*sqrt(vy));
printf("\n\nEQUATION Y ON X IS Y=%f*X+(%f)",a1,b1);
printf("\n\nEQUATION X ON Y IS X=%f*Y+(%f)",a2,b2);
printf("\n\nCORRELATION COEFFICIENT IS %f",r);
do
 {
	printf("\n\n\nTO CALCULATE 'Y' FOR A VALUE OF 'X' ENTER 0:");
     printf("\n\nTO CALCULATE 'X' FOR A VALUE OF 'Y' ENTER 1:");
     printf("\nALSO ENTER THE VALUE:\n");
     scanf("%d%f",&c,&v);
     switch(c)
	     {	case 0:printf("\nY=%f",a1*v+b1);
                 	break;
     		case 1:printf("\nX=%f",a2*v+b2);
                 	break;
          	default:printf("\nError in entering 'c':");
     	}
     printf("\n\nDo you want to continue:(Enter 1 for yes):\n");
     scanf("%d",&s);
 }
while(s==1);

}


