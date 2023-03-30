#include<stdio.h>


FILE *p;

void main()
{
void hanoni(int,char,char,char);
int n;
char so='S',te='T',de='D';

clrscr();

p=fopen("han.txt","w");
printf("Enter no of disks:\n");
scanf("%d",&n);
hanoni(n,so,te,de);
printf("\n\n\tProcedure ended");
getch();
}

void hanoni(int n,char so,char te,char de)
{
if(n!=0)
	{    hanoni(n-1,so,de,te);
		 fprintf(p,"Move disk %d from %c to %c\n",n,so,de);
		 hanoni(n-1,te,so,de);
	 }
}