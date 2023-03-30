#include<stdio.h>
int a[15],n=10,t=-1;

void main()
{
void push(),pop(),display();
int w=1;
clrscr();

printf("Enter the size of the stack:\n");
scanf("%d",&n);
while(w!=4)
 {
	printf("\npush-1,pop-2,display-3,exit-4\n");
	scanf("%d",&w);
	switch(w)
	{	case 1:push();
		  	  break;
		case 2:pop();
     	  	  break;
     	case 3:display();
	}
 }
}

void push()
{
int num;

if(t==n-1) printf("Stack is full:\n");
else
{	printf("Enter the no:\n");
	scanf("%d",&num);
     a[++t]=num;
}
return;
}

void pop()
{
if(t==-1) printf("Stack is empty:\n");
else printf("No deleted is %d\n",a[t--]);
return;
}

void display()
{
int i;

if(t==-1) printf("Stack is empty:\n");
else
 {
	clrscr();
	printf("Stack is:\n");
	for(i=0;i<=t;i++) printf("%d\n",a[i]);
 }
return;
}
