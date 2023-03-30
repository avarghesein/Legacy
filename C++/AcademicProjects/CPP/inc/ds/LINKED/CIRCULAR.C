
#include"\tc\bin\ds\inc\link\circular.c"

void main()
{
item nam;
int w=1,key;
node head=0;
clrscr();

while(w!=5)
{
printf("\n\n0-sort,1-insnode,2-delnode,");
printf("3-disp,4-sortins,5-exit:");
scanf("%d",&w);

switch(w)
	{   case 0:csort(head);break;
		case 1:acceptvalue(&nam);
			   printf("\nEnter key for insert:");
			   scanf("%d",&key);
			   head=cinsert(head,key,nam); break;
		case 2:printf("\nEnter key for delete:");
			   scanf("%d",&key);
			   head=cdelete(head,key);   break;
		case 3:cdisp(head);break;
		case 4:acceptvalue(&nam);
			   head=csortinsert(head,nam);break;
		case 5:break;
		default:printf("\n\nError in choice:");
	}

}
free(head);
}

