#include<string.h>
#include<stdio.h>
void main()
{
int i,j,n;
char x[20],y[20],z[20];
clrscr();
printf("Enter the string:\n");
scanf("%s",x);
strcpy(z,x);
n=strlen(x);

for(i=0;i<n;i++)
	if(isupper(x[i])) x[i]=tolower(x[i]);

for(i=n-1,j=0;i>=0;i--,j++)  y[j]=x[i];
y[j]='\0';

if(strcmp(x,y)==0) printf("\n%s is PALINDROME",z);
else printf("\n%s is NOT PALINDROME",z);

getch();
}
