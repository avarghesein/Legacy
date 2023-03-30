
#define S 10

static char flag='0';

static int avail;

struct  llist
{	int inf;int next;	} node[S];


void initial()
{
int i;
	for(i=0;i<S-1;i++) node[i].next=i+1;
	node[S-1].next=-1;
	avail=0;
	flag='1';
return;
}




int getnode()
{
int tmp;
	if(flag=='0') initial();

	if(avail==-1)
	{	printf("\n\tNo nodes available,Returning null index");
		return(-1);
	}
	else
	{	tmp=avail,avail=node[avail].next;
		return(tmp);
	}
}



void freenode(int p)
{
	if(flag=='0') initial();

	if(p>=0&&p<S) node[p].next=avail,avail=p;
	else printf("\nError in node index");

return;
}


void display(int head)
{
	if(flag=='0') initial();

	if(head>=0&&head<S)
	{	printf("\nList is\n\n");
		while(head!=-1) printf("<--%d",node[head].inf),head=node[head].next;
	}
	else printf("\n\nError in node index");
return;
}


void setnode(int p,int val)
{
	if(flag=='0') initial();

	if(p>=0&&p<S) node[p].inf=val; else
	printf("\nError in node index");

return;
}