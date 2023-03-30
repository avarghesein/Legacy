#include<stdio.h>
#include<stdlib.h>
void main()
{
int *p,*p1;
int n;
clrscr();
printf("Enter the size:\n");
scanf("%d",&n);
p=(int *)malloc(sizeof(int)*n);
if(p==0)
{	printf("No space available:\n");
	exit(1);
}
printf("Enter values:\n");
for(p1=p;p1<p+n;p1++) scanf("%d",p1);
printf("\nValues:\n\n");
for(p1=p+n-1;p1>=p;p1--)
printf("%d is stored in address %d\n",*p1,p1);
free(p);
free(p1);

getch();
}
