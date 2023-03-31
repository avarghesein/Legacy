

#include<string.h>

#include "\tc\bin\ds\inc\prefix.c"


int strcpysub(char *dst,char *src,int llmt,int hlmt)
{
int j,i;
char x[50];
	if(llmt>hlmt||llmt<0||hlmt>strlen(src))
	{
		dst[0]='\0';
		return(0);
	}
	for(j=0,i=llmt;i<=hlmt;i++,j++) x[j]=src[i];
	x[j]='\0';
	strcpy(dst,x);

return(1);
}



int lenofmaxprefix(char *pre)
{
char x[50],y[50];
int m,n;

	if(strlen(pre)==0) return(0);

	if(isoperand(pre[0])) return(1);
	else
	{
		strcpysub(x,pre,1,strlen(pre)-1);
		if(strlen(x)<2) return(0);
		else m=lenofmaxprefix(x);
	}

	strcpysub(y,x,m,strlen(x)-1);

	n=lenofmaxprefix(y);

	return(1+m+n);
}

//--------------------prefix==>postfix----------------------//


int pretopos(char *pre,char *pos)
{
char op1[50],op2[50],pos1[50],pos2[50],x[2],tmp[50];
int m,n,valid;

	if((m=strlen(pre))==0) return(0);
	if(m==1)
		if(!isoperand(pre[0])) return(0);
		else
		{
			strcpy(pos,pre);
			return(1);
		}

	if(isoperand(pre[0])) return(0);

	x[0]=pre[0],x[1]='\0';

	strcpysub(tmp,pre,1,m-1);
	valid=(n=lenofmaxprefix(tmp));
	strcpysub(op1,tmp,0,n-1);

	strcpysub(tmp,pre,n+1,m-1);
	valid+=(n=lenofmaxprefix(tmp));
	strcpysub(op2,tmp,0,n-1);

	if(1+valid!=strlen(pre)) return(0);

	if(!pretopos(op1,pos1)||!pretopos(op2,pos2)) return(0);

	strcpy(pos,pos1),strcat(pos,pos2),strcat(pos,x);

	return(1);
}

//------------------------------------------------------------//

int lenofmaxpostfix(char *x)
{
int m1,m2,n=strlen(x);
char y[30];

	if(n==0) return(0); else
	if(isoperand(x[n-1])) return(1); else
	{
		strcpysub(y,x,0,n-2);
		m1=lenofmaxpostfix(y);
	}
	strcpysub(y,x,0,n-m1-2);
	m2=lenofmaxpostfix(y);
	return(1+m1+m2);
}

//--------------------postfix==>prefix---------------------------//

int posttopre(char *pos,char *pre)
{
char tmp[30],x[2],op1[30],op2[30],pre1[30],pre2[30];
int n=strlen(pos),n1,n2;

	if(n==0) return(0); else
	if(n==1)
		if(isoperand(pos[0]))
		{
			pre[0]=pos[0],pre[1]='\0';
			return(1);
		}
		else return(0);

	if(isoperand(pos[n-1])) return(0);
	x[0]=pos[n-1],x[1]='\0';

	strcpysub(tmp,pos,0,n-2);
	n1=lenofmaxpostfix(tmp);
	strcpysub(tmp,pos,0,n-n1-2);
	n2=lenofmaxpostfix(tmp);

	if(1+n1+n2!=n) return(0);

	strcpysub(op1,pos,0,n2-1);
	strcpysub(op2,pos,n2,n-2);
	if(!posttopre(op1,pre1)||!posttopre(op2,pre2)) return(0);

	strcpy(pre,x),strcat(pre,pre1),strcat(pre,pre2);

	return(1);
}

//-----------prefix==>infix----------------------------------------//

