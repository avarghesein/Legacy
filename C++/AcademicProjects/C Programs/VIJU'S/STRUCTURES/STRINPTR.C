
struct sn1
{	char name[10];
	int age;
}a,*p1=&a;
struct sn2
{	struct sn1 *p2;
	char place[10];
}b,*p3=&b;

void main()
{
clrscr();
b.p2=&a;
printf("\nEnter name,age,place\n");
scanf("%s%d%s",p3->p2->name,&p3->p2->age,p3->place);
clrscr();
printf("\n\nname\tage\tplace\n");
printf("%s\t%d\t%s",p1->name,b.p2->age,b.place);
getch();
}