
typedef struct list
{	int no;
	struct list *po;
}node;



node *find(node *head,int key)
{	if(head->po->no==key) return(head);
	else
	if(head->po->po==0) return(0);
	else
	return(find(head->po,key));
}



node *insert(node *head,int num,int key)
{
node *n1,*n2;
if(head==0) printf("\nList is empty:\n"); else
if(head->no==key)
   n1=(node*)malloc(sizeof(node)),n1->no=num,n1->po=head,head=n1;
else if(head->po==0) printf("\nKey is not find:\n");
else
{	n1=find(head,key);
	if(n1==0) printf("\nKey not found:\n"); else
	   n2=(node*)malloc(sizeof(node)),n2->no=num,n2->po=n1->po,n1->po=n2;

}
return(head);
}



node *del(node *head,int key)
{
node *p,*n1;
if(head==0) printf("\nList is empty:\n"); else
if(head->no==key)	p=head->po,free(head),head=p;  else
if(head->po==0) printf("\n\nKey is not found:\n\n");
else
{	n1=find(head,key);
	if(n1==0) printf("\n\nKey is not found:\n");
	else
		p=n1->po->po,free(n1->po),n1->po=p;
}
return(head);
}



node *create(node *head)
{
node *newhead=head;
if(head==0)
	{	head=(node*)malloc(sizeof(node)),printf("\nEnter number:\n");
		scanf("%d",&head->no),head->po=0;
		return(head);
	}
else
	{	while(head->po!=0) head=head->po;
		head->po=(node*)malloc(sizeof(node));
		printf("\nEnter number:\n"),scanf("%d",&head->po->no);
		head->po->po=0;
		return(newhead);
	}
}



void disp(node *head)
{
if(head==0) printf("list is empty:\n\n");
else
{   clrscr(),printf("\nlist Is:\n\n");

	while(head!=0)
		printf("<-%d",head->no),head=head->po;

	printf("\n\n\n");
}
}