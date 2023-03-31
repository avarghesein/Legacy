

#include<stdarg.h>

int findmax(char*, ...);

void main()
{
int a,b,c,d;
clrscr();

	printf("\n\nEnter 4 numbers:"),scanf("%d%d%d%d",&a,&b,&c,&d);
	a=findmax("greatest is %d",a,b,c,d,-1);
	printf("\n\nMaximum=%d",a);
	getch();
}

int findmax(char *x, ...)
{
int y,k,i;
va_list p;

	va_start(p,x);
	k=y=va_arg(p,int);
	while(k!=-1)
	{
		k=va_arg(p,int);
		if(k>y) y=k;
	}
	printf(x,y);
	va_end(p);
	return(y);
}
