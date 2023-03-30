/*------QUEUE WITH CYCLIC DATA ENTERING-----*/

#include<stdio.h>

int a[15],f=-1,r=-1,n;
void main()
{
void ins(),del(),disp();
int w=1;
clrscr();
printf("Enter the size of the queue:\n");
scanf("%d",&n);
while(w!=4)
{
printf("1-insert,2-delete,3-display,4-exit\n");
scanf("%d",&w);
switch(w)
  {	case 1:ins();
		  break;
	case 2:del();
     	  break;
     case 3:disp();

  }
}

}

void ins()
{
void insspe();
int num;

if(f!=0&&r==n-1) insspe();
else if(f==0&&r==n-1) printf("Queue is full:\n");
else
{	printf("Enter no:\n");
	scanf("%d",&num);
     a[++r]=num;
     if(f==-1) f=0;
}
}
void del()
{	if(f==-1) printf("Queue is empty:\n");
	else
     {	printf("%d\n",a[f]);
     	if(f==r) f=r=-1;
          else f++;
	}
}

void disp()
{	int i;
if(f==-1||r==-1) printf("Queue is empty:\n");
else
  {   clrscr();
  	for(i=f;i<=r;i++) printf("%d\n",a[i]);
  }
}

void insspe()
{	int i;
for(i=f;i<=r;i++) a[i-1]=a[i];
f--;
printf("Enter no:\n");
scanf("%d",&a[r]);
}