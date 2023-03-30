

#include<math.h>
#include<string.h>
#include<stdio.h>


extern   char 			   renfile1file2(char*,char*);
extern   void 			   reverse(char[]);
extern   unsigned long     hex1tohex2(FILE*,FILE*);
extern   void 			   opening1(char*,char*);
extern   void              dectohex(unsigned,char[]);
extern   int               test(char,char,char*);
extern   int               commatest(char,char,char);
extern   char              getfilechar(FILE*);


int removeandexit(char *p)
{
if(fileexsist(p)) remove(p),exit();
else exit();
return(1);
}


int fileexsist(char *x)
{
FILE *p=fopen(x,"r");

	if(p==0) return(0); else
	{
	   //	if(fgetc(p)==EOF)
		//{   fclose(p);
		 //	remove(x);
		  //	return(0);
	  //	}
		fclose(p);
		return(1);
	}
}



char renfile1file2(char *x,char *y)
{
char c;
FILE *p=fopen(x,"r"),*q;

if(p!=0)
{   q=fopen(y,"r"),fclose(p);

	if(q==0) rename(x,y),c='y';
	else
	{   fclose(q);
		printf("\n\nOVER WRITE %s (Y/N):",y),flushall(),scanf("%c",&c);
		if(c=='Y'||c=='y'||c=='\n') remove(y),rename(x,y),c='y';
		else remove(x),c='n';
	}
}
else
	printf("\n\nError occured in removing & renaming the file\n"),
	printf("FILE %s not exsists",x),getch(),c='n';

return(c);
}



void opening1(char *x,char *y)
{
char *temp="noothers.txt";
FILE *p,*q;


	if((p=fopen(x,"r"))==0)
	{   if(fileexsist(temp)) remove(temp);
		clrscr(),printf("\n\nFILE not found (%s)\n\n",x),getch(),exit();
	}
	q=fopen(temp,"w");

	printf("\n\n%ld normal charecters (after ommitting commas) in the formatted form",hex1tohex2(p,q));

	renfile1file2(temp,y);

	if(fileexsist(temp)) remove(temp);
	return;
}





char getfilechar(FILE *p)
{ 	char 	c;
	while((c=fgetc(p))==' '||c=='\n'||c=='\t'||c=='\r'||c=='\v');
	return(c);
}





unsigned long hex1tohex2(FILE *p,FILE *q)
{
unsigned long totchar=0;
unsigned count;
int i;
char c1,c2,c3,c4,x[25],y;

	c1=getfilechar(p),c2=getfilechar(p);
	while(c1!=EOF&&c2!=EOF)
	{	c3=getfilechar(p),c4=getfilechar(p),count=1;
		while(c3!=EOF&&c4!=EOF&&(c1==c3&&c2==c4))
			++count,c3=getfilechar(p),c4=getfilechar(p);


		if(count>1)
		{   dectohex(count,x);
			if(test(c1,c2,&y)) fputc(y,q); else fputc(c1,q),fputc(c2,q);
			for(i=0;x[i]!='\0';i++)  fputc(x[i],q);
		}
		else
			if(test(c1,c2,&y)) fputc(y,q); else fputc(c1,q),fputc(c2,q);

	   if(commatest(c1,c2,c3)) fputc(',',q),++totchar;


	   c1=c3,c2=c4;
	}
	if(c1!=EOF) fputc(c1,q);

	totchar=ftell(q)-totchar;

	fclose(p),fclose(q);

return(totchar);
}



//----------------------------------------------------------------------//

void reverse(char x[])
{
int i,j,n=strlen(x);
char y[25];

	 n-=1;
	 for(strcpy(y,x),j=n,i=0;i<=n;i++,j--) x[i]=y[j];
	 x[i]='\0';

return;
}



void dectohex(unsigned dec,char x[])
{
unsigned k;
int i=-1;

	while(dec>0)
		k=dec%16,x[++i]=(k>9?k-10+65:k+48),dec/=16;
	x[++i]='\0';
	reverse(x);
return;
}



int test(char c1,char c2,char *y)
{
if((c1=='0'&&c2=='0')||(c1=='f'&&c2=='f')||(c1=='F'&&c2=='F'))
{	*y=(c1=='0'?'y':'z');
	return(1);
}
else return(0);
}


int commatest(char c1,char c2,char c3)
{
if(c1==EOF||c2==EOF||c3==EOF) return(0); else return(1);
}



 //----------------------------------------------------------------------//




