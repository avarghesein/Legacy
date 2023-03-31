


#include "\tc\bin\ds\tree\incbtree.c"





void main()
{
node head=0;
int num=0;
clrscr();

while(num!=-999)
{

	printf("\nEnter number,-999 for ending:"),scanf("%d",&num);
	if(num!=-999) head=insertinbtree(head,num),clrscr(),display(head);

}


}

