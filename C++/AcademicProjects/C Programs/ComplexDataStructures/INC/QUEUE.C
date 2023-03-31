


#define SIZE 5



typedef struct
{	char a[SIZE];   //-----Queue
	int  f,r;      //------Front & Rear pointers
}queue;





//-----CIRCULAR QUEUE FUNCTIONS-------//

void cins(char x,queue *p)
{
int t;
	 t=p->r;
	 if(t==SIZE-1) t=0; else t+=1;
	 if(p->f==t)
	 {	printf("Queue is full");
		getch();
		return;
	 }
	 else
	 {	p->r=t,p->a[p->r]=x;
		if(p->f==-1) p->f=0;
		return;
	 }

}



void cinsleft(char x,queue *p)
{
int t=(p->f==0?SIZE-1:p->f-1);

	if(t==p->r)
	{	printf("Queue is full,cannot insert left:");
		getch();
		return;
	}
	else
	{	p->a[p->f=t]=x;
		return;
	}
}



char cdel(queue *p)
{
char x;
	if(p->f==-1)
	{   printf("Queue is empty,returning NULL");
		getch();
		return('0');
	}
	else
	{	x=p->a[p->f];
		if(p->f==p->r)     p->f=p->r=-1;else
		if(p->f==SIZE-1)   p->f=0;      else    p->f++;
		return(x);
	}
}




char cdelright(queue *p)
{   char x;


	if(p->r!=-1)
	{
		x=p->a[p->r];
		if(p->r==p->f) p->r=p->f=-1; else
		if(p->r==0)    p->r=SIZE-1;  else
					   p->r--;
		return(x);
	}
	printf("Queue is empty,Returning NULL:");
	getch();
	return('0');
}





void cdis(queue *p)
{
int i=p->f,j=(p->r==SIZE-1?0:p->r+1),flag=0;

while( i!=-1 && (i!=j||flag==0) )
	{
	flag=1;
	printf("<--%c",p->a[i]);
	if(i==SIZE-1) i=0;else i++;
	}
return;
}





//----------NORMAL QUEUE FUNCTIONS--------//

void ins(char x,queue *p)
{
	if(p->r<SIZE-1)
	{	p->a[++p->r]=x;
		if(p->f==-1)  p->f=0;
	}
	else
		printf("Queue is full"),getch();
return;
}



char del(queue *p)
{
char x;
	  if(p->f==-1)
	  {		printf("Queue is empty,returning NULL"),getch();
			return('0');
	  }
	  else
	  {		x=p->a[p->f];
			if(p->f==p->r) p->f=p->r=-1; else p->f++;
			return(x);
	  }
}


//--------------------D QUEUE FUNCTIONS-----------//


void leftins(char x,queue *p)
{
	if(p->f<=0)
	{	printf("Queue is full,cannot insert left");
		getch();
		return;
	}
	else
	{
		p->a[--p->f]=x;
		return;
	}
}

char rightdel(queue *p)
{
char x;

	if(p->r==-1)
	{	printf("Queue is empty,cannot delete from right");
		printf("\nReturning NULL");
		getch();
		return('0');
	}
	else
	{	x=p->a[p->r--];
		if(p->r==-1) p->f=-1;
		return(x);
	}
}

//-------------------------------------------------------------------//