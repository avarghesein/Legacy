/*--------Prime number generation with in a range-----------*/

#include<stdio.h>
void main()
{
  int s,e,i,j,f;
  clrscr();
  printf("Enter range:\n");
  scanf("%d%d",&s,&e);
  printf("\nPrime nos b/w %d & %d:\n",s,e);
  for(i=s;i<=e;i++)
  {
	  for(f=0,j=2;j<=i/2;j++)
			  if(i%j==0)
			  {	  f=1;
				  break;
			  }
	  if(f==0&&i>0) printf("%d\n",i);
  }
  getch();
}
