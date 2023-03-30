#include "\tc\bin\viju's\file\inc3.c"



void main()
{
char x[20],y[20],code[20];

clrscr();
printf("\n\n\tEnter the file to decode:"),flushall(),scanf("%s",x);
printf("\n\n\tEnter the code for decryption:"),flushall(),scanf("%s",code);
printf("\n\tEnter file save the decoded text:"),flushall(),scanf("%s",y);
decriptnew(x,y,code);
printf("\n\nSuccess,decoded file %s to file %s",x,y);
getch();
}