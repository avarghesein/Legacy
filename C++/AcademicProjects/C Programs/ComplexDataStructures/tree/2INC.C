
#include "\tc\bin\ds\tree\stack.c"
#include "\tc\bin\ds\inc\prefix.c"


void posttraversal(tree root,char *x)
{
stack s,s1;
tree p;
int i;

	s.top=s1.top=-1;
	if(root!=0) pusht(root,&s1);

	while(!stackempty(&s1))
		for(p=popt(&s1);p!=0;pusht(p,&s),p=p->right)
			if(p->left!=0) pusht(p->left,&s1);

	for(i=0;!stackempty(&s);i++) x[i]=(popt(&s))->inf.ch;
	x[i]='\0';

return;
}




void pretraversal(tree root,char *x)
{
stack s,s1;
tree p;
int i;

	s.top=s1.top=-1;
	if(root!=0) pusht(root,&s1);

	while(!stackempty(&s1))
		for(p=popt(&s1);p!=0;pusht(p,&s),p=p->left)
			if(p->right!=0) pusht(p->right,&s1);


	for(s1.top=-1;!stackempty(&s);pusht(popt(&s),&s1));
	for(i=0;!stackempty(&s1);i++) x[i]=(popt(&s1))->inf.ch;
	x[i]='\0';

return;
}


void intraversal(tree root,char *x)
{
stack s;
int i;
tree p;

	i=-1,s.top=-1,p=root;
	do
	{
		while(p!=0) pusht(p,&s),p=p->left;

		if(!stackempty(&s)) p=popt(&s),x[++i]=p->inf.ch,p=p->right;
	}
	while(!stackempty(&s)||p!=0);

	x[++i]='\0';

return;
}




int isfull(tree p)
{
	if(p->left==0||p->right==0) return(0); else return(1);
}




tree maketreefromprefix(char *y)
{
int i;
tree root=0,p,q;
info x;


x.ch=y[0],root=makeroot(x),i=0,p=root;

while((x.ch=y[++i])!='\0')
{
  if(!isoperand(x.ch))
	 if(p->left==0) setleftson(p,x),p=p->left;
	 else           setrightson(p,x),p=p->right;

  else
		{	if(p->left==0) setleftson(p,x);
			else           setrightson(p,x);

			while(p!=root&&isfull(p)) p=p->father;
		}
}

return(root);
}



tree maketreefrompostfix(char *y)
{
int i;
tree root=0,p,q;
info x;


i=strlen(y),--i,x.ch=y[i],root=makeroot(x),p=root;

while((x.ch=y[--i]),i>=0)
{
  if(!isoperand(x.ch))
	 if(p->right==0) setrightson(p,x),p=p->right;
	 else            setleftson(p,x),p=p->left;
  else
		{	if(p->right==0) setrightson(p,x);
			else            setleftson(p,x);

			while(p!=root&&isfull(p)) p=p->father;
		}
}

return(root);
}