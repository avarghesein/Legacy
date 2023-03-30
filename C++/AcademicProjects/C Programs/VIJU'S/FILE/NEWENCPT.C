#include "\tc\bin\viju's\file\inc3.c"



void main()
{
char x[20],y[20],code[20];

clrscr();
printf("\n\n\tEnter the file to encode:"),flushall(),scanf("%s",x);
printf("\n\n\tEnter the code for encryption:"),flushall(),scanf("%s",code);
printf("\n\tEnter file save the encoded text:"),flushall(),scanf("%s",y);
encriptnew(x,y,code);
printf("\n\nSuccess,encoded file %s to file %s",x,y);
getch();
}