
#include "\tc\bin\ds\inc\pretopos.c"

void main()
{
char x[50],y[50];
clrscr();

	printf("\nEnter postfix string:"),flushall();
	scanf("%s",x);
	if(posttoin(x,y))
		compact_commas(y),printf("\n\tcorresponding infix=%s",y);
	else
		printf("\n\tError in entered expression");

	getch();
}