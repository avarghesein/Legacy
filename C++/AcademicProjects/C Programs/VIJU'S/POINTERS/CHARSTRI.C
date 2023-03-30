

void main()
{
char *name="initial",nam[25]="initial",*n[3]={"initial","2","3"};

clrscr();

name="new";

printf("Enter 3 names:\n");
scanf("%s %s %s",name,nam,n[0]);
printf("\n\n\n3 names are:\n\n%s\n%s\n%s",name,nam,n[0]);
getch();
}