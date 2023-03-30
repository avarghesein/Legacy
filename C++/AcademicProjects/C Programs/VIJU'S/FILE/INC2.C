

#include "\tc\bin\viju's\file\inchex.c"


void checkxsist(char *p)
{
if(!fileexsist(p))
	printf("\n\nSourse file %s not exsist\n",p),getch(),exit();
return;
}

void disbit(unsigned long x)
{
unsigned long y=1,l;
int i;
for(i=31;i>=0;i--) l=x&(y<<i),printf("%d",l>>i);
printf("\n");
}




int editable(char c)
{ 	if(c==' '||c=='\n'||c=='\t'||c=='\r'||c=='\v') return(0);
	else return(1);
}


int isalphabet(char c)
{	if((c>=65&&c<=90)||(c>=97&&c<=122)) return(1); else return(0);	}

unsigned long findkey(char *x)
{
unsigned long m=0,p=1;
int i;
	for(reverse(x),i=0;x[i]!='\0';p*=2,i++) m+=(x[i]-33)*p;
return(m);
}



void coded_encoded(char *p,char *q)
{
char *temp="noothers.txt";
char c;
FILE *x,*y;

checkxsist(p);

x=fopen(p,"r"),y=fopen(temp,"w");

while((c=fgetc(x))!=EOF)
	 if(isalphabet(c)) if(islower(c)) fputc(219-c,y); else fputc(155-c,y);
	 else if(isdigit(c)) fputc(105-c,y);else fputc(c,y);

fclose(x),fclose(y);

renfile1file2(temp,q);

if(fileexsist(temp)) remove(temp);

return;
}



//-------------------------------------------------------------------------//
char encriptsub(unsigned long c,unsigned long key)
{	return((char)(c^key));	}




//-------------xoring with key direct example

void decode(char *p,char *q,char *code)
{
unsigned long result,read,k,con,m,key=findkey(code);
int i;
char *temp="noothers.txt";
char c;
FILE *x,*y;

if(!fileexsist(p))
{   if(fileexsist(temp)) remove(temp);
	printf("\n\nSourse file %s not exsist\n",p),getch(),exit();
}
x=fopen(p,"r"),y=fopen(temp,"w");

while(fscanf(x,"%c",&c)==1)
{   read=(unsigned long)c;
	result=0;
	for(i=31;i>=0;i--)
	{   con=1;
		con<<=i;
		k=(key&con);
		if((k>>i)==1) m=(~read); else m=read;
		m&=(con);
		result|=m;
	}
	fputc((char)result,y);
}

fclose(x),fclose(y);

renfile1file2(temp,q);

if(fileexsist(temp)) remove(temp);

return;
}


