
/*-----program to convert  octal or binary to decimal including fractional
part, set M=1(for binary)----------------------------------*/


#define M 1.00

void main()
{   double a,b,i,no,y;
	long int x,m;
	int f;
	clrscr();

	printf("Program to convert binary or octal to decimal\n");
	printf("\nDEFINE 1 for binary, any other value for octal:\n\n\n");

	#if(M==1)
	#define STG "BINARY"
	#define BASE +2
	#else
	#define STG "OCTAL"
	#define BASE +8
	#endif


	printf("\n\nEnter the "STG" number:");
	scanf("%lf",&no);
	x=(long int)no,y=no-x;

	for(a=0,i=1;x>0;m=x%10,a+=m*i,i*=BASE,x/=10);

	for(b=0,i=BASE,f=1;f++<=10&&y!=0;
	m=(long int)(y*10),b+=(double)m/i,i*=BASE,y=(y*10)-m);

	printf("\n\n\n\tEntered "STG" number is %lf\n\n\n",no);
	printf("\tEquvalent decimal is %lf",a+b);
	getch();
}




