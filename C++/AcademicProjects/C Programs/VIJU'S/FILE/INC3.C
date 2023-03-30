

#include "\tc\bin\viju's\file\inc2.c"

#define T 4294967295


int countchars(char *p,unsigned long *x)
{
FILE *tmp;
int k,flag=0;
unsigned long i;

checkxsist(p);

tmp=fopen(p,"r");

	*x=0,k=-1,i=0;
	while(fgetc(tmp)!=EOF)
		if(i==T) ++k,i=flag=0,*x=T; else ++i,flag=1;

	if(flag==1) ++k,*x=i;

fclose(tmp);

return(k);
}


void initialsetup(FILE *p,int n,unsigned long *x)
{
	fprintf(p,"%d\n%ld\n",n,*x);
return;
}

int readinitialsetup(FILE *p,unsigned long *x)
{
int n;
	 fscanf(p,"%d%*c%ld%*c",&n,x);
return(n);
}


void encriptnew(char *p,char *q,char *code)
{
unsigned long key=findkey(code),a;
int i=countchars(p,&a);
char *temp="noothers.txt";
char c;
FILE *x,*y;

checkxsist(p);

x=fopen(p,"r"),y=fopen(temp,"w");

initialsetup(y,i,&a);
while((c=fgetc(x))!=EOF)
	 c=encriptsub((unsigned long)c,key),fputc(c,y);

fclose(x),fclose(y);

if(renfile1file2(temp,q)=='n') exit();

if(fileexsist(temp)) remove(temp);

return;
}



void decriptnew(char *p,char *q,char *code)
{
unsigned long key=findkey(code),a,j,tmp;
int i,n;
char *temp="noothers.txt";
char c;
FILE *x,*y;

checkxsist(p);

x=fopen(p,"r"),y=fopen(temp,"w");

n=readinitialsetup(x,&a);

for(i=0;i<=n;i++)
	for(tmp=(i==n?a:T),j=1;j<=tmp;j++)
	  c=fgetc(x),c=encriptsub((unsigned long)c,key),fputc(c,y);

fclose(x),fclose(y);

if(renfile1file2(temp,q)=='n') exit();

if(fileexsist(temp)) remove(temp);

return;
}


int filesequal(char *p,char *q)
{
FILE *i,*j;
char c1,c2;
	checkxsist(p),checkxsist(q);
	i=fopen(p,"r"),j=fopen(q,"r");
	while(c1=fgetc(i),c2=fgetc(j),c1!=EOF&&c2!=EOF)
			if(c1==c2) continue; else
			{	fclose(i),fclose(j);return(0);  }

	fclose(i),fclose(j);
	if( (c1==EOF&&c2!=EOF)||(c1!=EOF&&c2==EOF) ) return(0);
	else return(1);
}
