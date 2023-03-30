#include<stdio.h>
struct list
{	char nam[10];
	int a;
}x;
void main()
{
int n,i;
FILE *p,*q;
clrscr();
p=fopen("mer1.txt","w+");
printf("Enter no of records for 1st file:");
scanf("%d",&n);
printf("\nEnter records for 1st file\n");
for(i=0;i<n;i++)
{
	printf("\nEnter name,age:");
	scanf("%s%d",x.nam,&x.a);
	fprintf(p,"%s %d",x.nam,x.a);
}
fclose(p);
p=fopen("mer2.txt","w+");
printf("\n\nEnter no of records for 2nd file:");
scanf("%d",&n);
printf("\nEnter records for 2nd file\n");
for(i=0;i<n;i++)
{
	printf("\nEnter name,age:");
	scanf("%s%d",x.nam,&x.a);
	fprintf(p,"%s %d",x.nam,x.a);
}
fclose(p);
p=fopen("mer1.txt","a");
q=fopen("mer2.txt","r");
fprintf(p,"\n");
while(fscanf(q,"%s%d",x.nam,&x.a)!=EOF)
	  fprintf(p,"%s %d",x.nam,x.a);
fclose(p);
fclose(q);
p=fopen("mer1.txt","r");
printf("\n\n\n\nContents in merged file\n\n");
while(fscanf(p,"%s%d",x.nam,&x.a)!=EOF)
	  printf("%s %d\n",x.nam,x.a);
fclose(p);
getch();
}