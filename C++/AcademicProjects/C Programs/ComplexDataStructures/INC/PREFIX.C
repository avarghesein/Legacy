

#include "\tc\bin\ds\inc\postfix.c"


int priority(char op1,char op2)
{
if(op1==')'||op2==')') return(0); else
if(op2=='(') return(1); else
switch(op1)
  {	 case '$':if(op2=='$')           return(0);  else return(1);
	 case '/':if(op2=='$'||op2=='/') return(0);  else return(1);
	 case '*':if(op2=='$'||op2=='/'||op2=='*')   return(0);
			  else return(1);
	 case '-':
	 case '+':if(op2=='$'||op2=='/'||op2=='*'||op2=='+'||op2=='-') return(0);
			  else return(1);

	 default :printf("\n\nERROR IN OPERATOR:\n");
			  getch();
			  exit(1);
			  return(0);
  }
}



void toprefix(char infix[],char prfix[])
{

stk s,s1;
char symb;
int i=strlen(infix);
s.top=-1;
s1.top=-1;

while(symb=infix[--i],i>=0)
	if(isoperand(symb)) push(symb,&s1);  else
	{
		while(!stkempty(&s) && priority(s.a[s.top],symb)==1)
			  push(pop(&s),&s1);
		if(stkempty(&s)||(symb!='(')) push(symb,&s);
		else symb=pop(&s);
	}


while(!stkempty(&s)) push(pop(&s),&s1);

for(i=0;!stkempty(&s1);i++) prfix[i]=pop(&s1);
prfix[i]='\0';

return;
}



float evaluateprefix(char pfix[])
{

cval k;
stk s;
stkf ts;
char symb;
int i;
float op1,op2;
s.top=-1;
ts.top=-1;

for(i=0;pfix[i]!='\0';i++) push(pfix[i],&s);

takevalue(pfix,&k);

while(!stkempty(&s))
  if( isoperand(symb=pop(&s)) )  pushf(findvalue(symb,&k),&ts); else
  op1=popf(&ts),op2=popf(&ts),pushf(operation(op1,op2,symb),&ts);


op1=popf(&ts);

if(stkfempty(&ts)) return(op1);    else
	{	printf("\n\nERROR IN EXPRESSION:"),getch(),exit(1);
		return(0);
	}

}


