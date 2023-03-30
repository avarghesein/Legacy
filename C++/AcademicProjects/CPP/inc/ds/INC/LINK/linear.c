

#include"\tc\bin\ds\inc\link\1setup.c"




node findnode(node head,int key)
{
	 if(head->po==0)       return(0);    else
	 if(head->po->no==key) return(head); else
	 return(findnode(head->po,key));

}


//-------returning new <head> pointer-------------//

node insfront(node head,item nam)
{
node t;
	   t=makenode(),*t=nam,t->po=head;
	   return(t);
}


//---------returning new <back> pointer---------------//

node insback(node back,item nam)
{
node t;

	  if(back==0) return(insfront(back,nam));
	  t=makenode(),*t=nam,t->po=back->po,back->po=t;
	  return(t);
}


//-------returning deleted value & rearranging <head> pointer----//

item delfront(node *front)
{
item  nam;
node t;

initial(&nam);

		 if(*front==0)
		 {
			printf("List is Empty,Returning NULL item"),getch();
			return(nam);
		 }
		 nam=*(*front),t=(*front)->po,free(*front),*front=t;
		 return(nam);
}


//-------returning new <head> pointer-----------//

node delnode(node head,int key)
{

node t1,t2;

	if(head==0) return(head); else
	if(head->no==key)
	{	delfront(&head);
		return(head);
	}
	else
	{	t1=findnode(head,key);
		if(t1==0) return(head);
		t2=t1->po,t1->po=t2->po,free(t2);
		return(head);
	}
}


//---------returning new <head> pointer--------------//

node insnode(node head,int key,item nam)
{
node t1,t2;

	 if(head==0) return(0); else
	 if(head->no==key) return(insfront(head,nam));
	 else
	 {
		t1=findnode(head,key);
		if(t1==0) return(head);

		t2=makenode(),*t2=nam,t2->po=t1->po,t1->po=t2;

		return(head);
	 }
}




void sort(node head)
{
node  newhead;

if(head==0) return; else  newhead=head->po;

while(newhead!=0)
{
	if(head->no>newhead->no)  interchange(head,newhead);
	newhead=newhead->po;
}
sort(head->po);

return;
}


//--------returning new <head> pointer--------------//


node sortins(node head,item nam)
{
node cur,pre,t;

	 for(cur=head,pre=0;cur!=0&&nam.no>cur->no;pre=cur,cur=cur->po);

	 if(pre==0) return(insfront(head,nam));

	 t=makenode(),*t=nam,t->po=cur,pre->po=t;

	 return(head);
}




void disp(node head)
{

if(head==0) printf("\nList is empty\n"); else
{
	clrscr(),printf("\nList Is:\n\n");
	while(head!=0)
		  printvalue(head),head=head->po;

	printf("\n\n");
}

return;
}




