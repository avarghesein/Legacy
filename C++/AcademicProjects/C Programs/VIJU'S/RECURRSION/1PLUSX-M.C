/*-----PROGRAM TO FIND (1+x)^m=mC0*x^0+mc1*x^1+mC2*x^2+.....BY RECURSSION OF
FUNCTIONS.THE SERIES WILL CONVERGE IFF |X|<1 AND |M|<1--------------------*/
/*------IF X & M HAVE THE SAME SIGN THEN WE WILL NOT CONSIDER THE
CONDITION |M|<1--------------------------------------*/

#include<stdio.h>
void main()
{	float extern sere(float,float,int);
	float x,m,r;
	int n;
	clrscr();

printf("Enter x,m & number of terms:\n\n");
scanf("%f%f%d",&x,&m,&n);
r=sere(x,m,n-1);
printf("\n\n(1+%f)^%f=%f",x,m,r);
getch();
}

float sere(float x1,float m1,int n1)
{	float extern ncr(float,int),pow(float,int);
	float s;

	if(n1==0) return(1);
	else s=ncr(m1-n1+1,n1)*pow(x1,n1)+sere(x1,m1,n1-1);

	return(s);
}

float ncr(float k,int l)
{	float fa;

	if(l==0) return(1);
	else fa=(k/l)*ncr(k+1,l-1);

	return(fa);
}

float pow(float k,int l)
{	float p;

	if(l==0)return(1);
	else p=k*pow(k,l-1);

	return(p);
}