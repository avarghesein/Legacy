/*---------REVERSING A STRING-------*/

#include<stdio.h>
#include<string.h>
void main()
{
char s[20];
int i,k,h;
clrscr();
printf("Enter the string:\n");
scanf("%s",s);
i=0;
do
{	if(s[i]=='\0')break;
	i++;
}while(i<20);
k=i-1;
h=0;
do
{	for(i=k;i>=h;i--)s[i+1]=s[i];
	s[h]=s[k+1];
     h++;
}while(h<=k);
s[k+1]='\0';
printf("\nREVERSED STRING:\n");
printf("%s",s);
getch();
}