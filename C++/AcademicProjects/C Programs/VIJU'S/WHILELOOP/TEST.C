#include"inc3.c"
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
		if(strcomp(s[i],s[j])>0)
		{	strcopy(s[i],t);
			strcopy(s[j],s[i]);
			strcopy(t,s[j]);
		}
printf("\n\nSorted Names:\n");
for(i=0;i<n;i++) printf("\n%s",s[i]);
getch();
}