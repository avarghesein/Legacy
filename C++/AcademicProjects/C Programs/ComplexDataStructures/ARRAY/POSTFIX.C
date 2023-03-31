#include "\tc\bin\ds\inc\postfix.c"

void main()
{
char s[25],p[25];
clrscr();

printf("\nEnter expression:\n");
scanf("%s",s);
if(expcorrect(s)==0) printf("\n\nError in expression"),getch(),exit(1);
topostfix(s,p);
printf("\n\nPostfix expression:\n\n%s\n\n",p);
printf("\n\nVale of expression=%f",evaluatepostfix(p));
getch();
}