//----------------------PRIORITY QUEUE----------------------//

#define SE 5


typedef struct
{
	char a[SE];     //-----------Queue
	int  p[SE];     //-----------Priorities
	int  rear;      //-----------Number of elements in queue
}pqueue;


//-----------------SETTING P-QUEUE INITIALLY--------------//

void setpqueue(pqueue *s)
{
int i;
	  for(s->rear=-1,i=0;i<SE;s->a[i]='\0',s->p[i]=-1,i++);
	  return;
}

//-----------------------------------------------------------------//

void resetpqueue(int i,pqueue *s)
{
int j;
	 if( (i>-1&&i<=s->rear) && s->rear>-1 )
	 {	for(j=i;j<s->rear;j++) s->a[j]=s->a[j+1],s->p[j]=s->p[j+1];
		s->a[s->rear]='\0',s->p[s->rear]=-1;
		s->rear--;
		return;
	 }
	 else return;
}


void sortpqueue(pqueue *s)
{
int i,j,t;
char x;
	for(i=0;i<s->rear;i++)
		for(j=i+1;j<=s->rear;j++)
			if(s->p[i]<s->p[j])
				x=s->a[i],s->a[i]=s->a[j],s->a[j]=x,
				t=s->p[i],s->p[i]=s->p[j],s->p[j]=t;
return;
}


//-----------------P-QUEUE FUNCTIONS----------------------------//

void pins(char x,int prior,pqueue *s)
{
	if(s->rear<SE-1)
	{	s->a[++s->rear]=x,s->p[s->rear]=prior;
		return;
	}
	else
	{	printf("P-queue is full,cannot insert");
		getch();
		return;
	}
}



char pdel(pqueue *s)
{
int  j,i=-1,py=-1;
char x='0';

	for(j=0;j<=s->rear;j++)
		if(s->p[j]>py) i=j,py=s->p[j];

	if(i!=-1)
	{   x=s->a[i];
		resetpqueue(i,s);
		return(x);
	}
	else
	{	printf("P-queue is empty,returning NULL");
		getch();
		return(x);
	}
}



void pdisp(pqueue *s)
{
pqueue s1=*s;
int i;

	sortpqueue(&s1);
	for(i=0;i<=s1.rear;i++) printf("<---%c",s1.a[i]);
	return;
}


//--------------------------------------------------------------------//