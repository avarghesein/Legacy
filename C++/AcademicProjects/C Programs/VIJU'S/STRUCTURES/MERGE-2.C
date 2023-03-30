//-----merging 2 sorted linked-lists to one linked list----------//
//-------then deleting repeated numbers from the merged list-----//
#include<stdio.h>
#include<stdlib.h>

typedef struct list
{	int no;
	struct list *po;
}node;

node *head1=0,*head2=0,*head3=0;

void main()
{
extern void disp(node*,int),sort(node*);
extern node *create(node*);
extern node *shrink(node*),*merge(node*,node*),*reverse(node*);
clrscr();

printf("Enter numbers for 1st list");
head1=create(head1);

printf("Enter numbers for 1st list");
head2=create(head2);

clrscr();
sort(head1),sort(head2);
disp(head1,1),disp(head2,2);
getch();

head3=merge(head1,head2);

printf("Merged-List\n-----------");
disp(head3,3),getch();

head3=shrink(head3),printf("Shrinked-List\n-------------"),
disp(head3,4),getch();

printf("\nReversed list\n-------------"),
head3=reverse(head3),disp(head3,5),getch();
}

//----------------------------------------------------------------------//
node *create(node *head)
{
node *p=0;
int num;

printf("Enter numbers,-999 at last\n");
scanf("%d",&num);
while(num!=-999)
{	if(head==0)
		head=(node*)malloc(sizeof(node)),
		head->no=num,head->po=0,p=head;

	else
		head->po=(node*)malloc(sizeof(node)),
		head->po->no=num,head->po->po=0,head=head->po;

	scanf("%d",&num);
}
return(p);
}
//--------------------------------------------------------------------//
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
if(newhead==0)  return;	else sort(newhead->po);
}
//-------------------------------------------------------------------//
void disp(node *head,int i)
{
if(head==0) printf("List %d is empty:\n\n",i);
else
{
	printf("\nList %d Is:\n\n",i);
	while(head!=0)	printf("<--[%d]",head->no),head=head->po;
	printf("\n\n\n");
}
return;
}
//-------------------------------------------------------------------//
node *shrink(node *head)
{
node *headnew,*k,*t;
int x;
	headnew=k=head;
	while(k!=0)
	{	x=k->no,head=k->po;
		while(head->no==x&&head!=0) t=head,head=head->po,free(t);
		k->po=head,k=k->po;
	}
	return(headnew);
}
//-------------------------------------------------------------------------//
//-------------merging list 2 to list1 [ie head3=head1<****head2]---------//
//---------------HEAD3=HEAD1+[head2]---(normal case)---------------------//

node *merge(node *head1,node *head2)
{
node *t,*head3=0;
int f=0;
if(head1==0&&head2!=0) head3=head2; else
{	t=head3=head1;
	while(head2!=0&&head1!=0)
	{	if(f==0)
		{	if(head1->no>head2->no)
				t=head2->po,head2->po=head1,head1=head2,head2=t,head3=head1;
			 f=1;
		}
		else
		{   if(head1->po==0) break;
			if(head1->po->no<=head2->no) head1=head1->po;
			else
				t=head2->po,head2->po=head1->po,head1->po=head2,
				head2=t,head1=head1->po;
		}
	 }
	if(head2!=0)	head1->po=head2;
}

return(head3);
}
//------------------------------------------------------------------------//

node *reverse(node *current)
{
static node *prev=0;
node *next;
	if(current!=0)
		  next=current->po,current->po=prev,prev=current,reverse(next);
	return(prev);
}
//-------------------------------------------------------------------------//