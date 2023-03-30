#include<stdio.h>
#include<stdlib.h>

typedef struct list
{	int no;
	struct list *po;
}node;

void main()
{
extern void rprint(node*),print(node*);
node *rev(node*);
node *head=0,*end=0;
int num,choice=1;
clrscr();
printf("\nEnter numbers ,type -999 last:\n");
	scanf("%d",&num);
while(num!=-999)
{   if(head==0)
	{	end=head=(node*)malloc(sizeof(node));
		head->no=num;
		head->po=0;
	}
	else
	{	end->po=(node*)malloc(sizeof(node));
		end->po->no=num;
		end->po->po=0;
		end=end->po;
	}
	scanf("%d",&num);
}
while(choice!=4)
{	printf("\nEnter 1-reverse liked list,2-reverse print,3-print,4-exit:");
	scanf("%d",&choice);
	switch(choice)
	{ 	case 1: head=rev(head);break;
		case 2: printf("\n\n");
				rprint(head);
				printf("\n\n");
				break;
		case 3:print(head);
	}
}
}

void print(node *head)
{
if(head==0) printf("list is empty:\n\n");
else
{   clrscr();
	printf("\nlist Is:\n\n");
	while(head!=0)
	{	printf("<-%d",head->no);
		head=head->po;
	}
	printf("\n\n\n");
}
}
void rprint(node *head)
{
if(head!=0)
{	rprint(head->po);
	printf("<--%d",head->no);
}
else return;
}

node *rev(node *head)
{
node *prev=0,*curr=head,*next;
while(curr!=0)
{ 	next=curr->po;
	curr->po=prev;
	prev=curr;
	curr=next;
}
return(prev);
}