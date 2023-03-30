

// WordTest.cpp : Defines the entry point for the console application.
//


#include "stdafx.h"


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <conio.h>


  char *nam[]={  "\0"                ,
	             "\0"                ,
			     " hundred and "     ,
			     " thousand and "    ,
			     " thousand and "    ,
		         " lakh and "        ,
			     " lakh and "        ,
			     " crore and "       ,
			     " crore and "
			  };


  void combine(char **x,char *y)
  {
      char *tmp;

      strcpy((tmp=(char*)malloc(strlen(((char*)(*x)))+1)),((char*)(*x)));
      (char*)(*x)=(char*)realloc(((char*)(*x)),strlen(((char*)(*x)))+strlen(y)+1);
      strcpy(((char*)(*x)),tmp),free(tmp),strcat(((char*)(*x)),y);

      return;
  }

  void zero_nine(int dgt,char **x)
  {
	switch (dgt)
	{
		case 0:combine(x,"\0");return;
		case 1:combine(x,"one");return;
		case 2:combine(x,"two");return;
		case 3:combine(x,"three");return;
		case 4:combine(x,"four");return;
		case 5:combine(x,"five");return;
		case 6:combine(x,"six");return;
		case 7:combine(x,"seven");return;
		case 8:combine(x,"eight");return;
		case 9:combine(x,"nine");return;
	}
  }

void ten_nineteen(int dgt,char **x)
{
	switch (dgt)
	{
		case 10:combine(x,"ten");return;
		case 11:combine(x,"eleven");return;
		case 12:combine(x,"twelve");return;
		case 13:combine(x,"thirteen");return;
		case 14:combine(x,"fourteen");return;
		case 15:combine(x,"fifteen");return;
		case 16:combine(x,"sixteen");return;
		case 17:combine(x,"seventeen");return;
		case 18:combine(x,"eighteen");return;
		case 19:combine(x,"nineteen");return;
	}
}

void twenty_ninty(int dgt,char **x)
{
	switch (dgt)
	{
		case 2:combine(x,"twenty");return;
		case 3:combine(x,"thirty");return;
		case 4:combine(x,"fourty");return;
		case 5:combine(x,"fifty");return;
		case 6:combine(x,"sixty");return;
		case 7:combine(x,"seventy");return;
		case 8:combine(x,"eighty");return;
		case 9:combine(x,"ninty");return;
	}
}

void create_word(int[],int,char**);

int GetStringAboveCrore(int Position,int intDgtCnt,char **chrdblptrStringBuilting,int *chrptrDgts,char *StrToAttach)
{
	if(Position>intDgtCnt) return intDgtCnt;

	int flg1=0,j,k,n,*chrptrDgtRemains=new int[intDgtCnt-Position+1];

	for(n=intDgtCnt-Position,k=-1,j=Position;j<=intDgtCnt;j++) 
		chrptrDgtRemains[++k]=chrptrDgts[j],flg1=flg1?1:chrptrDgts[j]!=0?1:0;

	if(flg1) create_word(chrptrDgtRemains,n,chrdblptrStringBuilting),
			 combine(chrdblptrStringBuilting,StrToAttach);

	try { delete chrptrDgtRemains; } catch(...) {}

	return (Position-1);
}

void create_word(int part[],int m,char **x)
{
char tmpc[6];
int flg1,j,k,i,n;

	if(m<0||!m&&!part[0]) { combine(x,"ZERO"); return;	}

	i=m;

	while(i>=0)
	{
	     if(i>=12) i=GetStringAboveCrore(12,i,x,part," trillion and ");
		 if(i>=9)  i=GetStringAboveCrore( 9,i,x,part," billion and " );

	     if(i>2)
	     {
			if(!(i%2))
				if(part[i]==1)
				{
					ten_nineteen(part[i]*10+part[i-1],x),combine(x,nam[i]),i-=2;
					continue;
				}
				else
					if(part[i])
						if(twenty_ninty(part[i],x),!part[i-1])
						{
							combine(x,nam[i]),i-=2;
							continue;
						}
						else  --i;
					else --i;

			if(i%2)
				if(part[i])	zero_nine(part[i],x),combine(x,nam[i]),--i; else --i;
	     }
	     if(i==2)
			if(part[i])
				zero_nine(part[i],x),combine(x,nam[i]),i--; else --i;

		if(i==1)
			if(part[i]==1)
			{
				ten_nineteen(part[i]*10+part[i-1],x),i-=2;
				continue;
			}
			else
				if(part[i])	twenty_ninty(part[i],x),i--; else --i;

		if(i==0)
			if(part[i]!=0) zero_nine(part[i],x),i--; else i--;
	}

if(strcpy(tmpc,&(((char*)(*x))[strlen(((char*)(*x)))-4])),!strcmp(tmpc,"and ")) ((char*)(*x))[strlen(((char*)(*x)))-4]='\0';
return;
}

int find_dot_offset(char *x)
{
int i;

	for(i=0;i<=strlen(x);i++)
		if(x[i]=='.') return i;

return -1;
}

void removespace(char *z)
{
char h[800],i,n,j;
	
	for(n=strlen(z),i=0,j=0;i<n;i++)
		if(z[i]!=' ') h[j++]=z[i];

	h[j]='\0',strcpy(z,h);

return;
}


void convert_number_to_word(double num,char **intpart,char **realpart,char *StrNumber=0)
{
char tmp[800],tmp1[800]="\0";
int part[800],m,i,j;

	if(!StrNumber)
		sprintf(tmp,"%lf",num);
	else 
		strcpy(tmp,StrNumber);

	if (removespace(tmp),i=find_dot_offset(tmp),i!=-1) 
		strcpy(tmp1,&tmp[i+1]),tmp[i]='\0';

	for(m=strlen(tmp)-1,i=0,j=m;j>=0;j--,i++) 
		part[i]=(int)((int)tmp[j]-48);
	
	create_word(part,m,intpart);

	while(m=strlen(tmp1),tmp1[m-1]=='0') tmp1[m-1]='\0';

	for(m=strlen(tmp1)-1,i=0,j=m;j>=0;j--,i++) 
		part[i]=(int)((int)tmp1[j]-48);
	
	create_word(part,m,realpart);

	return;

}

int _tmain(int argc, _TCHAR* argv[])
{
	char *x=(char*)malloc(1),*y=(char*)malloc(1);
	double xy=0;
	//clrscr();
	x[0]=y[0]='\0';

	#define STG 1

	#ifdef STG
		{
			char StrNum[1000];
			printf("\nEnter number:"),scanf("%s",StrNum);
			convert_number_to_word(xy,&x,&y,StrNum);
		}
	#else
		{
			printf("\nEnter number:"),scanf("%lf",&xy);
			convert_number_to_word(xy,&x,&y);
		}
	#endif

	printf("\n\n%s",x),printf("\n\n%s",y);
	getch();
	return 0;
}

