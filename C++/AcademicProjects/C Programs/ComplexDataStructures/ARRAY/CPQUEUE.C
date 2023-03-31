
//-----------circular priority queue-------------//

#include"\tc\bin\ds\inc\cpqueue.c"

void main()
{

cpqueue x;
int    w=1,p;
char   c;

clrscr();

SET(x,-1);

while(w!=4)
{
printf("\n\nEnter 1-pins,2-pdel,3-pdisp,4-exit:");
scanf("%d",&w);
	switch(w)
	{	case 1:printf("\n\nEnter charecter to insert & priority:");
			   flushall();
			   scanf("%c%d",&c,&p);

			   cpins(&x,c,p);
			   break;
		case 2:printf("\n\nItem deleted is %c",cpdel(&x));
			   break;
		case 3:clrscr();
			   cpdis(&x);
			   break;
		case 4:break;
		default:printf("Error in choice");
				getch();


	}
}
}
