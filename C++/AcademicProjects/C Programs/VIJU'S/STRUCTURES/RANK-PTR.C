#include<stdio.h>

struct list
{	char name[10];
	int	 m[3],*p;
}s[30],te,*psi,*psj;

void main()
{
int n,i,j,k;
float ti,tj;
clrscr();
printf("Enter no of students:\n");
scanf("%d",&n);
printf("Enter name,3 marks of students one by one:\n\n");
for(i=0;i<n;i++)
{   psi=&s[i];
	scanf("%s",psi->name);
	for(j=0,psi->p=&psi->m[j];j<3;j++,psi->p++) scanf("%d",psi->p);
}

for(i=0;i<n-1;i++)
{   psi=&s[i];
	for(ti=k=0,psi->p=&psi->m[k];k<3;ti+=*psi->p++,k++);
	for(j=i+1;j<n;j++)
	{   psj=&s[j];
		for(tj=k=0,psj->p=&psj->m[k];k<3;tj+=*psj->p++,k++);
		if(ti/3<tj/3) te=*psi,*psi=*psj,*psj=te;
	}
}
printf("\n\nThe Rank List\n\n");
printf("\nRank\tName\tmark1\tmark2\tmark3\taverage\n\n");
for(i=0;i<n;i++)
{   psi=&s[i];
	printf("\n%d\t%s",i+1,psi->name);
	for(ti=k=0,psi->p=&psi->m[k];k<3;ti+=*psi->p++,k++)
		printf("\t%d",*psi->p);
	printf("\t%f",ti/3);
}
getch();
}
