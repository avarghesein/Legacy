

#include"\tc\bin\ds\inc\link\dcircle.c"

void main()
{
int w=1,key;
node head=0,back=0;
item x;
clrscr();

while(w!=8)
{
printf("\n\n1-insf,2-insb,3-delf,4-delb,5-ins,6-del,7-disp,8-exit:");
scanf("%d",&w);
switch(w)
{
	case 1:acceptvalue(&x);
		   head=cinsfront(head,x);
		   if(back==0) back=head;
		   break;
	case 2:acceptvalue(&x);
		   back=cinsback(back,x);
		   if(head==0) head=back;
		   break;
	case 3:x=cdelfront(&head);
		   if(head==0) back=head;
		   printf("\n\nItem deleted=%d",x.no);
		   break;
	case 4:x=cdelback(&back);
		   if(back==0) head=back;
		   printf("\n\nItem deleted=%d",x.no);
		   break;
	case 5:acceptvalue(&x);
		   printf("\nEnter key item:"),scanf("%d",&key);
		   head=cinsbefore(head,key,x);
		   if(back==0&&head!=0) back=head;
		   break;
	case 6:printf("\nEnter key item to delete:"),scanf("%d",&key);
		   head=cdelnode(head,key);
		   if(head==0) back=head;
		   break;
	case 7:clrscr();
		   cdisplay(head);
		   break;
	case 8:break;
	default:printf("\n\n\tError in choice");
}
}
free(head);
}


