/*-------------STACK USING LINKED LIST------------------*/
#include<stdio.h>
#include<stdlib.h>

typedef struct list
{	int no;
	struct list *po;
}node;

void main()
{
extern void disp(node*);
extern node *del(node*),*create(node*);
int w=1;
node *head;
clrscr();

head=(node*)malloc(sizeof(node));
head->po=0;
while(w!=4)
{
printf("\n\n1-ins,2-del,3-disp,4-exit\n");
scanf("%d",&w);
switch(w)
	{
	case 1:head=create(head);
		   break;
	case 2:head=del(head);
		   break;
	case 3:disp(head);
	}

}
free(head);
}

node *create(node *head)
{
node *newhead;
printf("\nEnter number:\n");
newhead=(node*)malloc(sizeof(node));
scanf("%d",&newhead->no);
newhead->po=head;
return(newhead);
}

node *del(node *head)
{
node *newhead;
if(head->po==0)
	{	printf("\n\nQueue is empty:\n");
		return(head);
	}
else
	{
	printf("\n\nDeleted no %d\n",head->no);
	newhead=head->po;
	free(head);
	return(newhead);
	}
}

void disp(node *head)
{
if(head->po==0) printf("Queue is empty:\n\n");
else
{   clrscr();
	printf("\nQueue Is:\n\n");
	while(head->po!=0)
	{	printf("<-%d",head->no);
		head=head->po;
	}
	printf("\n\n\n");
}
}