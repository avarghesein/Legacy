
/*---------------"ATAL BIHARI BAJPEY"   TO   "A B BAJPEY" --------------*/


#include<math.h>


void sfun1(char *s,char *s1)
{

int i,j,k,flag=0,n=strlen(s);

for(i=n-1;i>=0;i--)
	if((s[i]!=' '&&s[i-1]==' ')||(i==0&&s[i]!=' '))
		if(flag==0)
		{	for(j=0,k=i;k<=n-1;k++,j++) s1[j]=s[k];
			s1[j++]=' ',flag=1;
		}
		else s1[j++]=s[i],s1[j++]=' ';

s1[j]='\0';
return;
}

void sfun2(char *s1,char *s)
{
int i,n=strlen(s1),j=0,d=n-1,k;

if(s1[n-1]!=' ')
   s1[n]=' ',s1[n+1]='\0',n++;

for(i=n-1;i>=0;i--)
	if((s1[i]!=' '&&s1[i-1]==' ')||(i==0&&s1[i]!=' '))
	{   for(k=i;k<=d;k++,j++) s[j]=s1[k];
		d=i-1;
	}

s[n]='\0';
return;
}



void main()
{
char s[100],s1[100];
clrscr();

printf("Enter the string:\n\n");
gets(s);

		sfun1(s,s1);
		sfun2(s1,s);

printf("\n\n\nFormatted string:\n\n\t\t");
puts(s);

getch();
}