


#include "stdlib.h"
#include "stdio.h"



struct node
{	int  no;
	struct node  *l,*r;
};




typedef struct node *node;
typedef struct node  item;




node makenode(void)
{
node t;
	  t=(node)malloc(sizeof(item));
	  t->r=0,t->l=0;
	  return(t);
}



void initial(node p)
{
	p->no=0,p->r=p->l=0;
	return;
}



void interchange(node p,node q)
{
int num;
	   num=p->no,p->no=q->no,q->no=num;
return;
}



void acceptvalue(node p)
{
	printf("Enter number:"),scanf("%d",&p->no),p->r=p->l=0;
	return;
}



void printvalue(node head)
{
	printf("<--[%d]",head->no);
	return;
}

