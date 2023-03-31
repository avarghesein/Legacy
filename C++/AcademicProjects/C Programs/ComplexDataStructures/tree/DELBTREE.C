

#include "\tc\bin\ds\tree\incbtree.c"

#define BROTHEROLDER 1
#define BROTHERELDER 2

int compactnode(node a,int indx,node po)
{
int i;

	if(a==0) return(0);

	for(i=indx;i<a->keys;i++)
		a->inf[i]=a->inf[i+1],
		a->son[i]=a->son[i+1];

	a->son[indx]=po,a->keys--;

return(1);
}



node succsessorof(node z,int indx,int *val)
{
node tst=z,k=z;

	if(z==0) return(0);
	z=z->son[indx+1];
	while(z!=0) k=z,z=z->son[0];
	if(tst==k) *val=k->inf[indx+1]; else *val=k->inf[0];
	return(k);
}




int fatherbrother_indxs(piv,father,brother,pindx,findx,bindx)
node piv;
node *father,*brother;
int *pindx,*findx,*bindx;
{
int i;
node a;

	if(piv==0) a=piv; else a=piv->father;
	if(a==0)
	{	*father=*brother=0,*pindx=*findx=*bindx=-1;
		return(0);
	}

	*father=a;

	for(i=0;i<=a->keys;i++) if(a->son[i]==piv) break;

	if(i!=0&&(i==a->keys||a->son[i+1]==0))
	{
		*brother=a->son[i-1],*findx=i-1,*pindx=0;
		*bindx=(*brother==0?-1:(*brother)->keys-1);
		return(BROTHERELDER);
	}

		*brother=a->son[i+1],*findx=i,*pindx=piv->keys-1;
		*bindx=(*brother==0?-1:0);
		return(BROTHEROLDER);
}



node deletebtree(node head,int value)
{
int x,i;
node a,b,piv,z;

	z=findnodeandindex(head,value,&i);

	if(z==0||i<0||z->inf[i]!=value) return(head);

	a=z->son[i],b=z->son[i+1];

	if(a==0||b==0)
		compactnode(z,i,a==0?b:a),piv=z;
	else
		a=succsessorof(z,i,&x),z->inf[i]=x,compactnode(a,0,a->son[1]),
		piv=a;


	maintainbalance(piv,&head);

return(head);
}



node unitenodes(node a,node b,node common)
{
node l=makenode();
int i=0,j;

	if(a!=0)
	{
		for(j=0;j<a->keys;j++,i++)
		{
			l->inf[i]=a->inf[j],l->son[i]=a->son[j];
			if(a->son[j]!=0) a->son[j]->father=l;
		}
		l->keys+=a->keys;
		free(a);
	}

	l->son[i]=common;

	if(b!=0)
	{
		for(j=0;j<b->keys;j++,i++)
		{
			l->inf[i]=b->inf[j],l->son[i+1]=b->son[j+1];
			if(b->son[j+1]!=0) b->son[j+1]->father=l;
		}
		l->keys+=b->keys;
		free(b);
	}

return(l);
}





int maintainbalance(node piv,node *head)
{
node f,b,l;
int i,pindx,findx,bindx,num;

	if(piv==0||piv->keys>=N/2) return(0);

	if(piv!=0&&piv->keys<=0)
	{	*head=piv->son[0];
		if(*head!=0) piv->son[0]->father=0;
		free(piv);
		return(1);
	}

	i=fatherbrother_indxs(piv,&f,&b,&pindx,&findx,&bindx);

	if(b!=0)
		if(i==BROTHEROLDER)
		{	insert_balance(piv,f->inf[findx],piv->keys,head,piv->son[piv->keys],b->son[0]);
			if(b->keys>N/2)
				num=b->inf[0],f->inf[findx]=num,compactnode(b,0,b->son[1]);
			else
			{	l=unitenodes(piv,b,piv->son[piv->keys]),compactnode(f,findx,l),
				l->father=f;
				return(maintainbalance(f,head));
			}
		}
		else
		{
			insert_balance(piv,f->inf[findx],0,head,b->son[b->keys],piv->son[0]);
			if(b->keys>N/2)
				num=b->inf[b->keys-1],f->inf[findx]=num,
				compactnode(b,b->keys-1,b->son[b->keys-1]);
			else
			{	l=unitenodes(b,piv,piv->son[0]),compactnode(f,findx,l),
				l->father=f;
				return(maintainbalance(f,head));
			}
		}

return(0);
}