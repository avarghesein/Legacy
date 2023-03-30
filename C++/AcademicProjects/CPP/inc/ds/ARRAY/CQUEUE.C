#include"\tc\bin\ds\\inc\queue.c"

void main()
{
queue x;
int w=1;
char c;
x.f=x.r=-1;
clrscr();
while(w!=4)
{
printf("\n\nEnter 1-cins,2-cdel,3-dis,4-exit:");
scanf("%d",&w);
	switch(w)
	{	case 1:printf("\n\nEnter charecter to insert:");
			   flushall();
			   scanf("%c",&c);

			   cins(c,&x);
			   break;
		case 2:printf("\n\nItem deleted is %c",cdel(&x));
			   break;
		case 3:clrscr();
			   cdis(&x);
			   break;
		case 4:break;
		default:printf("Error in choice");
				getch();


	}
}
}