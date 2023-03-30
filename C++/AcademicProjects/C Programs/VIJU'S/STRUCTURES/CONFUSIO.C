struct sn1
{	char name[10];
	int age;
	struct sn1 *p;
}a,b,*c;

void main()
{
a.p=&a;
c=&a;
clrscr();
printf("Enter name,age:\n");
scanf("%s%d",a.p->name,&a.p->age);
clrscr();
printf("\n\nname=%s,age=%d\n\n",c->p->name,c->p->p->p->p->age);
printf("\n\n\naddr(a)=%d,addr(a)=%d",&a,c->p);
getch();
}