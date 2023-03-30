#include"\tc\bin\ds\\inc\queue.c"

void main()
{
queue x;
int w=1;
char c;
x.f=x.r=-1;
clrscr();
while(w!=6)
{
printf("\n\nEnter 1-rins,2-lins,3-rdel,4-ldel,5-disp,6-exit:");
scanf("%d",&w);
	switch(w)
	{	case 1:printf("\n\nEnter charecter to right insert:");
			   flushall();
			   scanf("%c",&c);
			   ins(c,&x);
			   break;

		case 2:printf("\n\nEnter charecter to left insert:");
			   flushall();
			   scanf("%c",&c);
			   leftins(c,&x);
			   break;

		case 3:printf("\n\nItem deleted from right is %c",rightdel(&x));
			   break;
		case 4:printf("\n\nItem deleted from left is %c",del(&x));
			   break;
		case 5:clrscr();
			   cdis(&x);
			   break;
		case 6:break;
		default:printf("\n\tERROR in choice,press any key");
				getch();

	}
}
}