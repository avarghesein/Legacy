/*---------------FINDING VALUE OF sinX=X-(X^3/3!)+(X^5/5!)-(X^7/7!)+...
......USING "RECCURSSION" OF FUNCTIONS-------------*/

#include<stdio.h>
#include<math.h>
void main()
{
extern float sineser(float,int);
int n;
float x,s;
clrscr();

printf("Enter the value of 'x' & no of terms:\n");
scanf("%f%d",&x,&n);
x*=(3.141519/180);
s=sineser(x,n-1);
printf("\nSine X=%f by using sine series:\n",s);
printf("\nSine X=%f by sine function:\n",sin(x));
getch();
}

/*--------FUNCTION FOR FINDING SINE SERIES--------------*/

float sineser(float x1,int n1)
{    extern float power(float,int);
	extern int fact(int),sign(int);

	if(n1==0) return(x1);
	else  return(sign(n1)*power(x1,2*n1+1)/fact(2*n1+1)+sineser(x1,n1-1));
}

/*---------FUNCTION FOR FINDING POWER OF 'X' IN EACH TERM--------*/

float power(float x2,int i2)
{
	if(i2==0) return(1);
	else return(x2*power(x2,i2-1));
}

/*---------FUNCTION FOR FINDING FACTORIALS IN TERMS---------*/

int fact(int i2)
{
	if(i2==0) return(1);
	else return(i2*fact(i2-1));
}

/*--------FUNCTION FOR FINDING THE SIGN OF THE TERMS----------*/

int sign(int i2)
{
	if(i2==0) return(1);
	else return(-1*sign(i2-1));
}