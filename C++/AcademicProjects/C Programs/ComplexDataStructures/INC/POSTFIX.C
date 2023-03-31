

#include "math.h"
#include "\tc\bin\ds\inc\stackc.c"
#include "\tc\bin\ds\inc\stackf.c"



typedef struct
{	char str[50];
	float val[50];
	int nv;
}cval;



void takevalue(char  pfix[],cval *k)
{
int i,j,m;


for(i=j=0;pfix[i]!='\0';i++)
	if(isoperand(pfix[i])==1)
		if(pfix[i]=='~') continue;  else
		{	for(m=0;m<j;m++)
				if(k->str[m]==pfix[i]) break;
			if(m==j) k->str[j++]=pfix[i];
		}

k->nv=j-1;

for(i=0;i<=k->nv;i++)
	if(k->str[i]>=48&&k->str[i]<=57) k->val[i]=(float)(k->str[i]-'0');
	else
		printf("\nEnter the value of %c:",k->str[i]),scanf("%f",&k->val[i]);

return;
}




float findvalue(char x,cval *k)
{
int j;

	for(j=0;j<=k->nv;j++)
		if(x==k->str[j]) return(k->val[j]);

	printf("Value not found,returning NULL");
	getch();
	return(0);
}




int expcorrect(char *ae)
{

stk s;
int n,i;
s.top=-1;

n=strlen(ae);

for(i=0;i<n;i++)
	switch(ae[i])
	{
		case '(':
		case '{':
		case '[':push(ae[i],&s);
				 break;
		case ')':if(stkempty(&s))        return(0); else
				 if(ae[i]-1==s.a[s.top]) pop(&s);   else
				 return(0);
				 break;
		case '}':
		case ']':if(stkempty(&s))        return(0); else
				 if(ae[i]-2==s.a[s.top]) pop(&s);   else
				 return(0);
	}
if(s.top==-1) return(1); else return(0);
}








int precedence(char op1,char op2)
{
if(op1=='('||op2=='(') return(0); else
if(op2==')') return(1); else
switch(op1)
  {	 case '$':
	 case '/':if(op2=='$') return(0);
			  else return(1);

	 case '*':if(op2=='$'||op2=='/') return(0);
			  else return(1);

	 case '-':
	 case '+':if(op2=='$'||op2=='/'||op2=='*') return(0);
			  else return(1);

	 default :printf("\n\nERROR IN OPERATOR:\n");
			  getch();
			  exit(1);
			  return(0);
  }
}




int isoperand(char x)
{
if((x>=48&&x<=57)||(x>=65&&x<=90)||(x>=97&&x<=122)||x=='~') return(1);
else
	switch(x)
		{
		case '+':case '$':case '-':	case '*':case '/':case '(':case ')':
		return(0);
		default:printf("\n\nERROR!!!"),getch(),exit(1);
				return(0);
		}
}


int isoperator(char x)
{
	switch(x)
		{
		case '+':case '$':case '-':	case '*':case '/':return(1);
											  default:return(0);
		}
}

void topostfix(char infix[],char pofix[])
{
stk s;
char symb;
int i,j;
s.top=-1;

for(i=j=0;(symb=infix[i])!='\0';i++)
	if(isoperand(symb)) pofix[j++]=symb;
	else
	{
		while(!stkempty(&s) && precedence(s.a[s.top],symb)==1)
			  pofix[j++]=pop(&s);
		if(stkempty(&s)||symb!=')') push(symb,&s);
		else symb=pop(&s);
	}

while(!stkempty(&s)) pofix[j++]=pop(&s);

pofix[j]='\0';

return;
}




float operation(float op1,float op2,char x)
{
switch(x)
{
	case '$':return(pow(op1,op2));
	case '/':return(op1/op2);
	case '*':return(op1*op2);
	case '-':return(op1-op2);
	case '+':return(op1+op2);
	default:printf("\n\nERROR IN OPERATOR:"),getch(),exit(1);
			return(0);
}
}




float evaluatepostfix(char pfix[])
{

cval k;
stkf ts;
int i,flag;
float op1,op2;
ts.top=-1;


takevalue(pfix,&k);

for(i=0;pfix[i]!='\0';i++)
   if(isoperand(pfix[i]))
   {	for(flag=1;pfix[i]=='~';flag*=-1,i++);
		pushf(flag*findvalue(pfix[i],&k),&ts);
   }
   else op2=popf(&ts),op1=popf(&ts),pushf(operation(op1,op2,pfix[i]),&ts);


op1=popf(&ts);

if(stkfempty(&ts)) return(op1); else
	{	printf("\n\nERROR IN EXPRESSION:"),getch(),exit(1);
		return(0);
	}


}



