
struct list
{
int a,b,c;
float d;
char  e[10];
int  f:3,g:7;
}s={1,2,3,4,"abru",3,5};

void main()
{
clrscr();
printf("%d\n%d\n%d\n%f\n%s\n%d\n%d",s.a,s.b,s.c,s.d,s.e,s.f,s.g);
getch();
}