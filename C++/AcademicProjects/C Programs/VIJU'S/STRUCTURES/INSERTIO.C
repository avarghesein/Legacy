#include<stdio.h>
#include<stdlib.h>

typedef struct list
{	int no;
	struct list *po;
}node;

void main()
{
node *h;
void create(node *),print(node *);
node *ins(node *);
clrscr();

h=(node *)malloc(sizeof(node));
create(h);
clrscr();

h=ins(h);

printf("\n\nThe Linked-List is:\n\n");
print(h);

getch();
free(h);
}

void create(node *p)
{
printf("Input a no:print -999 at end\n");
scanf("%d",&p->no);
if(p->no==-999)  p->po=0;
else
{	p->po=(node *)malloc(sizeof(node));
	create(p->po);
}
return;
}

void print(node *p)
{
if(p->po!=0)
{
	printf("%d->",p->no);
	if(p->po->po==0) printf("END");
	print(p->po);
}
return;
}

node *ins(node *p)
{
node *find(node *,int);
node *new1,*n1;
int key,x;

printf("Enter value to be insert & value of key item:\n");
printf("Enter -999 if at end:\n");
scanf("%d%d",&x,&key);
if(p->no==key)
{
	new1=(node *)malloc(sizeof(node));
	new1->no=x;
	new1->po=p;
	p=new1;
}
else
{	n1=find(p,key);
	if(n1==0) printf("Key not find:\n");
	else
	{	new1=(node *)malloc(sizeof(node));
		new1->no=x;
		new1->po=n1->po;
		n1->po=new1;
	}
}
return(p);
}

node *find(node *p,int key)
{
if(p->po->no==key) return(p);
else
if(p->po->po==0) return(0);
else return(find(p->po,key));
}




