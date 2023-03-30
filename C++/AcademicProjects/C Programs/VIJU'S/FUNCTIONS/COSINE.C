/*-----COSINE SERIES COSX=1-X^2/2!+X^4/4!-X^6/6!+....ETC----------*/

#include<stdio.h>
#include<math.h>
void main()
{int n;
float a,x,s;
   float co(float,int);
   clrscr();
printf("Enter the no of terms & Angle:\n");
scanf("%d%f",&n,&a);
x=a*(3.141519/180);
s=co(x,n);
printf("The sum of cosine series=%f",s);
printf("\n\nActual value by COS function=%f",cos(x));
getch();
}



float co(float x1,int n1)
{
int i,j,fa,si=1;
float po=1,sum=0;
for(i=0;i<n1;i++)
{	for(fa=1,j=1;j<=2*i;j++) fa*=j;
	sum+=(si*po)/fa;
     si*=-1;
     po*=x1*x1;
}
return(sum);
}

