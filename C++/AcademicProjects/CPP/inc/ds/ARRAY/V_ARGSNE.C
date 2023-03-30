#include<stdarg.h>

int findmax(int num, ...);

void main()
{
int a,b,c,d;
clrscr();

	printf("\n\nEnter 4 numbers:"),scanf("%d%d%d%d",&a,&b,&c,&d);
	a=findmax(9,1,200,a,b,c,d,100,300,500);
	printf("\n\nMaximum=%d",a);
	getch();
}

int findmax(int num, ...)
{
int y,k,i;
va_list p;

	va_start(p,num);
	k=y=va_arg(p,int);
	printf("\n-%d-",k);
	i=2;
	while(i<=num)
	{
		i++,k=va_arg(p,int),printf("\n-%d-",k);
		if(k>y) y=k;
	}
	printf("\n\nMaximum=%d\n",y);
	va_end(p);
	return(y);
}
