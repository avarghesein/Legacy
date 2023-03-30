
#include "\tc\bin\ds\inc\pretopos.c"

void main()
{
char x[50],y[50];
clrscr();

	printf("\nEnter postfix string:"),flushall();
	scanf("%s",x);
	if(posttopre(x,y))
		printf("\n\tcorresponding prefix=%s",y);
	else
		printf("\n\tError in entered expression");

	getch();
}