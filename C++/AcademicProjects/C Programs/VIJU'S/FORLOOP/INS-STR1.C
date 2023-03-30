/*----------INSERTING ONE STRING TO ANOTHER FROM A GIVEN POSITION----*/

#include<stdio.h>
#include<string.h>
void main()
{
char p[20],p1[20];
int i,j,n,n1,a;
clrscr();

printf("Enter string:\n");
gets(p);
printf("Enter 2nd-string to insert:\n");
gets(p1);
printf("Enter position to insert the sub-string:\n");
scanf("%d",&a);

a-=1;
n=strlen(p);
n1=strlen(p1);
for(i=0;i<n1;i++)
{	for(j=n;j>=a;j--)p[j+1]=p[j];
	p[a]=p1[i];
     n++;
     a++;
}
printf("\n\nThe inserted string:\n");
puts(p);
getch();

}
