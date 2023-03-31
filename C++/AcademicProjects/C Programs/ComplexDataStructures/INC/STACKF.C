

//------------------STACK TYPEF------------------------------//
			#define TYPEF    float
			#define EMPTYF   0.0
//----------------------------------------------------------//

#define  SF 50


typedef struct
{	TYPEF a[SF];  //-------Stack (float)
	int top;   //--------Stack top pointer
}stkf;


int stkfempty(stkf *s)
{	if(s->top==-1) return(1); else return(0);	}


int stkffull(stkf *s)
{	if(s->top==SF-1) return(1); else return(0);	}



void pushf(TYPEF value,stkf *s)
{
	if(stkffull(s)==1) printf("\nStack Full:\n");
	else s->a[++s->top]=value;
	return;
}



TYPEF popf(stkf *s)
{
	if(stkfempty(s)==1)
	{	printf("\nStack is Empty:,Returnig NULL");
		return(EMPTYF);
	}
	else return(s->a[s->top--]);
}



