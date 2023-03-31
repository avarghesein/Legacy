


#include "\tc\bin\ds\tree\delbtree.c"


void main()
{
node head=0;
int num=0,flag=0;
clrscr();

while(num!=-999)
{

	switch(flag)
	{
	case 0:
	printf("\nEnter number,-888 for ending insert & to exit -999:");
	scanf("%d",&num);

	if(num!=-999&&num!=-888) head=insertinbtree(head,num),clrscr(),display(head);
	if(num==-888) flag=1;
	break;

	default:
	printf("\nEnter number,-888 for ending delete & to exit -999:");
	scanf("%d",&num);
	if(num!=-999&&num!=-888) head=deletebtree(head,num),clrscr(),display(head);
	if(num==-888) flag=0;
	}
}


}

