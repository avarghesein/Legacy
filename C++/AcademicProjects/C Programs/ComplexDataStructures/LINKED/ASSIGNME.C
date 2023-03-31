

#include"\tc\bin\ds\linked\asst2.c"

void main()
{
int w=1;
headlist head=0;
clrscr();

	while(w!=0)
	{	printf("\n\nEnter 1 to create a list,0 to exit:"),scanf("%d",&w);
		switch(w)
		{	case 0:break;
			case 1:head=createheaderlist(head);break;
			default:printf("\nError in choice");
		}
	}
	clrscr();
	displaylist(head);

getch();
}
