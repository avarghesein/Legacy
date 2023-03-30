


#include "stdlib.h"
#include "stdio.h"



struct node
{	        int  no;
	struct node *po;
};




typedef struct node *node;
typedef struct node  item;




node makenode(void)
{	 return( (node)malloc(sizeof(item)) );	 }




void initial(node p)
{
	p->no=0,p->po=0;
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
	printf("Enter number:"),scanf("%d",&p->no),p->po=0;
	return;
}



void printvalue(node head)
{
	printf("<--[%d]",head->no);
	return;
}

