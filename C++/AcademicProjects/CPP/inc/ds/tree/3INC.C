
#include "\tc\bin\ds\tree\1inc.c"



void adjust(head,fpiv,piv,a)
tree *head;
tree fpiv,piv,a;
{
	if(fpiv==0)
	{	*head=a,a->father=0;
		return;
	}
	if(fpiv->right==piv) fpiv->right=a; else fpiv->left=a;
	a->father=fpiv;

return;
}


int rotateright(tree p)
{
tree a;
	if(p==0||p->left==0) return(0);
	a=p->left;
	if(a->right!=0) a->right->father=p;
	p->left=a->right;
	a->right=p;
	p->father=a;
	a->father=0;
	return(1);
}


int rotateleft(tree p)
{
tree a;
	if(p==0||p->right==0) return(0);
	a=p->right;
	if(a->left!=0) a->left->father=p;
	p->right=a->left;
	a->left=p;
	p->father=a;
	a->father=0;
	return(1);
}



int insert_balance(tree *head,int num)
{
info x;
tree fpiv=0,fp=0,piv=*head,p=*head,a,b;

	x.num=num;


	while(p!=0)
	{
		if(p->inf.num==num) return(0);
		fp=p;
		p=(num<p->inf.num)?p->left:p->right;
		if(p!=0) if(p->bal!=0) fpiv=fp,piv=p;
	}

	p=makeroot(x),p->bal=0;

	if(fp==0)
	{	*head=p;
		return(1);
	}

	if(num<fp->inf.num) fp->left=p; else fp->right=p;
	p->father=fp;

	p=fp;
	while(p!=fpiv)
	{
		if(num<p->inf.num) p->bal+=1; else p->bal-=1;
		p=p->father;
	}

	if(piv->bal==0||piv->bal==1||piv->bal==-1) return(1);

	if(piv->bal>0)
	{
		a=piv->left;
		if(num<a->inf.num) rotateright(piv),adjust(head,fpiv,piv,a),
						   a->bal=piv->bal=0;
		else
		{
			b=a->right;
			rotateleft(a);
			piv->left=b,b->father=piv;
			rotateright(piv);
			adjust(head,fpiv,piv,b);
			if(b->bal==1) piv->bal=-1; else piv->bal=0;
			if(b->bal==-1) a->bal=1; else a->bal=0;
			b->bal=0;
		}
	}
	else
	{
		a=piv->right;
		if(num>a->inf.num) rotateleft(piv),adjust(head,fpiv,piv,a),
						   a->bal=piv->bal=0;
		else
		{
			b=a->left;
			rotateright(a);
			piv->right=b,b->father=piv;
			rotateleft(piv);
			adjust(head,fpiv,piv,b);
			if(b->bal==-1) piv->bal=1; else piv->bal=0;
			if(b->bal==1) a->bal=-1; else a->bal=0;
			b->bal=0;
		}
	}
return(1);
}

