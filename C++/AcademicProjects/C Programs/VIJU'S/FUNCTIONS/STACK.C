//-----------Stack using array-------------//

#include<stdio.h>
int a[15],n,t=-1;

void main()
{
   extern void push(),pop(),display();
   int w=1;
   clrscr();

   printf("Enter the size of the stack:");
   scanf("%d",&n);
   while(w!=4)
   {
	   printf("\nEnter 1-to push,2-for pop,3-for display,4-for exit:");
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
//-----------function for inserting an item
void push()
{
   int num;

   if(t==n-1) printf("\nStack is full:\n");
   else
   {	printf("\nEnter the no:");
		scanf("%d",&num);
		a[++t]=num;
   }
   return;
}
//----------function for deleting an item
void pop()
{
   if(t==-1) printf("Stack is empty:\n");
   else printf("\nNumber deleted is %d\n",a[t--]);
   return;
}
//----------function for displaying the stack
void display()
{
   int i;

   if(t==-1) printf("\nStack is empty:\n");
   else
   {
	  clrscr();
	  printf("Stack is:\n\n");
	  for(i=t;i>=0;i--)
		  printf("<--%d",a[i]);
   }
   printf("\n");
   return;
}
