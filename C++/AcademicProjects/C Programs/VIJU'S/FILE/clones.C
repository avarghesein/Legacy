

#include<stdio.h>
#include<string.h>

struct torep
{
  char val;
}t;


long fsize(char *name)
{
FILE *p=fopen(name,"rb");
long cnt=0;

    if(p==0) return 0;
    fseek(p,0,0);
    while(fread(&t,sizeof(t),1,p)) ++cnt;

fclose(p);
return cnt;
}

int copy(char *tarf,char *srcf,long start,long end)
{
FILE *p=fopen(tarf,"ab"),*q=fopen(srcf,"rb");

    if(q==0) return 0;
    fseek(q,start,0),fseek(p,0,SEEK_END);
    while(ftell(q)<=end&&fread(&t,sizeof(t),1,q)) fwrite(&t,sizeof(t),1,p);

fclose(p),fclose(q);
return 1;
}




void main()
{
char r;
char name[15];
long int s,e,sze;

 clrscr();
 printf("\nEnter NAME-OF-FILE with extension:"),scanf("%s",name);
 printf("\nEnter START-BYTE:"),scanf("%ld",&s);
 printf("\nEnter END-BYTE:"),scanf("%ld",&e);
 printf("\nEnter GROUP-SIZE:"),scanf("%ld",&sze);
 printf("\nEnter REPLACE-NUMBER in HEX(ex:AA,01,1A,00,3f,..):"),scanf("%x",&r);

 if(!make_clones(name,s,e,sze,r))
	printf("\nFailed");
 else
	printf("\nSuccess!!!"),
	printf("\n\nSize of file %s(In BYTES)=%ld",name,fsize(name));

getch();
}


int  make_clones(char *fname,long bstart,long bend,long size,char r)
{
FILE *p=fopen(fname,"rb");
long start;
long j;
char cfile[15];

    if(size<=0||bstart>bend||p==0)
    {
	fclose(p);
	return 0;
    }

    fclose(p),start=bstart;
    while(start<=bend)
    {
	sprintf(cfile,"%ld",start),remove(cfile);
	copy(cfile,fname,0,start-1);
	p=fopen(cfile,"ab"),fseek(p,0,SEEK_END);
	for(j=1,t.val=r;j<=size&&start<=bend;j++,start=ftell(p))
		fwrite(&t,sizeof(t),1,p);

	fclose(p);
	copy(cfile,fname,start,fsize(fname));
    }
return 1;
}
