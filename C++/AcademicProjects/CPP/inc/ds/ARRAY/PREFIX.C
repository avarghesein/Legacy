#include "\tc\bin\ds\inc\prefix.c"

void main()
{
char s[25],p[25];
clrscr();

printf("\nEnter expression:\n");
scanf("%s",s);
if(expcorrect(s)==0) printf("\n\nError in expression"),getch(),exit(1);
toprefix(s,p);
printf("\n\nPrefix expression:\n\n%s",p);
printf("\n\nVale of expression=%f",evaluateprefix(p));
getch();
}