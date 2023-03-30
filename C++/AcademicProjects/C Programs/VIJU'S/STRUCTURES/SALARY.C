#include<stdio.h>
struct sal
{	char *name[10];
	char *dept[10];
	struct
	{	int dear;
		int hr;
		int city;
	}allow;
};
typedef struct sal node;
void main()
{
int i,n;
node p[10];
clrscr();
printf("Enter  no of persons & their name,dept,dear,hr,city-a:\n");
scanf("%d",&n);
for(i=0;i<n;i++)
scanf("%s%s%d%d%d",p[i].name,p[i].dept,&p[i].allow.dear,&p[i].allow.hr
,&p[i].allow.city);
clrscr();
printf("\n\nDetails of persons & salary:\n\n");
for(i=0;i<n;i++)
printf("%s  %s  %d\n",p[i].name,p[i].dept,p[i].allow.dear+p[i].allow.hr+
p[i].allow.city);
getch();
}