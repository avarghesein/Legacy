
#define  MAX 150

//-----------------------------------------------------------------//
typedef union information
{	char c;
	int  num;
	float dec;
}info;

info NULLINFO={0};

//-------------------------------------------------------------------//


typedef struct
{	info x[MAX];  //-------Stack (Pointer to node)
	int  top;   //--------Stack top pointer
}stack;


int stackempty(stack *s)
{	if(s->top==-1) return(1); else return(0);	}


int stackfull(stack *s)
{	if(s->top==MAX-1) return(1); else return(0);	}



void push(info value,stack *s)
{
	if(stackfull(s)) printf("\nStack Full:\n");
	else s->x[++s->top]=value;
	return;
}



info pop(stack *s)
{
	if(stackempty(s))
	{	printf("\nStack is Empty:,Returnig NULL");
		return(NULLINFO);
	}
	else return(s->x[s->top--]);
}



