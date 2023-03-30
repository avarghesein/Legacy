#include"\tc\bin\viju's\sourse\bases.c"

/*-----program to convert a decimal to octal or binary including decimal
	   set M=1(for binary)----------------------------------*/


#define M 1

void main()
{
	double a,b,i,no,y;
	int x;
	clrscr();

	printf("Program to convert decimal to binary or octal\n");
	printf("\nDEFINE 1 for binary, any other value for octal:\n\n\n");

	#if(M==1)
	#define STG "BINARY"
	#define BASE +2
	#else
	#define STG "OCTAL"
	#define BASE +8
	#endif

	printf("\n\nEnter the decimal number:");
	scanf("%lf",&no);
	x=(int)(no),y=no-x;

	a=0,i=1;
	while(x>0)
	{	a+=(x%BASE)*i;
		i*=10;
		x/=BASE;
	}

	b=0.0,i=10;
	while(y!=0&&i<=1E15)
	{	b+=((int)(y*BASE))/i;
		i*=10;
		y=(y*BASE)-((int)(y*BASE));
	}

	clrscr();
	printf("\n\n\n\tEntered decimal number is %lf\n\n\n",no);
	printf("\tEquvalent "STG" is %lf",a+b);
	getch();
}




