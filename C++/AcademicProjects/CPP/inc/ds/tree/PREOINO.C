
#include <string.h>
#include "\tc\bin\ds\tree\2inc.c"

info l;
char pre[50],ino[50];



void main()
{
extern void treefrompreoino(tree,int,int,int,int);
char x[50],y[50];
tree root=0;

clrscr();
printf("\nEnter preorder:"),flushall(),scanf("%s",pre);
printf("\nEnter inorder:"),flushall(),scanf("%s",ino);

if(strlen(pre)==0||strlen(ino)==0) printf("\nError"),exit();

l.ch=pre[0],root=makeroot(l);

treefrompreoino(root,0,strlen(pre)-1,0,strlen(ino)-1);

pretraversal(root,x),intraversal(root,y);


printf("\npreorder:%s\ninorder:%s",x,y);

if(strcmp(pre,x)==0&&strcmp(ino,y)==0)
	printf("\n\n\tThe tree maked is correct");
else
	printf("\n\nTree is not proper(error in entered pre/in orders)");

getch();
}


void treefrompreoino(tree head,int p1,int p2,int i1,int i2)
{
int k,i11=i1,i12,i21,i22=i2;
int p11=p1+1,p12,p21,p22;

for(k=i1;k<=i2;k++) if(ino[k]==head->inf.ch) break;

	if(k>i2) return;  //---------test1  ---------//

i12=k-1,i21=k+1,p12=p11+i12-i11,p21=p12+1,p22=p21+i22-i21;

	if(p22>p2) return;  //------test2     ----//
						//-------test1 & 2 can be omitted  ---//
if(i11<=i12)
{	l.ch=pre[p11],setleftson(head,l);
	if(i11<i12) treefrompreoino(head->left,p11,p12,i11,i12);
}

if(i21<=i22)
{	l.ch=pre[p21],setrightson(head,l);
	if(i21<i22) treefrompreoino(head->right,p21,p22,i21,i22);
}

return;
}
