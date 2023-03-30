#include "\tc\bin\viju's\file\inc3.c"



void main()
{
char x[20],y[20];

clrscr();
printf("\n\nCHECKING FILES FOR EQUALITY\n\n");
printf("\n\n\tEnter name of file1:"),
flushall(),scanf("%s",x);
printf("\n\n\tEnter name of file2:"),
flushall(),scanf("%s",y);
if(filesequal(x,y)) printf("\nFiles %s & %s are similar",x,y);
else                printf("\nFiles %s & %s are NOT similar",x,y);
getch();
}