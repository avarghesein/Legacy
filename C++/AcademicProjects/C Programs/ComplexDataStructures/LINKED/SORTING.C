
#include"\tc\bin\ds\inc\link\linear.c"

void main()
{
item nam;
int w=1,key;
node head=0,back=0;
clrscr();

while(w!=9)
{
printf("\n\n1-fins,2-bins,3-fdel,4-insnode,5-delnode,");
printf("6-sort,7-disp,8-sortins,9-exit:");
scanf("%d",&w);

if(w==1||w==2||w==4||w==5||w==8)
	switch(w)
	{
	 case 1:case 2:case 8:
		   acceptvalue(&nam);
		   break;
	 case 4:
		   acceptvalue(&nam),printf("\nEnter key for insert:");
		   scanf("%d",&key);
		   break;
	 default:
		   printf("\nEnter key for delete:");
		   scanf("%d",&key);
	}

switch(w)
	{
	 case 1:head=insfront(head,nam);
		   if(back==0) back=head;
		   break;
	 case 2:back=insback(back,nam);
		   if(head==0) head=back;
		   break;
	 case 3:
		   nam=delfront(&head);
		   printf("\n\nDeleted item=%d",nam.no);
		   if(head==0) back=head;
		   break;
	 case 4:head=insnode(head,key,nam);
		   if(back==0) back=head;
		   break;
	 case 5:head=delnode(head,key);
		   if(head==0) back=head;
		   break;
	 case 6:sort(head);break;
	 case 7:disp(head);break;
	 case 8:head=sortins(head,nam);
			if(back==0) back=head;
			break;
	 case 9:break;
	 default:printf("\n\nError in choice:");
	}

}



free(head);
}

