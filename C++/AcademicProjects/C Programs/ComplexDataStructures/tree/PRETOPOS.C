
#include "\tc\bin\ds\tree\2inc.c"

void main()
{
char x[25],u[25],v[25],w[25];
tree root=0;


clrscr();
printf("\nEnter the infix expression:"),flushall(),scanf("%s",x);
toprefix(x,u);

root=maketreefromprefix(u);

pretraversal(root,u);
intraversal(root,v);
posttraversal(root,w);

clrscr();
printf("\n\n\tEntered expression:%s",x);
printf("\n\n\tPrefix expression:%s",u);
printf("\n\n\tPostfix expression:%s",w);
printf("\n\n\tInfix expression:%s",v);
getch();
}
