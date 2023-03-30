#include<stdio.h>

struct marks
{	int sub1;
	int sub2;
	int sub3;
	int total;
};
void main()
{
int i;
static struct marks student[3]={	{45,67,81,0},
							{75,53,69,0},
							{57,36,71,0}	};
static struct marks total;
clrscr();

for(i=0;i<3;i++)
{	student[i].total=student[i].sub1+student[i].sub2+student[i].sub3;
	total.sub1+=student[i].sub1;
	total.sub2+=student[i].sub2;
	total.sub3+=student[i].sub3;
	total.total+=student[i].total;
}
printf("Student			Total\n");
for(i=0;i<3;i++)
printf("student[%d]		%d\n",i+1,student[i].total);
printf("\n\nsubject        Total\n\n");
printf("subject1	%d\nsubject2	%d\nsubject3	%d\n",total.sub1,
total.sub2,total.sub3);
printf("\nGrand Total=%d\n",total.total);
getch();
}