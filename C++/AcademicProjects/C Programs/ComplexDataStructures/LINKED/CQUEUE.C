/*-------------QUEUE & STACK USING  CIRCULAR LINKED LIST------------------*/



#include"\tc\bin\ds\inc\link\circular.c"


void main()
{

item nam;
int w=1;
node head=0,back=0;
clrscr();

while(w!=5)
{
printf("\n\n1-insfront,2-ins back,3-del,4-disp,5-exit:");
scanf("%d",&w);
switch(w)
	{
	case 1:acceptvalue(&nam);
		   head=cinsfront(head,nam);
		   if(back==0) back=head;
		   break;
	case 2:acceptvalue(&nam);
		   back=cinsback(back,nam);
		   if(head==0) head=back;
		   break;
	case 3:nam=cdelfront(&head);
		   printf("\nDeleted item=%d",nam.no);
		   if(head==0) back=head;
		   break;
	case 4:cdisp(head);
		   break;
	case 5:break;
	default:printf("\nError in choice");
	}

}
free(head);
}

