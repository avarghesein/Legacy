

//---------------CIRCULAR-PRIORITY QUEUE----------------------//

#define S 5

#define SET(x,y)   x.f=x.r=y
#define SETP(x,y)  x->f=x->r=y

typedef struct
{
	char a[S];     //-----------Queue
	int  p[S];     //-----------Priorities
	int  f,r;      //-----------Front & Rear pointers
}cpqueue;




//------------------SUB-FUNCTIONS-----------------//

//--------------Returning INDEX of the middle item--------//

int findmiddle(cpqueue *p)
{
int c,i;

	if(p->f==-1||p->r==-1)
	{	printf("Queue is empty,Returning Null index");
		getch();
		return(-1);
	}

	for(c=0,i=p->f;i!=p->r;c++,i=(i==S-1?0:i+1));

	c+=1,c/=2,c+=p->f,c%=S;

return(c);
}


//-------------shifting left all elements upto i(not i)
//-------------& inserting new item before i

void shiftleft_ins(int i,cpqueue *p,char x,int py)
{
int pre,cur=p->f;

	p->f=pre=(cur==0?S-1:cur-1);

	while(cur!=i)
		 p->a[pre]=p->a[cur],p->p[pre]=p->p[cur],
		 pre=cur,
		 cur=(cur==S-1?0:cur+1);

	p->a[pre]=x,p->p[pre]=py;

return;
}


//----------------shifting all items including i,right
//-------------& inserting item at 'i' th position


void shiftright_ins(int i,cpqueue *p,char x,int py)
{
int next,cur=p->r;

	p->r=next=(cur==S-1?0:cur+1);


	while(next!=i)
		 p->a[next]=p->a[cur],p->p[next]=p->p[cur],
		 next=cur,
		 cur=(cur==0?S-1:cur-1);


	p->a[next]=x,p->p[next]=py;

return;
}

//--------------FUNCTIONS OF PQUEUE---------------------------//

void cpins(cpqueue *p,char x,int py)
{
int t=(p->r==S-1?0:p->r+1),i;

	if(p->f==t)
	{	printf("Cannot insert,Queue is full:");
		getch();
		return;
	}
	else
	if(p->f==-1||p->r==-1) p->a[0]=x,p->p[0]=py,SETP(p,0); else
	{
		i=p->f;
		while(i!=t)
			 if(p->p[i]<py) break;
			 else i=(i==S-1?0:i+1);

		if(i<findmiddle(p))  shiftleft_ins(i,p,x,py);  else
							shiftright_ins(i,p,x,py);
	}
return;
}


char cpdel(cpqueue *p)
{   char x;

	if(p->f==-1||p->r==-1)
	{	printf("Queue is empty,Returning null");
		getch();
		return('0');
	}
	else
	{	x=p->a[p->f];

		if(p->f==p->r) SETP(p,-1); else
		if(p->f==S-1)  p->f=0;     else
		++p->f;

		return(x);
	}
}



void cpdis(cpqueue *p)
{
int i=p->f;

if(p->f==-1||p->r==-1) return;

while(i!=p->r)
	{	printf("<--%c",p->a[i]);
		if(i==S-1) i=0;else i++;
	}
printf("<--%c",p->a[p->r]);

return;
}


//----------------------------------------------------------------------//