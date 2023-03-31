
#include "\tc\bin\ds\inc\pretopos.c"

void main()
{
char x[50],y[50];
clrscr();

	printf("\nEnter prefix string:"),flushall();
	scanf("%s",x);
	if(pretopos(x,y))
		printf("\n\tcorresponding postfix=%s",y);
	else
		printf("\n\tError in entered expression");

	getch();
}