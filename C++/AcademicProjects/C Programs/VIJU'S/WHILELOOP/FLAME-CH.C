#include"\tc\bin\viju's\sourse\strings.c"

void main()
{
char m[15],fe[15],reln[7]={'f','l','a','m','e','s','\0'};
int i,j,p;
clrscr();

printf("Enter the name of male:\n"),gets(m);
printf("Enter the name of female:\n"),gets(fe);

strcase(m,'l'),strcase(fe,'l');

for(i=0;i<strglen(m);i++)
	for(j=0;j<strglen(fe);j++)
		if(m[i]==fe[j])
		{	strdel(m,i+1,i+1),strdel(fe,j+1,j+1),i--;
			break;
		}

for(i=0;i<strglen(m);i++)
	if(m[i]==' ') strdel(m,i+1,i+1);
for(j=0;j<strglen(fe);j++)
	if(fe[j]==' ') strdel(fe,j+1,j+1);
p=strglen(m)+strglen(fe);

i=0,j=1;
while(reln[1]!='\0')
{
	if(j>=p)
	{	strdel(reln,i+1,i+1),j=1;
		if(reln[i]=='\0') i=0;
	}
	else
	{	i++,j++;
		if(reln[i]=='\0') i=0;
	}
}


printf("\n\n\n");
switch(reln[0])
{
case 'f': printf("You are '*FRIENDS*'\n");
		  break;
case 'l':printf("You are in '***LOVE***'\n");
		 break;
case 'a':printf("You are in '---ANGRY---'\n");
		 break;
case 'm':printf("You got '*****MARRIAGE*****'!!!\n");
		 break;
case 'e':printf("You are '-----ENEMIES-----'\n");
		 break;
case 's':printf("You are 'BROTHER & SISTER'\n");
}

getch();
}
