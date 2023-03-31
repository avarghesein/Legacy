

#include "\tc\bin\ds\tree\3inc.c"


void inorder(tree root,int flag)
{
	if(root!=0)
	{
		inorder(root->left,flag);

		flag==0?printf("<--%d",root->inf.num):
		flag==1?printf("%c",root->inf.ch):printf("<--%f",root->inf.dec);

		printf("[%d]",root->bal);

		inorder(root->right,flag);
	}
	else return;
}



void main()
{
tree head=0;
int num=0;
clrscr();

while(num!=-999)
{
	printf("\nEnter number,-999 for ending:"),scanf("%d",&num);
	if(num!=-999) insert_balance(&head,num),clrscr(),inorder(head,0);
}


}

