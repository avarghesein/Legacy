#include "inc6.c"
void main()
{

int w=1,num,key;
node *head=0;
clrscr();

while(w!=5)
{
printf("\n\n1-ins,2-del,3-disp,4-create,5-exit\n");
scanf("%d",&w);
switch(w)
	{
	case 1: printf("\nEnter no ,key\n");
			scanf("%d%d",&num,&key);
			head=insert(head,num,key);
			break;
	case 2: printf("\nEnter key:\n");
			scanf("%d",&key);
			head=del(head,key);
			break;
	case 3:disp(head); break;
	case 4:head=create(head);break;

	}

}
free(head);
}

