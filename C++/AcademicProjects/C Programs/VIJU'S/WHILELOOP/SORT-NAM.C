#include<stdio.h>
#include<string.h>
void main()
{
char s[20][20],t[20];
int n,i,j,k;
clrscr();
printf("Enter no of strings:\n");
scanf("%d",&n);
printf("Enter the strings:\n");
for(i=0;i<n;i++) scanf("%s",&s[i][0]);

for(i=0;i<n-1;i++)
	for(j=i+1;j<n;j++)
	{	k=0;
		while(s[i][k]!='\0'||s[j][k]!='\0')
		{   if(s[i][k]==s[j][k]) k++; else
			if((s[i][k]>s[j][k])||s[j][k]=='\0')
			{	strcpy(t,s[i]);
				strcpy(s[i],s[j]);
				strcpy(s[j],t);
				break;
			}else break;
		}
	}
printf("\n\nsorted names:\n\n");
for(i=0;i<n;i++)
	{	printf("%s",s[i]);
		printf("\n");
	}
getch();
}