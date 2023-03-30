
//-----------------------------------------------------------------------//
//---0=int display,1=char display 2 or else float display---------------------//



typedef struct{ int num;char ch;float dec; }info;


typedef struct  format
{   info   inf;
	struct format *father,*left,*right;
	int bal;
}
*tree;

typedef struct format node;

//----------------------------------------------------------------------//


void setnullinf(tree p)
{
	(p->inf).num=0,(p->inf).ch='0',(p->inf).dec=0.0;
	return;
}



tree makeroot(info x)
{
tree t;
	  t=(tree)malloc(sizeof(node));
	  t->father=t->right=t->left=0;
	  t->inf=x;
	  return(t);
}



int setleftson(tree p,info x)
{
	if(p==0||p->left!=0) return(0);
	p->left= makeroot(x);
	p->left->father=p;
	return(1);
}


int setrightson(tree p,info x)
{
	if(p==0||p->right!=0) return(0);
	p->right= makeroot(x);
	p->right->father=p;
	return(1);
}


tree leftsonof(tree p)  {	return(p->left);	}
tree rightsonof(tree p) {	return(p->right);	}
tree fatherof(tree p) 	{	return(p->father);	}


int isleft(tree p)
{
	if(fatherof(p)==0) return(0); else
	if(leftsonof(fatherof(p))==p) return(1); else
	return(0);
}

int isright(tree p)
{
	if(fatherof(p)==0) return(0); else
	if(rightsonof(fatherof(p))==p) return(1); else
	return(0);
}

tree brotherof(tree p)
{
	if(fatherof(p)==0) return(0); else
	if(isleft(p)) return(rightsonof(fatherof(p)));
	else return(leftsonof(fatherof(p)));
}



void pretrav(tree root,int flag)
{
	if(root!=0)
	{   flag==0?printf("<--%d",root->inf.num):
		flag==1?printf("%c",root->inf.ch):printf("<--%f",root->inf.dec);

		pretrav(root->left,flag);
		pretrav(root->right,flag);
	}
	else return;
}



void intrav(tree root,int flag)
{
	if(root!=0)
	{
		intrav(root->left,flag);

		flag==0?printf("<--%d",root->inf.num):
		flag==1?printf("%c",root->inf.ch):printf("<--%f",root->inf.dec);

		intrav(root->right,flag);
	}
	else return;
}



void posttrav(tree root,int flag)
{
	if(root!=0)
	{   posttrav(root->left,flag);
		posttrav(root->right,flag);

		flag==0?printf("<--%d",root->inf.num):
		flag==1?printf("%c",root->inf.ch):printf("<--%f",root->inf.dec);
	}
	else return;
}
