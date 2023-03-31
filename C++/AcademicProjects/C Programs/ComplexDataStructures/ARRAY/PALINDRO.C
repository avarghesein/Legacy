#include"\tc\bin\ds\\inc\stackc.c"

void main()
{
stk s;
int i,j,n;
char *name;

clrscr();

s.top=-1;
printf("Enter string:\n");
scanf("%s",name);
n=strlen(name);

for(i=0;i<n/2;i++) push(name[i],&s);

if(n%2==1)i++;

for(j=i;j<n;j++)
	if(pop(&s)!=name[j])
		printf("Not Palindrome:\n"),getch(),exit(1);

printf("\n\n\nPalindrome:\n");
getch();
}
