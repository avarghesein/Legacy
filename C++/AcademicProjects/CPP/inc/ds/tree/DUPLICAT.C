
#include "\tc\bin\ds\tree\1inc.c"

void main()
{

int n;
tree root=0,p,q;
info x;
clrscr();

printf("\nEnter numbers ,-999 at last\n");
	while(scanf("%d",&x.num),x.num!=-999)
	{   if(root==0)
		{	root=makeroot(x);
			continue;
		}
		p=q=root;
		while(q!=0&&x.num!=p->inf.num)
			p=q,q=(x.num<p->inf.num?leftsonof(p):rightsonof(p));

		if(x.num==p->inf.num) printf("\n%d is duplicated\n",x.num); else
		if(x.num<p->inf.num)
				setleftson(p,x);
		else
				setrightson(p,x);
	}

	clrscr();
	printf("\npreorder traversal\n\n"),pretrav(root,0);
	printf("\n\n");
	printf("\ninorder traversal\n\n"),intrav(root,0);
	printf("\n\n");
	printf("\npostorder traversal\n\n"),posttrav(root,0);
	printf("\n\n");
getch();
}