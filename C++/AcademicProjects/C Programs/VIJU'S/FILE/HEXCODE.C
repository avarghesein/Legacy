
#include "\tc\bin\viju's\file\inchex.c"

void main()
{
char x[25],y[25];

	clrscr();
	printf("\nEnter the file name with extension to format:");
	flushall(),scanf("%s",x);
	printf("\nEnter the file name with extension to save:");
	flushall(),scanf("%s",y);

	opening1(x,y);

	printf("\n\nSUCCESS IN  FORMAT CONVERSION,converted (%s)===>(%s)",x,y);

	getch();
}


