#include<stdio.h>

void see(),rec(),ins(),del(),rep(),app();

typedef struct list
{	int rno;
	char nam[10];
	int mar;
}node;

FILE *p1;
node k;
int l=sizeof(node);

void main()
{
int w=1,i,n;
clrscr();
p1=fopen("a.dat","wb+");
printf("Enter number of students:");
scanf("%d",&n);
for(i=0;i<n;i++)
{   printf("\nEnter Roll-no,name,mark:");
	scanf("%d%s%d",&k.rno,k.nam,&k.mar);
	fwrite(&k,l,1,p1);
}
while(w!=6)
{	printf("\n0-append,1-see record,2-report,3-ins,4-del,5-replace,6-exit:");
	scanf("%d",&w);
	switch(w)
	{   case 0:app();break;
		case 1:see();break;
		case 2:rec();break;
		case 3:ins();break;
		case 4:del();break;
		case 5:rep();
	}
}
fclose(p1);
}

void see()
{
int ro;
rewind(p1);
printf("\nEnter roll number of the record:");
scanf("%d",&ro);
while(fread(&k,l,1,p1)==1)
	if(k.rno==ro)
	{	printf("\n%d  %s  %d\n",k.rno,k.nam,k.mar);
		return;
	}
printf("\nNot found:\n");
return;
}

void rec()
{
rewind(p1);
clrscr();
printf("\nStudent-Record\nRoll-no\tName\tMark\n");
while(fread(&k,l,1,p1)==1)
	  printf("\n%d\t%s\t%d",k.rno,k.nam,k.mar);
printf("\n");
return;
}

void ins()
{
FILE *p2;
node new1;
int flag=0;

p2=fopen("b.dat","wb+");
rewind(p1);
printf("\nEnter Roll-no,name,mark for new student:");
scanf("%d%s%d",&new1.rno,new1.nam,&new1.mar);
while(fread(&k,l,1,p1)==1)
{	if(new1.rno<=k.rno&&flag==0)
	{	   fwrite(&new1,l,1,p2);
		   flag=1;
	}
	fwrite(&k,l,1,p2);
}
if(flag==0) fwrite(&new1,l,1,p2);
fclose(p1);
fclose(p2);
remove("a.dat");
rename("b.dat","a.dat");
p1=fopen("a.dat","rb+");
return;
}

void del()
{
FILE *p2;
int flag=0,rl;

p2=fopen("b.dat","wb+");
rewind(p1);
printf("\nEnter Roll-no to delete:");
scanf("%d",&rl);
while(fread(&k,l,1,p1)==1)
{	if(rl==k.rno&&flag==0) flag=1;
	else	fwrite(&k,l,1,p2);
}
if(flag==0) printf("\nRoll no not found:\n");
fclose(p1);
fclose(p2);
remove("a.dat");
rename("b.dat","a.dat");
p1=fopen("a.dat","rb+");
return;
}

void rep()
{
int rl;
printf("\nEnter roll-no to replace:");
scanf("%d",&rl);
rewind(p1);
while(fread(&k,l,1,p1)==1)
	if(rl==k.rno)
	{	printf("\nEnter Roll-no,name,mark to replace:");
		scanf("%d%s%d",&k.rno,k.nam,&k.mar);
		fseek(p1,-l,SEEK_CUR);
		fwrite(&k,l,1,p1);
		return;
	 }
printf("\nKey not found:\n");
return;
}

void app()
{
int i,n;
fclose(p1);
p1=fopen("a.dat","ab+");
clrscr();
printf("Enter no of records to add:");
scanf("%d",&n);
for(i=0;i<n;i++)
{   printf("\nEnter Roll-no,name,mark:");
	scanf("%d%s%d",&k.rno,k.nam,&k.mar);
	fwrite(&k,l,1,p1);
}
return;
}