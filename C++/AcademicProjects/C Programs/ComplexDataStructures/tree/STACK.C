
#include "\tc\bin\ds\tree\1inc.c"

#define  MAX 100


typedef struct
{	tree a[MAX];  //-------Stack (Pointer to node)
	int top;   //--------Stack top pointer
}stack;


int stackempty(stack *s)
{	if(s->top==-1) return(1); else return(0);	}


int stackfull(stack *s)
{	if(s->top==MAX-1) return(1); else return(0);	}



void pusht(tree value,stack *s)
{
	if(stackfull(s)) printf("\nStack Full:\n");
	else s->a[++s->top]=value;
	return;
}



tree popt(stack *s)
{
	if(stackempty(s))
	{	printf("\nStack is Empty:,Returnig NULL");
		return(0);
	}
	else return(s->a[s->top--]);
}



