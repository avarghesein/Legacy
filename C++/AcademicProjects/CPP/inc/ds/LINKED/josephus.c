
//-------------Josephus problem----------//


#include"\tc\bin\ds\inc\link\circular.c"

void main()
{
node head=0,temp;
item x;
int i,j,sno,rno;

clrscr();
printf("Enter nuber of students:"),scanf("%d",&sno);
printf("\n\nEnter the random number:"),scanf("%d",&rno);

for(i=sno;i>=1;i--)
	x.no=i,x.po=0,head=cinsfront(head,x);


temp=head;

while(head!=0&&head->po!=head)
{
	i=1,j=temp->no;
	while(i<rno)
		 ++i,temp=temp->po,j=temp->no;

	if(temp==head||temp->po==head) temp=head=cdelete(head,j);
	else temp=temp->po,head=cdelete(head,j);
}

if(head!=0)printf("\n\nLucky student's roll no=%d",head->no); else
		   printf("\n\nError!!! Number of student=0");

free(head),getch();
}
