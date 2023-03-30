#include<stdio.h>
#include<math.h>
void main()
{
	int s,e,i,j;
     clrscr();
	printf("Enter the range:\n");
     scanf("%d%d",&s,&e);
     printf("\nThe prime nos between %d & %d are:\n\n",s,e);
     i=s;
     do
     {
          if(i==2)printf("%d\n",i);
     	j=2;
          do
          { 	if(i%j==0)goto h;
            	j++;
          }
		while(j<=i-1);
          printf("%d\n",i);
          h:
          i++;
     }
	while(i<=e);
     getch();
}
