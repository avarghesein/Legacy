

#include "\tc\bin\viju's\file\inchex.c"





void main(int argc,char *argv[])
{   clrscr();

	if(argc<2||argc>2) printf("\n\n\t\tError in command"),getch(),exit();

	opening1(argv[1],argv[1]);

	clrscr();
	printf("\n\n\n\tFORMAT CONVERSION OF %s IS SUCCESS",argv[1]);
	getch();
}


