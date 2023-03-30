

#include<stdio.h>


typedef struct  {	double a,b;	}	xy;


void writefile(char *name,int n)
{
xy var;
int i;
FILE *p;

p=fopen(name,"w");

	for(i=1;i<=n;i++)
		scanf("%lf%lf",&var.a,&var.b),fwrite(&var,sizeof(var),1,p);
fclose(p);
return;
}


int readfile(char *name,double x[],double y[])
{
xy var;
int n;
FILE *p=fopen(name,"r");

for(n=0;fread(&var,sizeof(var),1,p)==1;n++) x[n]=var.a,y[n]=var.b;

return(n);
}



void writefilenormal(char *name,int n)
{
double a,b;
int i;
FILE *p;

p=fopen(name,"w");
	fprintf(p,"\n\nX\t\tY\n\n");
	for(i=1;i<=n;i++)
		scanf("%lf%lf",&a,&b),fprintf(p,"\n%lf\t%lf",a,b);

fclose(p);
return;
}


char getfilechar(FILE *p)
{ 	char c;
	while((c=fgetc(p))==' '||c=='\n'||c=='\t'||c=='\r'
	||c=='\v'||c=='\b'||c=='\f'||c=='\a');
	return(c);
}

int isdecimal(char c)
{	if(c=='+'||c=='-'||c=='.'||(c>='0'&&c<='9')) return(1); else return(0);	}


int readfilenormal(char *name,double x[],double y[])
{
char c;
int n,flag;
FILE *p=fopen(name,"r");

for(flag=n=0;(c=getfilechar(p))!=EOF;)
{   if(!isdecimal(c)) continue;
	if(flag==0) fseek(p,-1,SEEK_CUR),fscanf(p,"%lf",&x[n]),flag++; else
				fseek(p,-1,SEEK_CUR),fscanf(p,"%lf",&y[n]),flag++;
	if(flag==2) flag=0,++n;
}

fclose(p);
return(n);
}