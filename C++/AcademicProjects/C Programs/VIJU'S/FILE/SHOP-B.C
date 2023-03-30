#include<stdio.h>
struct list
{	char item[10];
	int code;
	int rate;
}a;
FILE *p1;
void main()
{
int i,n,l=sizeof(a);
clrscr();
p1=fopen("sho.txt","wb+");
printf("Enter number of items:");
scanf("%d",&n);
for(i=0;i<n;i++)
{	printf("Enter name,code,rate:");
	scanf("%s%d%d",a.item,&a.code,&a.rate);
	fwrite(&a,l,1,p1);
}

rewind(p1);
printf("\nEnter code & qnty:");
scanf("%d%d",&i,&n);
fread(&a,l,1,p1);
while(!feof(p1))
{
	if(i==a.code)
	{	printf("\n\n%s  %d  %d",a.item,a.code,a.rate);
		printf("\nTotal rate is %d",n*a.rate);
		n=-999;
		break;
	 }
	fread(&a,l,1,p1);
}
if(n!=-999) printf("\nItem not found:\n");
getch();
}