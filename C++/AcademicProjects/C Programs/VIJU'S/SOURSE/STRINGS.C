
#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<math.h>
#include<string.h>
/*---------------FINDING LENGTH OF STRING-------------*/
int strglen(char x[])
{
int k=-1;
while(x[++k]!='\0');
return(k);
}

/*----------FINDING SUB-STRING IN A STRING------------*/
int strsub(char p[],char p1[])
{
int k1,k2,i,j,r,flag;

k1=strglen(p);
k2=strglen(p1);
for(i=0;i<k1;i++)
{	if(p[i]==p1[0])
		for(j=0,r=i;j<k2;j++,r++)
		{	if(p1[j]!=p[r]) break;
			if(j==k2-1)
			   flag=1,i=k1-1;
		}
}
if(j!=k2) flag=0;
return(flag);
}

/*--------COPIES STRING SOURCE TO DESTINATION----------*/
void strcopy(char *source,char *target)
{	while((*(target++)=*(source++))!='\0');	}

/*-------INSERTING ONE STRING INTO ANOTHER(T->S)-----*/
void strins(char s[],char t[],int i)
{
extern int strglen(char[]);
int j,n;

i-=1,n=strglen(s);
while(*t!='\0')
{
for(j=n;j>=i;j--) *(s+j+1)=*(s+j);

*(s+j+1)=*t++,i++,n++;
}
}

/*---------DELETING A PORTION OF A STRING-----------*/
void strdel(char s[],int i,int j)
{
int k;
if(i<=j)
{
	if(j>strglen(s)) j=strglen(s);
	i-=1;
	for(k=i;k<=strglen(s);k++)
	   if((*(s+k)=*(s+(j++)))=='\0') break;
}
}


/*----------ex:"wel 1998,bye 1997 hai 2000" TO ARRAY OF 3(j) NUMBERS AS
	   (ARRAY ELEMENTS)	1998,1997,2000-----------------------*/
int strtono(char s[],int d[])
{
int i,j,flag,m;
i=0;flag=0;j=0;d[j]=0;
while(s[i]!='\0')
{	if(s[i]>=48&&s[i]<=57)
	   flag=1,m=s[i]-'0',d[j]=d[j]*10+m;
	else if(flag==1)
	   j++,d[j]=0,flag=0;

	i++;
}
return(j);
}

/*----------NUMBER STRING  TO DIGIT--ex:"1991" TO 1991----*/
int strtodi(char s[])
{
int m,i=0,b=0;

while(s[i]!='\0')
	m=s[i]-'0',b=b*10+m,i++;

return(b);
}

/*----------------COMPARE 2 STRINGS------------*/
int strcomp(char s1[],char s2[])
{
int i=0;

while(s1[i]!='\0'||s2[i]!='\0')
	if(s1[i]==s2[i]) i++;
	else return(s1[i]-s2[i]);
return(0);
}

//-----------------LOWER,UPPER MANIPULATION--------------------------------//
int islowerc(char c)
{
	if(c>=97&&c<=122) return(1); else return(0);
}

int isupperc(char c)
{
	if(c>=65&&c<=90) return(1); else return(0);
}

char tolowerc(char c)
{
	if(isupperc(c)) return(c+32); else return(c);
}

char toupperc(char c)
{
	if(islowerc(c)) return(c-32);  else return(c);
}

//-----------------------------------------------------------------------//


/*----CHANGING CASE OF A STRING TO EITHER LOWER OR UPPER-------*/

void strcase(char s[],char flag)
{
int i;
if(flag=='u'||flag=='U')
{	i=0;
	while(s[i]!='\0')
	{	if(islowerc(s[i])) s[i]=toupperc(s[i]);
		i++;
	}
}
else
{	i=0;
	while(s[i]!='\0')
	{	if(isupperc(s[i])) s[i]=tolowerc(s[i]);
		i++;
	}
}
}


//-----------------------------------------------------------------------//