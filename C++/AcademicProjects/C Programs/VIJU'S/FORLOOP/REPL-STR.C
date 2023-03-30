
/*--------REPLACING A PORTION OF A STRING WITH OTHER----------*/

#include<stdio.h>
#include<string.h>
void main()
{
char p[20],p1[20];
int i,n1,n2,a;
clrscr();

printf("Enter string:\n");
gets(p);
printf("Enter 2nd-string for replace:\n");
gets(p1);
printf("Enter position to replace:\n");
scanf("%d",&a);

a-=1;
n1=strlen(p1);
n2=strlen(p);
for(i=0;i<n1;i++)
{
	p[a]=p1[i];
	a++;
}
if(a>n2) p[a]='\0';

printf("\n\nThe REPLACED string:\n");
puts(p);
getch();

}
