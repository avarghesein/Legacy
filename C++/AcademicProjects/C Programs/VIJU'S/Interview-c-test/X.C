
#include<math.h>
main()
{
	double (*x[10])(),(*m)();
	char *p1="name";
	char *p2,*p3,*p4;
	p2=(char*)malloc(20);
	x[0]=&tan;
	m=&sin;
	clrscr(),printf("--%f--%f--\n",(*x[0])(0.678),(*m)(.343));
	memset (p2, 0, 20);
	p3=p1,p4=p2;
	while(*p2++=*p1++);
	printf("\n%d %d %d %d %s\n",p3,p1,p4,p2,p2),getch();
}
