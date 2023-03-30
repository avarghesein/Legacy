#include"\tc\bin\viju's\sourse\strings.c"

//-----------FUNCTIONS FOR NUMBER SYSTEM CONVERSIONS-------------//

#include<stdlib.h>
#include<stdio.h>


int biny(int x,char bny[],int m1)
{
	int count=-1,k[20],i;

	for(;x>0;x/=2) k[++count]=x%2;
	for(i=1;i<=3-count;i++) bny[m1++]='0';
	for(i=count;i>=0;i--) bny[m1++]=(k[i]==1?'1':'0');

	return(m1);
}


void convert(char c,int dec[],int i)
{
	if((c>=48&&c<=57)||(c>=65&&c<=70)||(c>=97&&c<=102))
	{
		if(c>=48&&c<=57) dec[i]=c-'0';
		else if(c>=65&&c<=70) dec[i]=c-'A'+10;
		else dec[i]=c-'a'+10;
		return;
	}
	else
		printf("\n\n\n\t\tERROR IN DATA!!!!,press any key"),getch(),exit(1);


}



double power(double x,int n)
{
	int i;
	double p;

	if(n>=0)
	{
		for(p=1,i=n;i>=1;i--) p*=x;
		return(p);
	}
	else
	{
		n=-n;
		for(p=1,i=n;i>=1;i--) p*=x;
		return((double)1/p);
	}

}


void rev(char s[],int n)
{
	int i,j;
	char s1[50];

	for(i=n-1,j=0;i>=0;i--,j++) s1[j]=s[i];
	s1[j]='\0';
	for(i=0;i<=n;i++) s[i]=s1[i];

return;
}



void oconvert(char c,int dec[],int i)
{
	if(c>=48&&c<=55)
	{	dec[i]=c-'0';
		return;
	}
	else
	printf("\n\n\n\t\tERROR IN DATA!!!!,press any key"),getch(),exit(1);
}


int obiny(int x,char bny[],int m1)
{
	int count=-1,k[20],i;

	for(;x>0;x/=2) k[++count]=x%2;
	for(i=1;i<=2-count;i++) bny[m1++]='0';
	for(i=count;i>=0;i--) bny[m1++]=(k[i]==1?'1':'0');

return(m1);
}



int chkbin(char x)
{
	if(x==48||x==49) return((x=='0'?0:1));
	else
	{
		printf("\nERROR IN DATA!!!,Press any key,Returning NULL\n\n");
		getch(),exit(1);
		return(0);
	}

}

int chkoct(char x)
{
	if(x>=48&&x<=55) return(x-48);
	else
	{
		printf("\nERROR IN DATA!!!,Press any key,Returning NULL\n\n");
		getch(),exit(1);
		return(0);
	}

}


double stod(char *x)
{
int i,j,k,m1[100],m2[100],n=strglen(x);
double s=0.00;


for(k=-1,i=0;x[i]!='\0'&&x[i]!='.';i++)
	if(x[i]>=48&&x[i]<=57)
		m1[++k]=(x[i]-'0');
	else
	{	printf("ERROR IN DATA,PRESS ANY KEY\n"),
		getch(),exit(1);
		return(0);
	}

for(j=i+1,i=-1;j<n;j++)
	if(x[j]>=48&&x[j]<=57)
		m2[++i]=(x[j]-48);
	else
	{	printf("ERROR IN DATA,PRESS ANY KEY\n"),
		getch(),exit(1);
		return(0);
	}

for(j=0;j<=k;j++) s+=m1[j]*power(10,k-j);
for(j=0;j<=i;j++) s+=m2[j]*power(10,-(j+1));

return(s);
}

