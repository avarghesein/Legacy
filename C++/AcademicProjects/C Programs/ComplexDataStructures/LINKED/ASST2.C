

typedef struct l
{	char c;
	struct l *p;
}
*linear;


typedef struct h
{	struct h  *l,*r;
	linear header;
}
*headlist;



linear makelinearnode(void)
{	return( (struct l*)malloc(sizeof(struct l)) ); }


headlist makeheadnode(void)
{	return((struct h*)malloc(sizeof(struct h)) );	}


linear insfront(linear head)
{
linear t;
char x;
	   printf("\nEnter the charecter to linear list:");
	   flushall(),scanf("%c",&x);
	   t=makelinearnode(),t->c=x,t->p=head;
	   return(t);
}

linear createlinearlist(void)
{
linear head=0;
int w=1;
	   clrscr();
	   while(w!=0)
	   {	printf("\nEnter 1 to insert a charecter,0 to exit:");
			flushall(),scanf("%d",&w);
			switch(w)
			{	case 0:break;
				case 1:head=insfront(head);break;
				default:printf("\nError in choice");
			}
	   }
return(head);
}


headlist createheaderlist(headlist head)
{
headlist keep,t;

	if(head==0)
		t=makeheadnode(),t->l=t->r=t;
	else
		keep=head->l,t=makeheadnode(),
		t->r=head,t->l=head->l,head->l=t,keep->r=t;

	t->header=createlinearlist();
	return(t);
}


void display(linear head)
{
if(head==0) printf("Empty linear list");
else
	while(head!=0) printf("<--%c",head->c),head=head->p;
return;
}


void displaylist(headlist head)
{
headlist temp;
int i=0;

if(head==0)
{	printf("\nEmpty header list");
	return;
}


temp=head;
do printf("\n\nlist %d is \n",++i),display(temp->header),temp=temp->r;
while(temp!=head);

return;
}