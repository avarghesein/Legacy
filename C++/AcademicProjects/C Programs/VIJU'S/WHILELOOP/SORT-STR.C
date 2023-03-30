#include<stdio.h>
#include<string.h>
void main()
{
int i,j,n;
char s[20][20],t[20];
clrscr();
printf("Enter no of names:\n");
scanf("%d",&n);
printf("Enter names to be sorted:\n");
for(i=0;i<n;i++) scanf("%s",s[i]);

for(i=0;i<n-1;i++)
	for(j=i+1;j<n;j++)
		if(strcmp(s[i],s[j])>0)
		{	strcpy(t,s[i]);
			strcpy(s[i],s[j]);
			strcpy(s[j],t);
		}
printf("\n\nSorted Names:\n");
for(i=0;i<n;i++) printf("\n%s",s[i]);
getch();
}