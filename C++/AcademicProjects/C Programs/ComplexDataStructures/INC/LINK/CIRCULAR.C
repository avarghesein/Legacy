

#include"\tc\bin\ds\inc\link\linear.c"



node cfindnode(node head,int key)
{
node temp;

	for(temp=head;temp->po!=head&&temp->po->no!=key;temp=temp->po);

return(temp);
}



node cinsfront(node head,item nam)
{
node t1=head,t2;

	 if(head==0)
	 {	head=makenode(),*head=nam,head->po=head;
		return(head);
	 }
	 head=insfront(head,nam);
	 for(t2=head->po;t2->po!=t1;t2=t2->po);
	 t2->po=head;
	 return(head);
}


node cinsback(node back,item nam)
{
	if(back==0) return(cinsfront(back,nam));
	else        return(insback(back,nam));
}




item cdelfront(node *head)
{
item nam;
node t1=*head,t2;

	 nam=delfront(head);
	 if(*head==0)  return(nam); else
	 if(*head==t1)
	 {  *head=0;
		return(nam);
	 }

	 for(t2=*head;t2->po!=t1;t2=t2->po);
	 t2->po=*head;

	 return(nam);
}



void cdisp(node head)
{
node t;

	if(head==0)
	{	printf("\nList is empty\n");
		return;
	}

	clrscr();
	printf("\nList is \n\n");

	t=head;
	do printvalue(t),t=t->po; while(t!=head);

return;
}



node cinsert(node head,int key,item x)
{
node news,temp;

	if(head==0) return(0);
	if(head->no==key) return(cinsfront(head,x));

	temp=cfindnode(head,key);

	if(temp->po==head) return(head);

	news=makenode(),*news=x,news->po=temp->po,temp->po=news;

	return(head);
}




node cdelete(node head,int key)
{
node temp,news;

	if(head==0) return(0);
	if(head->no==key)
	{   cdelfront(&head);
		return(head);
	}

	temp=cfindnode(head,key);

	if(temp->po==head) return(head);

	news=temp->po->po,free(temp->po),temp->po=news;

	return(head);
}



node csortinsert(node head,item x)
{
node temp,pre,cur;

	if(head==0||head->no>x.no) return(cinsfront(head,x));
	if(head->po==head)
	{
		if(head->no<x.no) temp=cinsback(head,x);
		else head=cinsfront(head,x);

		return(head);
	}

	for(pre=head,cur=head->po;cur!=head&&cur->no<x.no;pre=cur,cur=cur->po);

	if(cur==head) temp=cinsback(pre,x);
	else  temp=makenode(),*temp=x,temp->po=pre->po,pre->po=temp;

	return(head);
}




void csort(node head)
{
node cur,next;

	if(head==0||head->po==head) return;

	cur=head;
	do
	{	next=cur->po;
		while(next!=head)
		{	if(cur->no>next->no) interchange(cur,next);
			next=next->po;
		}
		cur=cur->po;
	}
	while(cur!=head);

	return;
}
