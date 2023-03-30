

#include"\tc\bin\ds\inc\link\dlinear.c"



node cfindnode(node head,int key)
{
node temp;

	 for(temp=head->r;temp!=head&&temp->no!=key;temp=temp->r);

return(temp);
}






node cinsfront(node head,item x)
{
node keep,t;

	if(head==0)
	{	t=makenode(),*t=x,t->l=t->r=t;
		return(t);
	}
	keep=head->l,head=insfront(head,x),head->l=keep,keep->r=head;

return(head);
}



item cdelfront(node *head)
{
item x;
node keep;
initial(&x);

	if(*head==0)
	{	printf("List is empty,Returning NULL item");
		getch();
		return(x);
	}

	x=*(*head);

	if((*head)->r==*head||(*head)->l==*head)
	{	free(*head),*head=0;
		return(x);
	}
	keep=(*head)->l,x=delfront(head),keep->r=*head;

return(x);
}



node cinsback(node back,item x)
{
node keep;

	if(back==0) return(cinsfront(back,x));
	keep=back->r,back=insback(back,x),keep->l=back,back->r=keep;

return(back);
}


item cdelback(node *back)
{
node keep;
item x;

	if(*back==0||(*back)->l==*back||(*back)->r==*back)
		return(cdelfront(back));

	keep=(*back)->r,x=delback(back),keep->l=*back;

return(x);
}



void cdisplay(node head)
{
node temp;

if(head==0) return;

printf("\n\nList is:\n\n");
temp=head;
do printvalue(temp),temp=temp->r; while(temp!=head);

return;
}


node cinsbefore(node head,int key,item x)
{
node t,n;
	if(head==0) return(0);
	if(head->no==key) return(cinsfront(head,x));
	t=cfindnode(head,key);
	if(t==head) return(head);
	n=makenode(),*n=x,n->l=t->l,n->r=t,t->l->r=n,t->l=n;
	return(head);
}



node cdelnode(node head,int key)
{
node t;
	if(head==0) return(0);
	if(head->no==key)
	{	cdelfront(&head);
		return(head);
	}
	t=cfindnode(head,key);
	if(t==head) return(head);
	if(t->r==head)
	{	cdelback(&t);
		return(head);
	}
	t->l->r=t->r,t->r->l=t->l,free(t);
	return(head);
}


