
#include "\tc\bin\ds\inc\pretopos.c"

void main()
{
char x[50];
clrscr();

	printf("\nEnter infix string:"),flushall();
	scanf("%s",x);
	clrscr();
	printf("\n\nEntered expreession\n\n  %s",x);
	if(compact_commas(x))
		printf("\n\ncorresponding infix\n\n  %s",x);
	else
		printf("\n\tError in entered expression");

	getch();
}