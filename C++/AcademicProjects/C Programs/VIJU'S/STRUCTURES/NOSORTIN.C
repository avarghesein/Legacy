/*-------------Inserting numbers to proper position in the linked list----*/
#include<stdio.h>
#include<stdlib.h>

typedef struct list
{	int no;
	struct list *po;
}node;

void main()
{
extern void disp(node*);
extern node *sortcreate(node*);
int w=1;
node *head=0;
clrscr();

while(w!=3)
{
printf("\n\n1-ins,2-disp,3-exit\n");
scanf("%d",&w);
switch(w)
	{
	case 1:head=sortcreate(head);
		   break;
	case 2:disp(head);
	}

}
free(head);
}

node *sortcreate(node *head)
{
node *p1,*p2,*p;
int x;

printf("\nEnter number:\n");
scanf("%d",&x);
for(p1=head,p2=0;p1->no<x&&p1!=0;p1=p1->po) p2=p1;
p=(node*)malloc(sizeof(node));
p->no=x;
p->po=p1;
if(p2==0) head=p; else p2->po=p;

return(head);
}

void disp(node *head)
{
if(head==0) printf("List is empty:\n\n");
else
{   clrscr();
	printf("\nList Is:\n\n");
	while(head!=0)
	{	printf("<--%d",head->no);
		head=head->po;
	}
	printf("\n\n\n");
}
}