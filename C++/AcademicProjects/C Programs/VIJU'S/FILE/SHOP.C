#include<stdio.h>

	char item[10];
	int code;
	int rate;

FILE *p1;
void main()
{
int i,n;
clrscr();
p1=fopen("sho.txt","r+");
printf("Enter number of items:");
scanf("%d",&n);
for(i=0;i<n;i++)
{	printf("\nEnter name,code,rate:");
	scanf("%s%d%d",item,&code,&rate);
	fprintf(p1,"%s %d %d\n",item,code,rate);
}

rewind(p1);
printf("\nEnter code & qnty:");
scanf("%d%d",&i,&n);
fscanf(p1,"%s%d%d",item,&code,&rate);
while(!feof(p1))
{	if(i==code)
	{	printf("\n\n%s  %d  %d\n",item,code,rate);
		printf("\nTotal rate is %d",n*rate);
		n=-999;
		break;
	 }
	 fscanf(p1,"%s%d%d",item,&code,&rate);
}
if(n!=-999) printf("\nItem not found:\n");
getch();
}