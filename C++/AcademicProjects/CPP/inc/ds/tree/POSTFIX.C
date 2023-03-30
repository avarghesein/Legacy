

//--------------postfix to binarytree-----------//

#include "\tc\bin\ds\tree\2inc.c"


void main()
{
char m[50],y[50];
tree root=0;
clrscr();

printf("Enter the infix expression:"),flushall();
scanf("%s",m);
topostfix(m,y);

root=maketreefrompostfix(y);

clrscr();
	printf("\n\nEntered expression\t%s",m);
	printf("\n\nPreorder traversal\t"),pretrav(root,1);
	printf("\n\nInorder traversal\t"),intrav(root,1);
	printf("\n\nPostorder traversal\t"),posttrav(root,1);

getch();
}


