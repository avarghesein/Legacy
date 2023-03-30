/*---------CONVERSION LIKE 'DEPAUL COLLEGE' TO 'COLLEGE DEPAUL'----*/

#include<stdio.h>
#include<string.h>
void main()
{
char p[50],p1[50];
int i,n,s,d,k;
clrscr();

	printf("Enter string:");
	gets(p);
	n=strlen(p);
	if(p[n-1]!=' ')	 p[n]=' ',p[n+1]='\0',n+=1;


	s=0,d=n-1;
	for(i=n-1;i>=0;i--)
		 if((p[i]!=' '&&p[i-1]==' ')||(i==0&&p[0]!=' '))
		 {	  for(k=i;k<=d;k++,s++)
				  p1[s]=p[k];
			  d=i-1;
		 }

	p1[n]='\0';

	printf("\n\nFormatted String\n\n");
	puts(p1);
	getch();
}