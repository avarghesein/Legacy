

#include"\tc\bin\ds\inc\link\2setup.c"



node findnode(node head,int key)
{
	if(head==0) return(0); else
	if(head->no==key) return(head); else
	return(findnode(head->r,key));
}




node insfront(node head,item x)
{
node t;
	  t=makenode(),*t=x,t->r=head,t->l=0;
	  if(head!=0) head->l=t;

return(t);
}


item delfront(node *head)
{
node t;
item x;
initial(&x);

	if(*head==0)
	{	printf("List is empty,Returning NULL item");
		getch();
		return(x);
	}

	x=*(*head);

	if((*head)->r==0) free(*head),*head=0; else
	(*head)->r->l=(*head)->l,t=*head,*head=(*head)->r,free(t);

return(x);
}


node insback(node back,item x)
{
node t;

	t=makenode(),*t=x,t->r=0,t->l=back;
	if(back!=0) back->r=t;

return(t);
}



item delback(node *back)
{
item x;
node t;
initial(&x);

	if(*back==0)
	{	printf("List is empty,Returning NULL item");
		getch();
		return(x);
	}
	x=*(*back);

	if((*back)->l==0) free(*back),*back=0; else
	(*back)->l->r=(*back)->r,t=*back,*back=(*back)->l,free(t);

return(x);
}



void display(node head)
{
	if(head==0)
	{	printf("\n\n\tList is EMPTY"),getch();
		return;
	}
	while(head!=0) printvalue(head),head=head->r;

return;
}



node insbefore(node head,int key,item x)
{
node t,n;

	if(head==0) return(0);
	if(head->no==key) return(insfront(head,x));
	t=findnode(head,key);
	if(t==0) return(head);

	n=makenode(),*n=x;
	n->l=t->l,n->r=t,t->l->r=n,t->l=n;

return(head);
}



node delnode(node head,int key)
{
node t;

	if(head==0) return(0);
	if(head->no==key)
	{	delfront(&head);
		return(head);
	}
	t=findnode(head,key);
	if(t==0) return(head);

	t->l->r=t->r;
	if(t->r!=0) t->r->l=t->l;
	free(t);

return(head);
}

