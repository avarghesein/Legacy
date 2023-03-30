#include"\tc\bin\ds\inc\stackall.c"

void main()
{
info in;
stack s;

int i,j,n;
char *name;
clrscr();

s.top=-1;
printf("Enter string:\n");
scanf("%s",name);
n=strlen(name);

for(i=0;i<n;i++) in.c=name[i],push(in,&s);
for(i=0;i<n;i++) in=pop(&s),name[i]=in.c;

printf("Reversed string=%s",name);
getch();
}
