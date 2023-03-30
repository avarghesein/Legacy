/*-------Structures with in structures----------*/
#include<stdio.h>

struct sn1
{	char name[10];
	int age;
}b;
struct sn2
{	struct sn1 a;
	char place[10];
	int ph;
}c;
struct sn3
{	struct sn2 x;
	int pin;
}y;

void main()
{
clrscr();
printf("Enter name,age,place,ph-no,pin:\n");
scanf("%s%d%s%d%d",y.x.a.name,&y.x.a.age,y.x.place,&y.x.ph,&y.pin);
clrscr();
printf("\n\nname\tage\tplace\tph-no\tpin:\n");
printf("%s\t%d\t%s\t%d\t%d\t",y.x.a.name,y.x.a.age,y.x.place,y.x.ph,y.pin);
getch();
}