int pretoin(char *pre,char *in)
{
char op1[50],op2[50],in1[50],in2[50],x[2],tmp[50];
int m,n,valid;

	if((m=strlen(pre))==0) return(0);
	if(m==1)
		if(!isoperand(pre[0])) return(0);
		else
		{
			strcpy(in,pre);
			return(1);
		}

	if(isoperand(pre[0])) return(0);

	x[0]=pre[0],x[1]='\0';

	strcpysub(tmp,pre,1,m-1);
	valid=(n=lenofmaxprefix(tmp));
	strcpysub(op1,tmp,0,n-1);

	strcpysub(tmp,pre,n+1,m-1);
	valid+=(n=lenofmaxprefix(tmp));
	strcpysub(op2,tmp,0,n-1);

	if(1+valid!=strlen(pre)) return(0);

	if(!pretoin(op1,in1)||!pretoin(op2,in2)) return(0);

	strcpy(in,"("),strcat(in,in1),strcat(in,x),strcat(in,in2),strcat(in,")");

	return(1);
}


//-----------------postfix==>infix-----------------//

int posttoin(char *pos,char *in)
{
char tmp[30],x[2],op1[30],op2[30],in1[30],in2[30];
int n=strlen(pos),n1,n2;

	if(n==0) return(0); else
	if(n==1)
		if(isoperand(pos[0]))
		{
			in[0]=pos[0],in[1]='\0';
			return(1);
		}
		else return(0);

	if(isoperand(pos[n-1])) return(0);
	x[0]=pos[n-1],x[1]='\0';

	strcpysub(tmp,pos,0,n-2);
	n1=lenofmaxpostfix(tmp);
	strcpysub(tmp,pos,0,n-n1-2);
	n2=lenofmaxpostfix(tmp);

	if(1+n1+n2!=n) return(0);

	strcpysub(op1,pos,0,n2-1);
	strcpysub(op2,pos,n2,n-2);
	if(!posttoin(op1,in1)||!posttoin(op2,in2)) return(0);

	strcpy(in,"("),strcat(in,in1),strcat(in,x),strcat(in,in2),strcat(in,")");

	return(1);
}


//--------------Eliminating unneccessory brackets in infix-----------//

int compact_commas(char *in)
{
stk t1,t2;
char symb;
int i,n=strlen(in),flg,pflg,scope;
t1.top=t2.top=-1;

	if(!expcorrect(in)) return(0);

	n=strlen(in)-1;

	while(n>=0)
	{
		while(in[n]!='('&&n>=0) push(in[n--],&t1);

		symb='x',scope=0;
		while(!stkempty(&t1)&&((symb=pop(&t1))!=')'||scope!=0))
			if(push(symb,&t2),symb=='(') scope++; else
			if(symb==')') --scope; else continue;

		if(symb==')') push(symb,&t2);

		if(stkempty(&t1)&&n<=0) flg=0; else
			if(!stkempty(&t1)&&n>0)
				if(isoperator(symb=t1.a[t1.top])) flg=1;
				else  symb=in[n-1],flg=2;
			else
				if(stkempty(&t1)) symb=in[n-1],flg=2;
				else symb=t1.a[t1.top],flg=1;

		if(!isoperator(symb)) flg=0;

		if(flg==0)
			if(!stkempty(&t2))
				if(t2.a[t2.top]==')') pop(&t2);

		if(flg==1||flg==2)
			for(pflg=0,i=0;i<t2.top;i++)
			{
				if(t2.a[i]=='(') ++scope; else
				if(t2.a[i]==')') --scope;

				if(scope==0)
					if(isoperator(t2.a[i]))
						if(ishighpriority(t2.a[i],symb)) continue;
						else
						{	pflg=1;
							break;
						}
			 }

		if((flg==1||flg==2)&&pflg==0)  pop(&t2);
		while(!stkempty(&t2)) push(pop(&t2),&t1);
		if((flg==1||flg==2)&&pflg==1) push(in[n],&t1);

		--n;
	}

	for(i=0;!stkempty(&t1);i++) in[i]=pop(&t1);
	in[i]='\0';

return(1);
}



int ishighpriority(char op1,char op2)
{

switch(op1)
  {	 case '$':
	 case '/':
	 case '*':if(op2=='$') return(0);
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



