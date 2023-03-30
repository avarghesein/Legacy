/*-------------SORTING A LINKED LIST------------------*/
#include<stdio.h>
#include<stdlib.h>

typedef struct list
{	int no;
	struct list *po;
}node;

void main()
{
extern void disp(node*),sort(node*);
extern node *create(node*);
int w=1;
node *head=0;
clrscr();

while(w!=4)
{
printf("\n\n1-ins,2-sort,3-disp,4-exit\n");
scanf("%d",&w);
switch(w)
	{
	case 1:head=create(head);
		   break;
	case 2:sort(head);
		   break;
	case 3:disp(head);
	}

}
free(head);
}

node *create(node *head)
{
node *newhead=head;
if(head==0)
	{	head=(node*)malloc(sizeof(node));
		printf("\nEnter number:\n");
		scanf("%d",&head->no);
		head->po=0;
		return(head);
	}
else
	{	while(head->po!=0) head=head->po;
		head->po=(node*)malloc(sizeof(node));
		printf("\nEnter number:\n");
		scanf("%d",&head->po->no);
		head->po->po=0;
		return(newhead);
	}
}

void sort(node *head)
{
node *newhead=head;
int t;
while(head!=0)
{
	if(newhead->no>head->no)
		t=head->no,head->no=newhead->no,newhead->no=t;
	head=head->po;
}
if(newhead==0) return;
else sort(newhead->po);
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