#include"\tc\bin\ds\inc\tp_prblm.c"

void main()
{
tp x;
clrscr();

	readtptable(&x);
	vam_method(&x);
	printtptable(&x);

getch();
}