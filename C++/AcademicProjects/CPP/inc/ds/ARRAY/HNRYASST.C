

#include"\tc\bin\ds\inc\hungary.c"

void main()
{
tp x;
clrscr();

	freadaptable(&x);
	hungarian_asst(&x);
	printaptable(&x);

getch();
}