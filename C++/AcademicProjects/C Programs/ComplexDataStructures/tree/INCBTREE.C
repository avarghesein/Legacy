
//--------CHANGE ORDER OF B-TREE HERE-----------------//

#define ORDER 5

//------(Maximum of ORDER pointers & ORDER-1 keys------//



#include<stdlib.h>
#include<stdio.h>

#define N ORDER


typedef struct list
{	struct list *father,*son[N+1];
	int    keys,inf[N];
}
*node;

typedef struct list btree;



node makenode(void)
{
int i;
node tmp;
			tmp=(node)malloc(sizeof(btree));
			for(i=0;i<N;i++) tmp->son[i]=0,tmp->inf[i]=0;
			tmp->father=0,tmp->keys=0;

return(tmp);
}



void display(node head)
{
int i;

	if(head==0) return;
	for(i=0;i<head->keys;i++)   printf("..|%d|",head->inf[i]);
	for(i=0;i<=head->keys;i++)  display(head->son[i]);

return;
}





int isfull(node p)
{	if(p->keys>=N-1) return(1); else return(0);  }



int  positioninnode(node p,int x)
{
int i,j;

	for(j=-1,i=0;i<p->keys&&p->inf[i]<=x;j=i,i++)
	   if(p->inf[i]==x) return(i);

return(j);
}


node findnodeandindex(node head,int x,int *indx)
{
node z;
int i;

	while(head!=0)
	{   z=head;
		i=positioninnode(head,x);
		if(i>=0&&head->inf[i]==x)
		{		*indx=i;
				return(head);
		}
		head=head->son[i+1];
	}

*indx=i;
return(z);
}



node insertinbtree(node head,int x)
{
int i;
node z;

	if(head==0)
	{	head=makenode(),head->inf[0]=x,head->keys=1;
		return(head);
	}

		z=findnodeandindex(head,x,&i);

		if(i>=0&&z->inf[i]==x) return(head);

		i=insert_balance(z,x,i+1,&head,0,0);

return(head);
}



int insert_balance(node a,int value,int indx,node *root,node p,node q)
{
int flag,i,num;
node tmp;


	if(isfull(a)) flag=1; else flag=0;

	for(i=a->keys-1;i>=indx;i--)  a->inf[i+1]=a->inf[i];
	for(i=a->keys;i>=indx;i--)    a->son[i+1]=a->son[i];

	a->inf[indx]=value,a->son[indx]=p,a->son[indx+1]=q,a->keys++;

	if(flag==0) return(0);

	p=makenode(),q=makenode();

	for(i=0;i<N/2;i++)
	{   p->inf[i]=a->inf[i],q->inf[i]=a->inf[N/2+1+i],
		p->son[i]=a->son[i],q->son[i]=a->son[N/2+1+i];
		if(p->son[i]!=0)
			a->son[i]->father=p;
		if(q->son[i]!=0)
			a->son[N/2+1+i]->father=q;
	}
	p->son[N/2]=a->son[N/2],q->son[N/2]=a->son[N];

	if(a->son[N/2]!=0)
		a->son[N/2]->father=p;
	if(a->son[N]!=0)
		a->son[N]->father=q;

	p->keys=q->keys=N/2;

	tmp=a->father,num=a->inf[N/2],free(a);

	if(tmp==0)
	{
		tmp=makenode();
		*root=tmp;
		tmp->inf[0]=num,tmp->son[0]=p,tmp->son[1]=q;
		tmp->keys=1;
		p->father=q->father=tmp;
		return(1);
	}

	p->father=q->father=tmp;

	i=positioninnode(tmp,num);

	return(insert_balance(tmp,num,i+1,root,p,q));
}
