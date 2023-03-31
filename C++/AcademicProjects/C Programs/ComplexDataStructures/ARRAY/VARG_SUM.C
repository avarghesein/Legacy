

#include<stdarg.h>

int findsum(char*, ...);

void main()
{
int a,b,c,d;
clrscr();

	printf("\n\nEnter 4 numbers:"),scanf("%d%d%d%d",&a,&b,&c,&d);
	a=findsum("sum is %d",a,b,c,d,-999);
	printf("\n\ntotal=%d",a);
	getch();
}



int findsum(char *x,...)
{
int y=0,k;
va_list p;

	va_start(p,x);

	while((k=va_arg(p,int))!=-999) y+=k;

	printf(x,y);
	va_end(p);

	return(y);
}
