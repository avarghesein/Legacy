#include"\tc\bin\ds\inc\pqueue.c"

void main()
{

pqueue x;
int    w=1,p;
char   c;

clrscr();

setpqueue(&x);

while(w!=4)
{
printf("\n\nEnter 1-pins,2-pdel,3-pdisp,4-exit:");
scanf("%d",&w);
	switch(w)
	{	case 1:printf("\n\nEnter charecter to insert & priority:");
			   flushall();
			   scanf("%c%d",&c,&p);

			   pins(c,p,&x);
			   break;
		case 2:printf("\n\nItem deleted is %c",pdel(&x));
			   break;
		case 3:clrscr();
			   pdisp(&x);
			   break;
		case 4:break;
		default:printf("Error in choice");
				getch();


	}
}
}