/*-----------FINDING RANK OF A STUDENT THROUGH STRUCTURES----------*/
#include<stdio.h>

struct list
{	char name[10];
	int	 m[3];
}s[30],te;

void main()
{
int n,i,j,k;
float ti,tj;
clrscr();
printf("Enter no of students:\n");
scanf("%d",&n);
printf("Enter name,3 marks of students one by one:\n\n");
for(i=0;i<n;i++)
{	scanf("%s",s[i].name);
	for(j=0;j<3;j++) scanf("%d",&s[i].m[j]);
}

for(i=0;i<n-1;i++)
{	for(ti=k=0;k<3;ti+=s[i].m[k],k++);
	for(j=i+1;j<n;j++)
	{	for(tj=k=0;k<3;tj+=s[j].m[k],k++);
		if(ti/3<tj/3) te=s[i],s[i]=s[j],s[j]=te;
	}
}
printf("\n\nThe Rank List\n\n");
printf("\nRank\tName\tmark1\tmark2\tmark3\taverage\n\n");
for(i=0;i<n;i++)
{	printf("\n%d\t%s",i+1,s[i].name);
	for(ti=k=0;k<3;ti+=s[i].m[k],k++)
		printf("\t%d",s[i].m[k]);
	printf("\t%f",ti/3);
}
getch();
}
