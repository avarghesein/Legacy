

#include "\tc\bin\viju's\file\inc2.c"




void main()
{
char *x,*y;

clrscr();
printf("\n\n\tEnter the file to encode:"),flushall(),scanf("%s",x);
printf("\n\tEnter file save the encoded text:"),flushall(),scanf("%s",y);
coded_encoded(x,y);
printf("\n\nSuccess,encoded file %s to file %s",x,y);
getch();
}