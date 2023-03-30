
#include  "\tc\bin\ds\inc\lnkarray.c"


void main()
{
int w=1,head=-1,p;

clrscr();

while(w!=-999)
{
	printf("\nEnter-number,-999 if last:"),scanf("%d",&w);
	if(w!=-999)
	{	p=getnode();
		if(p!=-1)
			setnode(p,w),node[p].next=head,head=p;
	}
}
clrscr();

display(head);

while(head!=-1) p=node[head].next,freenode(head),head=p;
printf("\n\n\tHead=%d",head);
getch();
}