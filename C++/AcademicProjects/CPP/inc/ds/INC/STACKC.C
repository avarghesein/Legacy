

//------------------STACK TYPE------------------------------//
			#define TYPE    char
			#define EMPTY   '0'
//----------------------------------------------------------//

#define  S 100


typedef struct
{	TYPE a[S];  //-------Stack (Charecter)
	int top;   //--------Stack top pointer
}stk;


int stkempty(stk *s)
{	if(s->top==-1) return(1); else return(0);	}


int stkfull(stk *s)
{	if(s->top==S-1) return(1); else return(0);	}



void push(TYPE value,stk *s)
{
	if(stkfull(s)==1) printf("\nStack Full:\n");
	else s->a[++s->top]=value;
	return;
}



TYPE pop(stk *s)
{
	if(stkempty(s)==1)
	{	printf("\nStack is Empty:,Returnig NULL");
		return(EMPTY);
	}
	else return(s->a[s->top--]);
}



