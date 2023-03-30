
#include<iostream.h>
#include<string.h>

class exprn
{
 protected:
 			char *exp;
 public:
        exprn(const char* ='\0',int=0,int=-1);
        ~exprn();
		friend int exprncorrect(const exprn&);
        friend int isbracecorrect(const exprn&);
        friend int isidecorrect(const exprn&);
        friend int isvaluecorrect(const exprn&);
		friend int isvalue(char);
        friend int isidentifier(char);
        friend int isoperand(char);
        friend int isoperator(char);
		exprn& operator=(exprn&);
};

exprn &exprn::operator=(exprn &x)
{
	if(exp!=0) delete []exp;
    exp=new char[strlen(x.exp)+1];
    strcpy(exp,x.exp);
    return *this;
}

exprn::exprn(const char *x,int beg,int end)
{
    int j;
	if(j=strlen(x),end<0||end<beg||end>j) end=j;
    exp=new char[end-beg+2],j=0;
    for(int i=beg;i<=end;i++) exp[j++]=x[i];
    exp[j]='\0';
}

exprn::~exprn()
{
	if(exp!=0) delete []exp;
}

int isvalue(char x)
{	if(x>='0'&&x<='9') return 1; else return 0;	}

int isidentifier(char x)
{	if(x>='A'&&x<='Z'||x>='a'&&x<='z') return 1; else return 0;	}

int isoperand(char x)
{	if(isvalue(x)||isidentifier(x)) return 1; else return 0;	}

int isoperator(char x)
{	if(x=='/'||x=='*'||x=='+'||x=='-') return 1; else return 0;	}

int exprncorrect(const exprn &e)
{
	char x=e.exp[0];

    if(x=='\0') return 0; else
    if(x=='(')  return isbracecorrect(e); else
    if(isidentifier(x)) return isidecorrect(e); else
    if(isvalue(x))      return isvaluecorrect(e); else return 0;
}

int isbracecorrect(const exprn &e)
{
	if(e.exp[0]!='(') return 0;

    int i,flg1,flg2,scope;

    for(flg1=0,scope=i=1;e.exp[i]!='\0';i++)
    {
    	if(e.exp[i]==')') --scope; else if(e.exp[i]=='(') ++scope;
        if(scope==0)
			{  flg1=1;break;	}
    }

    if(flg1==0) return 0;

    exprn br1(e.exp,1,i-1);
    flg1=exprncorrect(br1);
    if(e.exp[i+1]=='\0') flg2=1;
    else
    	if(flg2=isoperator(e.exp[i+1]),flg2==1)
          	br1=exprn(e.exp,i+2),flg2=exprncorrect(br1);

    if(flg1&&flg2) return 1; else return 0;
}


int isidecorrect(const exprn &e)
{
	if(!isidentifier(e.exp[0])) return 0;
    for(int i=1;e.exp[i]!='\0'&&isoperand(e.exp[i]);i++);
    if(e.exp[i]=='\0') return 1;
    if(!isoperator(e.exp[i])) return 0;
    exprn id(e.exp,i+1);
    return exprncorrect(id);
}


int isvaluecorrect(const exprn &e)
{
	if(!isvalue(e.exp[0])) return 0;
    for(int i=1;e.exp[i]!='\0'&&isvalue(e.exp[i]);i++);
    if(e.exp[i]=='\0') return 1;
    if(!isoperator(e.exp[i])) return 0;
    exprn val(e.exp,i+1);
    return exprncorrect(val);
}
