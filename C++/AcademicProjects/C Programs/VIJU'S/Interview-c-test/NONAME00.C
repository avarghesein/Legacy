
void main()
{
int x[10][10];
char *y="abraham";
clrscr();
printf("%d\n%d\n%d\n",sizeof(x),sizeof(*x),sizeof(**x));
printf("\n\n%d\n%d\n",sizeof(y),sizeof(*y));
getch();
}